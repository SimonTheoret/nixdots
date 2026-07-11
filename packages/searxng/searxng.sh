PROJECT="searxng"
VERBOSE="false"
CMD="start"
DOCKER_COMPOSE=@DOCKER@

usage() {
	echo "Usage: $0 [OPTIONS] <CMD>"
	echo
	echo "Options:"
	echo "  -v, --verbose    Enable verbose output"
	echo
	echo "CMD:"
	echo "  -h, --help    Show this help message and exit"
	exit 1
}

start() {
	docker compose -p searxng -f $DOCKER_COMPOSE up
}

stop() {
	docker compose -p searxng -f $DOCKER_COMPOSE down
}

if [[ $# -eq 0 ]]; then
	usage
fi

while [[ $# -gt 0 ]]; do
	case "$1" in
	-h | --help)
		CMD="help"
		break
		;;
	-v | --verbose)
		VERBOSE=true
		set -x
		shift
		;;
	*)
		CMD=$1
		shift
		;;
	esac
done

if [[ "$CMD" == "start" ]]; then
	if [[ $VERBOSE == "true" ]]; then
		echo "Starting projet $PROJECT"
	fi
	start
elif [[ "$CMD" == "stop" ]]; then
	if [[ $VERBOSE == "true" ]]; then
		echo "Stopping projet $PROJECT"
	fi
	stop
elif [[ "$CMD" == "help" ]]; then
	usage
fi
