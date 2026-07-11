#! /usr/bin/env bash

PROJECT="searxng"
VERBOSE="false"
CMD="start"

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
	docker compose -p searxng up
}

stop() {
	docker compose -p searxng down
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
