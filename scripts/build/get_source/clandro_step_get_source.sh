clandro_step_get_source() {
	: "${CLANDRO_PKG_SRCURL:=""}"

	if [ "${CLANDRO_PKG_SRCURL:0:4}" == "git+" ]; then
		[ ! "$CLANDRO_QUIET_BUILD" = true ] && echo "Downloading $CLANDRO_PKG_NAME@$CLANDRO_PKG_VERSION git source from '$CLANDRO_PKG_SRCURL' if necessary..."
		clandro_git_clone_src
	else
		if [ -z "${CLANDRO_PKG_SRCURL}" ] || [ "${CLANDRO_PKG_SKIP_SRC_EXTRACT-false}" = "true" ] || [ "$CLANDRO_PKG_METAPACKAGE" = "true" ]; then
			mkdir -p "$CLANDRO_PKG_SRCDIR"
			return
		fi
		[ ! "$CLANDRO_QUIET_BUILD" = true ] && echo "Downloading $CLANDRO_PKG_NAME@$CLANDRO_PKG_VERSION source from '$CLANDRO_PKG_SRCURL' if necessary..."
		clandro_download_src_archive
		cd $CLANDRO_PKG_TMPDIR
		clandro_extract_src_archive
	fi
}
