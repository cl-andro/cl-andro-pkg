clandro_step_get_dependencies_python() {
	if [ "$CLANDRO_PKG_SETUP_PYTHON" = "true" ]; then
		# python pip setup
		clandro_setup_python_pip

		# installing python modules
		LDFLAGS+=" -Wl,--as-needed,-lpython${CLANDRO_PYTHON_VERSION}"
		local pip
		local pip_pkgs="$CLANDRO_PKG_PYTHON_COMMON_BUILD_DEPS, "
		if [ "$CLANDRO_ON_DEVICE_BUILD" = "true" ]; then
			pip="pip3"
			pip_pkgs+="$CLANDRO_PKG_PYTHON_TARGET_DEPS"
		else
			pip="build-pip"
			pip_pkgs+="$CLANDRO_PKG_PYTHON_CROSS_BUILD_DEPS"
		fi
		for i in ${pip_pkgs//, / } ; do
			local name_python_module=$(sed "s/<=/ /; s/>=/ /; s/</ /; s/>/ /; s/'//g" <<< "$i" | awk '{printf $1}')
			local name_python_module_termux=$(grep 'python-' <<< "$name_python_module" || echo "python-$name_python_module")
			[ ! "$CLANDRO_QUIET_BUILD" = true ] && echo "Installing the dependency python module $i if necessary..."
			if $pip show "$i" &>/dev/null && ([ "$CLANDRO_FORCE_BUILD_DEPENDENCIES" = "false" ] || clandro_check_package_in_built_packages_list "$name_python_module_termux"); then
				[ ! "$CLANDRO_QUIET_BUILD" = true ] && echo "Skipping the already installed dependency python module $i"
				continue
			fi
			bash -c "$pip install "$(test "${CLANDRO_FORCE_BUILD_DEPENDENCIES}" = "true" && echo "-I" || true)" $i"
			[ "$CLANDRO_FORCE_BUILD_DEPENDENCIES" = "true" ] && clandro_add_package_to_built_packages_list "$name_python_module_termux"
		done

		# adding and setting values ​​to work properly with python modules
		export PYTHONPATH="${CLANDRO_PYTHON_CROSSENV_BUILDHOME}:${CLANDRO_PYTHON_HOME}/site-packages"
		if [ "$CLANDRO_ON_DEVICE_BUILD" = "false" ]; then
			export CLANDRO_PYTHON_MAINPATH="${PYTHONPATH}:${CLANDRO_PYTHON_CROSSENV_BUILDHOME}/site-packages"
		fi
		export PYTHON_SITE_PKG=$PYTHONPATH
	fi
}
