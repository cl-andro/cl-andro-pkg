clandro_step_patch_package() {
	[ "$CLANDRO_PKG_METAPACKAGE" = "true" ] && return

	cd "$CLANDRO_PKG_SRCDIR"
	# Suffix patch with ".patch32" or ".patch64" to only apply for
	# these bitnesses
	local PATCHES=$(find $CLANDRO_PKG_BUILDER_DIR -mindepth 1 -maxdepth 1 \
			     -name \*.patch -o -name \*.patch$CLANDRO_ARCH_BITS | sort)
	local DEBUG_PATCHES=""
	if [ "$CLANDRO_DEBUG_BUILD" = "true" ]; then
		DEBUG_PATCHES=$(find $CLANDRO_PKG_BUILDER_DIR -mindepth 1 -maxdepth 1 -name \*.patch.debug | sort)
	fi
	local ON_DEVICE_PATCHES=""
	# .patch.ondevice patches should only be applied when building
	# on device
	if [ "$CLANDRO_ON_DEVICE_BUILD" = "true" ]; then
		ON_DEVICE_PATCHES=$(find $CLANDRO_PKG_BUILDER_DIR -mindepth 1 -maxdepth 1 -name \*.patch.ondevice | sort)
	fi
	shopt -s nullglob
	for patch in $PATCHES $DEBUG_PATCHES $ON_DEVICE_PATCHES; do
		echo "Applying patch: $(basename $patch)"
		test -f "$patch" && sed \
			-e "s%\@CLANDRO_APP_PACKAGE\@%${CLANDRO_APP_PACKAGE}%g" \
			-e "s%\@CLANDRO_BASE_DIR\@%${CLANDRO_BASE_DIR}%g" \
			-e "s%\@CLANDRO_CACHE_DIR\@%${CLANDRO_CACHE_DIR}%g" \
			-e "s%\@CLANDRO_HOME\@%${CLANDRO_ANDROID_HOME}%g" \
			-e "s%\@CLANDRO_PREFIX\@%${CLANDRO_PREFIX}%g" \
			-e "s%\@CLANDRO_PREFIX_CLASSICAL\@%${CLANDRO_PREFIX_CLASSICAL}%g" \
			-e "s%\@CLANDRO_ENV__S_CLANDRO\@%${CLANDRO_ENV__S_CLANDRO}%g" \
			-e "s%\@CLANDRO_ENV__S_CLANDRO_APP\@%${CLANDRO_ENV__S_CLANDRO_APP}%g" \
			-e "s%\@CLANDRO_ENV__S_CLANDRO_API_APP\@%${CLANDRO_ENV__S_CLANDRO_API_APP}%g" \
			-e "s%\@CLANDRO_ENV__S_CLANDRO_ROOTFS\@%${CLANDRO_ENV__S_CLANDRO_ROOTFS}%g" \
			-e "s%\@CLANDRO_ENV__S_CLANDRO_EXEC\@%${CLANDRO_ENV__S_CLANDRO_EXEC}%g" \
			"$patch" | patch --silent -p1
	done
	shopt -u nullglob
}
