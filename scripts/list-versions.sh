#!/usr/bin/env bash

SCRIPT_DIR=$(dirname "$(realpath "$0")")
. "$SCRIPT_DIR"/properties.sh

check_package() { # path
	local path=$1
	local pkg=$(basename "$path")
	CLANDRO_PKG_REVISION=0
	CLANDRO_ARCH=aarch64
	. "$path"/build.sh
	if [ "$CLANDRO_PKG_REVISION" != "0" ] || [ "$CLANDRO_PKG_VERSION" != "${CLANDRO_PKG_VERSION/-/}" ]; then
		CLANDRO_PKG_VERSION+="-$CLANDRO_PKG_REVISION"
	fi
	echo "$pkg=$CLANDRO_PKG_VERSION"
}

for path in "${SCRIPT_DIR}"/../packages/*; do
(
	check_package "$path"
)
done
