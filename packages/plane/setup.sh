VERSION=@VERSION@
BRANCH=${BRANCH:-master}
ASSET_DIR=@ASSET_DIR@
COMPOSE_PROJECT_NAME=plane-app
PLANE_INSTALL_DIR=$PWD/$COMPOSE_PROJECT_NAME
export APP_RELEASE=$VERSION
export DOCKERHUB_USER=makeplane
export PULL_POLICY=${PULL_POLICY:-if_not_present}
export GH_REPO=makeplane/plane
export RELEASE_DOWNLOAD_URL="https://github.com/$GH_REPO/releases/download"
export FALLBACK_DOWNLOAD_URL="https://raw.githubusercontent.com/$GH_REPO/$BRANCH/deployments/cli/community"

CPU_ARCH=$(uname -m)
OS_NAME=$(uname)
UPPER_CPU_ARCH=$(tr '[:lower:]' '[:upper:]' <<<"$CPU_ARCH")

mkdir -p $PLANE_INSTALL_DIR/archive
DOCKER_FILE_PATH="$ASSET_DIR/docker-compose.yaml"
DOCKER_ENV_PATH="$ASSET_DIR/plane.env"

function print_header() {
	:
}

function spinner() {
	:
}

function initialize() {
	printf "Please wait while we check the availability of Docker images for the selected release ($APP_RELEASE) with ${UPPER_CPU_ARCH} support." >&2

	if [ "$CUSTOM_BUILD" == "true" ]; then
		echo "" >&2
		echo "" >&2
		echo "${UPPER_CPU_ARCH} images are not available for selected release ($APP_RELEASE)." >&2
		echo "build"
		return 1
	fi

	local IMAGE_NAME=makeplane/plane-proxy
	local IMAGE_TAG=${APP_RELEASE}
	docker manifest inspect "${IMAGE_NAME}:${IMAGE_TAG}" | grep -q "\"architecture\": \"${CPU_ARCH}\"" &
	local pid=$!
	spinner "$pid"

	echo "" >&2

	wait "$pid"

	if [ $? -eq 0 ]; then
		echo "Plane supports ${CPU_ARCH}" >&2
		echo "available"
		return 0
	else
		echo "" >&2
		echo "" >&2
		echo "${UPPER_CPU_ARCH} images are not available for selected release ($APP_RELEASE)." >&2
		echo "" >&2
		echo "build"
		return 1
	fi
}
function getEnvValue() {
	:
}
function updateEnvFile() {
	:
}

function updateCustomVariables() {
	:
}

function syncEnvFile() {
	:
}

function buildYourOwnImage() {
	echo "Building images locally..."

	export DOCKERHUB_USER="myplane"
	export APP_RELEASE="local"
	export PULL_POLICY="never"
	CUSTOM_BUILD="true"

	# checkout the code to ~/tmp/plane folder and build the images
	local PLANE_TEMP_CODE_DIR=~/tmp/plane
	rm -rf $PLANE_TEMP_CODE_DIR
	mkdir -p $PLANE_TEMP_CODE_DIR
	REPO=https://github.com/$GH_REPO.git
	git clone "$REPO" "$PLANE_TEMP_CODE_DIR" --branch "$BRANCH" --single-branch --depth 1

	cp "$PLANE_TEMP_CODE_DIR/deployments/cli/community/build.yml" "$PLANE_TEMP_CODE_DIR/build.yml"

	cd "$PLANE_TEMP_CODE_DIR" || exit

	bash -c "$COMPOSE_CMD -f build.yml build --no-cache" >&2
	if [ $? -ne 0 ]; then
		echo "Build failed. Exiting..."
		exit 1
	fi
	echo "Build completed successfully"
	echo ""
	echo "You can now start the services by running the command: ./setup.sh start"
	echo ""
}

function install() {
	:
}

