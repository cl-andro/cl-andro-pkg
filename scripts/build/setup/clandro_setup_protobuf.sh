clandro_setup_protobuf() {
	local _PROTOBUF_VERSION=$(bash -c ". $CLANDRO_SCRIPTDIR/packages/libprotobuf/build.sh; echo \${CLANDRO_PKG_VERSION#*:}")
	local _PROTOBUF_SHA256=f3340e28a83d1c637d8bafdeed92b9f7db6a384c26bca880a6e5217b40a4328b
	local _PROTOBUF_ZIP="protoc-$_PROTOBUF_VERSION-linux-x86_64.zip"
	local _PROTOBUF_FOLDER

	if [ "${CLANDRO_PACKAGES_OFFLINE-false}" = "true" ]; then
		_PROTOBUF_FOLDER="${CLANDRO_SCRIPTDIR}/build-tools/protobuf-${_PROTOBUF_VERSION}"
	else
		_PROTOBUF_FOLDER="${CLANDRO_COMMON_CACHEDIR}/protobuf-${_PROTOBUF_VERSION}"
	fi

	if [ "$CLANDRO_ON_DEVICE_BUILD" = "false" ]; then
		if [ ! -d "$_PROTOBUF_FOLDER" ]; then
			clandro_download \
				"https://github.com/protocolbuffers/protobuf/releases/download/v$_PROTOBUF_VERSION/$_PROTOBUF_ZIP" \
				"$CLANDRO_PKG_TMPDIR/$_PROTOBUF_ZIP" \
				"$_PROTOBUF_SHA256"

			rm -Rf "$CLANDRO_PKG_TMPDIR/protoc-$_PROTOBUF_VERSION-linux-x86_64"
			unzip "$CLANDRO_PKG_TMPDIR/$_PROTOBUF_ZIP" -d "$CLANDRO_PKG_TMPDIR/protobuf-$_PROTOBUF_VERSION"
			mv "$CLANDRO_PKG_TMPDIR/protobuf-$_PROTOBUF_VERSION" \
				"$_PROTOBUF_FOLDER"
		fi

		export PATH="$_PROTOBUF_FOLDER/bin/:$PATH"
	fi
}
