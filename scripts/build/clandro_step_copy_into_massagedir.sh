clandro_step_copy_into_massagedir() {
	local DEST="$CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX_CLASSICAL"
	mkdir -p "$DEST"
	# Copy files changed during the build into massagedir in order to massage them
	tar -C "$CLANDRO_PREFIX_CLASSICAL" -N "$CLANDRO_BUILD_TS_FILE" --exclude='tmp' --exclude='__pycache__' -cf - . | \
		tar -C "$DEST" -xf -
}