function download() {
	:
}
function startServices() {
	bash -c "$COMPOSE_CMD -f $DOCKER_FILE_PATH --env-file=$DOCKER_ENV_PATH up -d --pull if_not_present --quiet-pull"

	local migrator_container_id=$(docker container ls -aq -f "name=$COMPOSE_PROJECT_NAME-migrator")
	if [ -n "$migrator_container_id" ]; then
		local idx=0
		while docker inspect --format='{{.State.Status}}' $migrator_container_id | grep -q "running"; do
			local message=">> Waiting for Data Migration to finish"
			local dots=$(printf '%*s' $idx | tr ' ' '.')
			echo -ne "\r$message$dots"
			((idx++))
			sleep 1
		done
	fi
	printf "\r\033[K"
	echo ""
	echo "   Data Migration completed successfully ✅"

	# if migrator exit status is not 0, show error message and exit
	if [ -n "$migrator_container_id" ]; then
		local migrator_exit_code=$(docker inspect --format='{{.State.ExitCode}}' $migrator_container_id)
		if [ $migrator_exit_code -ne 0 ]; then
			echo "Plane Server failed to start ❌"
			# stopServices
			echo
			echo "Please check the logs for the 'migrator' service and resolve the issue(s)."
			echo "Stop the services by running the command: ./setup.sh stop"
			exit 1
		fi
	fi

	local api_container_id=$(docker container ls -q -f "name=$COMPOSE_PROJECT_NAME-api")

	# Verify container exists
	if [ -z "$api_container_id" ]; then
		echo "   Error: API container not found. Please check if services are running."
		exit 1
	fi

	local idx2=0
	local api_ready=true    # assume success, flip on timeout
	local max_wait_time=300 # 5 minutes timeout
	local start_time=$(date +%s)

	echo "   Waiting for API Service to be ready..."
	while ! docker exec "$api_container_id" python3 -c "import urllib.request; urllib.request.urlopen('http://localhost:8000/', timeout=3)" >/dev/null 2>&1; do
		local current_time=$(date +%s)
		local elapsed_time=$((current_time - start_time))

		if [ $elapsed_time -gt $max_wait_time ]; then
			echo ""
			echo "   API Service health check timed out after 5 minutes"
			echo "   Checking if API container is still running..."
			if docker ps | grep -q "$COMPOSE_PROJECT_NAME-api"; then
				echo "   API container is running but did not pass the health-check. Continuing without marking it ready."
				api_ready=false
				break
			else
				echo "   API container is not running. Please check logs."
				exit 1
			fi
		fi

		local message=">> Waiting for API Service to Start (${elapsed_time}s)"
		local dots=$(printf '%*s' $idx2 | tr ' ' '.')
		echo -ne "\r$message$dots"
		((idx2++))
		sleep 1
	done
	printf "\r\033[K"
	if [ "$api_ready" = true ]; then
		echo "   API Service started successfully ✅"
	else
		echo "   ⚠️  API Service did not respond to health-check – please verify manually."
	fi
	source "${DOCKER_ENV_PATH}"
	echo "   Plane Server started successfully ✅"
	echo ""
	echo "   You can access the application at $WEB_URL"
	echo ""

}
function stopServices() {
	bash -c "$COMPOSE_CMD -f $DOCKER_FILE_PATH --env-file=$DOCKER_ENV_PATH down"
}
function restartServices() {
	stopServices
	startServices
}
function upgrade() {
	echo "NOT SUPPORTED"
	exit 1
}
function viewSpecificLogs() {
	local SERVICE_NAME=$1

	if bash -c "$COMPOSE_CMD -f $DOCKER_FILE_PATH ps | grep -q '$SERVICE_NAME'"; then
		echo "Service '$SERVICE_NAME' is running."
	else
		echo "Service '$SERVICE_NAME' is not running."
	fi

	bash -c "$COMPOSE_CMD -f $DOCKER_FILE_PATH logs -f $SERVICE_NAME"
}
function viewLogs() {

	ARG_SERVICE_NAME=$2

	if [ -z "$ARG_SERVICE_NAME" ]; then
		echo
		echo "Select a Service you want to view the logs for:"
		echo "   1) Web"
		echo "   2) Space"
		echo "   3) API"
		echo "   4) Worker"
		echo "   5) Beat-Worker"
		echo "   6) Migrator"
		echo "   7) Proxy"
		echo "   8) Redis"
		echo "   9) Postgres"
		echo "   10) Minio"
		echo "   11) RabbitMQ"
		echo "   0) Back to Main Menu"
		echo
		read -p "Service: " DOCKER_SERVICE_NAME

		until ((DOCKER_SERVICE_NAME >= 0 && DOCKER_SERVICE_NAME <= 11)); do
			echo "Invalid selection. Please enter a number between 0 and 11."
			read -p "Service: " DOCKER_SERVICE_NAME
		done

		if [ -z "$DOCKER_SERVICE_NAME" ]; then
			echo "INVALID SERVICE NAME SUPPLIED"
		else
			case $DOCKER_SERVICE_NAME in
			1) viewSpecificLogs "web" ;;
			2) viewSpecificLogs "space" ;;
			3) viewSpecificLogs "api" ;;
			4) viewSpecificLogs "worker" ;;
			5) viewSpecificLogs "beat-worker" ;;
			6) viewSpecificLogs "migrator" ;;
			7) viewSpecificLogs "proxy" ;;
			8) viewSpecificLogs "plane-redis" ;;
			9) viewSpecificLogs "plane-db" ;;
			10) viewSpecificLogs "plane-minio" ;;
			11) viewSpecificLogs "plane-mq" ;;
			0) askForAction ;;
			*) echo "INVALID SERVICE NAME SUPPLIED" ;;
			esac
		fi
	elif [ -n "$ARG_SERVICE_NAME" ]; then
		ARG_SERVICE_NAME=$(echo "$ARG_SERVICE_NAME" | tr '[:upper:]' '[:lower:]')
		case $ARG_SERVICE_NAME in
		web) viewSpecificLogs "web" ;;
		space) viewSpecificLogs "space" ;;
		api) viewSpecificLogs "api" ;;
		worker) viewSpecificLogs "worker" ;;
		beat-worker) viewSpecificLogs "beat-worker" ;;
		migrator) viewSpecificLogs "migrator" ;;
		proxy) viewSpecificLogs "proxy" ;;
		redis) viewSpecificLogs "plane-redis" ;;
		postgres) viewSpecificLogs "plane-db" ;;
		minio) viewSpecificLogs "plane-minio" ;;
		rabbitmq) viewSpecificLogs "plane-mq" ;;
		*) echo "INVALID SERVICE NAME SUPPLIED" ;;
		esac
	else
		echo "INVALID SERVICE NAME SUPPLIED"
	fi
}
function backup_container_dir() {
	local BACKUP_FOLDER=$1
	local CONTAINER_NAME=$2
	local CONTAINER_DATA_DIR=$3
	local SERVICE_FOLDER=$4

	echo "Backing up $CONTAINER_NAME data..."
	local CONTAINER_ID=$(bash -c "$COMPOSE_CMD -f $DOCKER_FILE_PATH ps -q $CONTAINER_NAME")
	if [ -z "$CONTAINER_ID" ]; then
		echo "Error: $CONTAINER_NAME container not found. Make sure the services are running."
		return 1
	fi

	# Create a temporary directory for the backup
	mkdir -p "$BACKUP_FOLDER/$SERVICE_FOLDER"

	# Copy the data directory from the running container
	echo "Copying $CONTAINER_NAME data directory..."
	docker cp -q "$CONTAINER_ID:$CONTAINER_DATA_DIR/." "$BACKUP_FOLDER/$SERVICE_FOLDER/"
	local cp_status=$?

	if [ $cp_status -ne 0 ]; then
		echo "Error: Failed to copy $SERVICE_FOLDER data"
		rm -rf $BACKUP_FOLDER/$SERVICE_FOLDER
		return 1
	fi

	# Create tar.gz of the data
	cd "$BACKUP_FOLDER"
	tar -czf "${SERVICE_FOLDER}.tar.gz" "$SERVICE_FOLDER/"
	local tar_status=$?
	if [ $tar_status -eq 0 ]; then
		rm -rf "$SERVICE_FOLDER/"
	fi
	cd - >/dev/null

	if [ $tar_status -ne 0 ]; then
		echo "Error: Failed to create tar archive"
		return 1
	fi

	echo "Successfully backed up $SERVICE_FOLDER data"
}

