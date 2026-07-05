#! /usr/bin/env bash

failure() {
	local msg=$1
	echo "${msg}" >&2
	exit 1
}
