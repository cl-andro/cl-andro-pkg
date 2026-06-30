clandro_step_install_pacman_hooks() {
	[[ "$CLANDRO_PACKAGE_FORMAT" != "pacman" ]] && return

	local sed="sed -e s|@CLANDRO_PREFIX@|${CLANDRO_PREFIX}|g -e s|@CLANDRO_PREFIX_TARGET@|${CLANDRO_PREFIX:1}|g -e s|@CLANDRO_ARCH@|${CLANDRO_ARCH}|g"

	# Installing hooks
	local hooks
	hooks=$(find $CLANDRO_PKG_BUILDER_DIR -mindepth 1 -maxdepth 1 -name "*.alpm.hook")
	if [[ -n "${hooks}" ]]; then
		mkdir -p ${CLANDRO_PREFIX}/share/libalpm/hooks
		local hook
		for hook in ${hooks}; do
			${sed} "${hook}" > "${CLANDRO_PREFIX}/share/libalpm/hooks/$(sed 's|.alpm.hook$|.hook|' <<< "${hook##*/}")"
		done
	fi

	# Installing scripts
	local scripts
	scripts=$(find $CLANDRO_PKG_BUILDER_DIR -mindepth 1 -maxdepth 1 -name "*.alpm.script")
	if [[ -n "${scripts}" ]]; then
		mkdir -p ${CLANDRO_PREFIX}/share/libalpm/scripts
		local script script_alpm
		for script in ${scripts}; do
			script_alpm="${CLANDRO_PREFIX}/share/libalpm/scripts/$(sed 's|.alpm.script$||' <<< "${script##*/}")"
			${sed} "${script}" > "${script_alpm}"
			chmod +x "${script_alpm}"
		done
	fi
}