function backupData() {
	local datetime=$(date +"%Y%m%d-%H%M")
	local BACKUP_FOLDER=$PLANE_INSTALL_DIR/backup/$datetime
	mkdir -p "$BACKUP_FOLDER"

	# Check if docker-compose.yml exists
	if [ ! -f "$DOCKER_FILE_PATH" ]; then
		echo "Error: docker-compose.yml not found at $DOCKER_FILE_PATH"
		exit 1
	fi

	backup_container_dir "$BACKUP_FOLDER" "plane-db" "/var/lib/postgresql/data" "pgdata" || exit 1
	backup_container_dir "$BACKUP_FOLDER" "plane-minio" "/export" "uploads" || exit 1
	backup_container_dir "$BACKUP_FOLDER" "plane-mq" "/var/lib/rabbitmq" "rabbitmq_data" || exit 1
	backup_container_dir "$BACKUP_FOLDER" "plane-redis" "/data" "redisdata" || exit 1

	echo ""
	echo "Backup completed successfully. Backup files are stored in $BACKUP_FOLDER"
	echo ""
}
function askForAction() {
	local DEFAULT_ACTION=$1

	if [ -z "$DEFAULT_ACTION" ]; then
		echo
		echo "Select a Action you want to perform:"
		echo "   1) Install"
		echo "   2) Start"
		echo "   3) Stop"
		echo "   4) Restart"
		echo "   5) Upgrade"
		echo "   6) View Logs"
		echo "   7) Backup Data"
		echo "   8) Exit"
		echo
		read -p "Action [2]: " ACTION
		until [[ -z "$ACTION" || "$ACTION" =~ ^[1-8]$ ]]; do
			echo "$ACTION: invalid selection."
			read -p "Action [2]: " ACTION
		done

		if [ -z "$ACTION" ]; then
			ACTION=2
		fi
		echo
	fi

	if [ "$ACTION" == "1" ] || [ "$DEFAULT_ACTION" == "install" ]; then
		install
		# askForAction
	elif [ "$ACTION" == "2" ] || [ "$DEFAULT_ACTION" == "start" ]; then
		startServices
		# askForAction
	elif [ "$ACTION" == "3" ] || [ "$DEFAULT_ACTION" == "stop" ]; then
		stopServices
		# askForAction
	elif [ "$ACTION" == "4" ] || [ "$DEFAULT_ACTION" == "restart" ]; then
		restartServices
		# askForAction
	elif [ "$ACTION" == "5" ] || [ "$DEFAULT_ACTION" == "upgrade" ]; then
		upgrade
		# askForAction
	elif [ "$ACTION" == "6" ] || [ "$DEFAULT_ACTION" == "logs" ]; then
		viewLogs "$@"
		askForAction
	elif [ "$ACTION" == "7" ] || [ "$DEFAULT_ACTION" == "backup" ]; then
		backupData
	elif [ "$ACTION" == "8" ]; then
		exit 0
	else
		echo "INVALID ACTION SUPPLIED"
	fi
}

