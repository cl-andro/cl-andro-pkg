CLANDRO_SUBPKG_DESCRIPTION="Swift runtime libraries for Android armv7"
CLANDRO_SUBPKG_INCLUDE="opt/ndk-multilib/arm-linux-androideabi/lib/lib[_FTXs]*.so"
CLANDRO_SUBPKG_PLATFORM_INDEPENDENT=true
CLANDRO_SUBPKG_DEPEND_ON_PARENT=false
CLANDRO_SUBPKG_DEPENDS="ndk-multilib"

clandro_step_create_subpkg_debscripts() {
	local file
	for file in postinst prerm; do
		sed -e "s|@CLANDRO_PREFIX@|${CLANDRO_PREFIX}|g" \
			-e "s|@CLANDRO_PACKAGE_FORMAT@|${CLANDRO_PACKAGE_FORMAT}|g" \
			-e "s|@SWIFT_TRIPLE@|arm-linux-androideabi|g" \
			$CLANDRO_PKG_BUILDER_DIR/trigger-header > "${file}"
	done
	sed 's|@COMMAND@|ln -sf "'$CLANDRO_PREFIX'/opt/ndk-multilib/arm-linux-androideabi/lib/lib$so.so" "$install_path"|' \
		$CLANDRO_PKG_BUILDER_DIR/trigger-command >> postinst
	sed 's|@COMMAND@|rm -f "$install_path/lib$so.so"|' \
		$CLANDRO_PKG_BUILDER_DIR/trigger-command >> prerm
	chmod 0700 postinst prerm
}