# if docker-compose is installed
if command -v docker-compose &>/dev/null; then
	COMPOSE_CMD="docker-compose -p $COMPOSE_PROJECT_NAME"
else
	COMPOSE_CMD="docker compose -p $COMPOSE_PROJECT_NAME"
fi

if [ "$CPU_ARCH" == "x86_64" ] || [ "$CPU_ARCH" == "amd64" ]; then
	CPU_ARCH="amd64"
elif [ "$CPU_ARCH" == "aarch64" ] || [ "$CPU_ARCH" == "arm64" ]; then
	CPU_ARCH="arm64"
fi

# if [ -f "$DOCKER_ENV_PATH" ]; then
# 	DOCKERHUB_USER=$(getEnvValue "DOCKERHUB_USER" "$DOCKER_ENV_PATH")
# 	APP_RELEASE=$(getEnvValue "APP_RELEASE" "$DOCKER_ENV_PATH")
# 	PULL_POLICY=$(getEnvValue "PULL_POLICY" "$DOCKER_ENV_PATH")
# 	CUSTOM_BUILD=$(getEnvValue "CUSTOM_BUILD" "$DOCKER_ENV_PATH")

# 	if [ -z "$DOCKERHUB_USER" ]; then
# 		DOCKERHUB_USER=makeplane
# 		updateEnvFile "DOCKERHUB_USER" "$DOCKERHUB_USER" "$DOCKER_ENV_PATH"
# 	fi

# 	if [ -z "$APP_RELEASE" ]; then
# 		APP_RELEASE=stable
# 		updateEnvFile "APP_RELEASE" "$APP_RELEASE" "$DOCKER_ENV_PATH"
# 	fi

# 	if [ -z "$PULL_POLICY" ]; then
# 		PULL_POLICY=if_not_present
# 		updateEnvFile "PULL_POLICY" "$PULL_POLICY" "$DOCKER_ENV_PATH"
# 	fi

# 	if [ -z "$CUSTOM_BUILD" ]; then
# 		CUSTOM_BUILD=false
# 		updateEnvFile "CUSTOM_BUILD" "$CUSTOM_BUILD" "$DOCKER_ENV_PATH"
# 	fi
# fi

print_header
askForAction "$@"
