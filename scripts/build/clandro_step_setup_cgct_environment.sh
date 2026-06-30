# Installing packages if necessary for the full operation of CGCT (main use: not in Clandro devices).

clandro_step_setup_cgct_environment() {
	[ "$CLANDRO_ON_DEVICE_BUILD" = "true" ] && return

	clandro_install_temporary_glibc
	clandro_set_links_to_libgcc_of_cgct

	if [ "$CLANDRO_PKG_BUILD_MULTILIB" = "true" ]; then
		(
			clandro_conf_multilib_vars
			clandro_install_temporary_glibc
			clandro_set_links_to_libgcc_of_cgct
		)
	fi
}

# The temporary glibc is a glibc used only during compilation of simple packages
# or a full glibc that will be customized for the system and replace the temporary glibc.
clandro_install_temporary_glibc() {
	local PKG="glibc"
	local multilib_glibc=false
	if [ "$CLANDRO_ARCH" != "$CLANDRO_REAL_ARCH" ]; then
		multilib_glibc=true
		PKG+="32"
	fi

	# Checking if temporary glibc needs to be installed.
	if [ -f "$CLANDRO_BUILT_PACKAGES_DIRECTORY/$PKG-temporary-for-cgct" ]; then
		return
	fi
	local PKG_DIR=$(ls ${CLANDRO_SCRIPTDIR}/*/${PKG}/build.sh 2> /dev/null || \
		ls ${CLANDRO_SCRIPTDIR}/*/${PKG}/build.sh 2> /dev/null)
	if [ -n "$PKG_DIR" ]; then
		read -r DEP_ARCH DEP_VERSION DEP_VERSION_PAC _ < <(clandro_extract_dep_info $PKG "${PKG_DIR/'/build.sh'/}")
		if clandro_package__is_package_version_built "$PKG" "$DEP_VERSION"; then
			return
		fi
	fi

	[ ! "$CLANDRO_QUIET_BUILD" = "true" ] && echo "Installing temporary '${PKG}' for the CGCT tool environment."

	local PREFIX_TMP_GLIBC="data/data/com.zk.clandro/files/usr/glibc"
	local PATH_TMP_GLIBC="$CLANDRO_COMMON_CACHEDIR/temporary_glibc_for_cgct"
	mkdir -p "$PATH_TMP_GLIBC"

	local GPKG_LINK="https://sync.termux-pacman.dev/gpkg/$CLANDRO_ARCH"
	local GPKG_JSON="$PATH_TMP_GLIBC/gpkg-$CLANDRO_ARCH.json"
	clandro_download "$GPKG_LINK/gpkg.json" \
		"$GPKG_JSON" \
		SKIP_CHECKSUM

	# Installing temporary glibc.
	local GLIBC_PKG=$(jq -r '."glibc"."FILENAME"' "$GPKG_JSON")
	if [ ! -f "$PATH_TMP_GLIBC/$GLIBC_PKG" ]; then
		clandro_download "$GPKG_LINK/$GLIBC_PKG" \
			"$PATH_TMP_GLIBC/$GLIBC_PKG" \
			$(jq -r '."glibc"."SHA256SUM"' "$GPKG_JSON")
	fi

	[ ! "$CLANDRO_QUIET_BUILD" = true ] && echo "extracting temporary $PKG..."

	# Unpacking temporary glibc.
	tar -xJf "$PATH_TMP_GLIBC/$GLIBC_PKG" -C "$PATH_TMP_GLIBC" data
	if [ "$multilib_glibc" = "true" ]; then
		# Installing `lib32`.
		mkdir -p "$CLANDRO__PREFIX__LIB_DIR"
		cp -r "$PATH_TMP_GLIBC/$PREFIX_TMP_GLIBC/lib/"* "$CLANDRO__PREFIX__LIB_DIR"
		# Installing `include32`.
		mkdir -p "$CLANDRO__PREFIX__INCLUDE_DIR"
		local hpath
		for hpath in $(find "$PATH_TMP_GLIBC/$PREFIX_TMP_GLIBC/include" -type f); do
			local h=$(sed "s|$PATH_TMP_GLIBC/$PREFIX_TMP_GLIBC/include/||g" <<< "$hpath")
			if [ -f "$CLANDRO__PREFIX__BASE_INCLUDE_DIR/$h" ] && \
				[ $(md5sum "$hpath" | awk '{printf $1}') = $(md5sum "$CLANDRO__PREFIX__BASE_INCLUDE_DIR/$h" | awk '{printf $1}') ]; then
				rm "$hpath"
			fi
		done
		find "$PATH_TMP_GLIBC/$PREFIX_TMP_GLIBC/include" -type d -empty -delete
		cp -r "$PATH_TMP_GLIBC/$PREFIX_TMP_GLIBC/include/"* "$CLANDRO__PREFIX__INCLUDE_DIR"
		# Installing dynamic linker in lib.
		mkdir -p "$CLANDRO__PREFIX__BASE_LIB_DIR"
		local ld_path=$(ls "$CLANDRO__PREFIX__LIB_DIR"/ld-*)
		ln -sr "${ld_path}" "$CLANDRO__PREFIX__BASE_LIB_DIR/$(basename ${ld_path})"
	else
		# Complete installation of glibc components.
		cp -r "$PATH_TMP_GLIBC/$PREFIX_TMP_GLIBC/"* "$CLANDRO_PREFIX"
	fi
	# It is necessary to reconfigure the paths in libs for correct
	# work of multilib-compilation and compilation in forked projects.
	grep -I -s -r -l "/$PREFIX_TMP_GLIBC/lib/" "$CLANDRO__PREFIX__LIB_DIR" | xargs sed -i "s|/$PREFIX_TMP_GLIBC/lib/|$CLANDRO__PREFIX__LIB_DIR/|g"

	# Marking the installation of temporary glibc.
	rm -fr "$PATH_TMP_GLIBC/data"
	mkdir -p "$CLANDRO_BUILT_PACKAGES_DIRECTORY"
	touch "$CLANDRO_BUILT_PACKAGES_DIRECTORY/$PKG-temporary-for-cgct"
}

# Sets up symbolic links to libgcc* libraries (from cgct) in the application environment
# to allow cgct to work properly, if necessary.
clandro_set_links_to_libgcc_of_cgct() {
	local libgcc_cgct
	mkdir -p "$CLANDRO__PREFIX__LIB_DIR"
	for libgcc_cgct in $(find "$CGCT_DIR/$CLANDRO_ARCH/lib" -maxdepth 1 -type f -name 'libgcc*'); do
		if [ ! -e "$CLANDRO__PREFIX__LIB_DIR/$(basename $libgcc_cgct)" ]; then
			cp -r "$libgcc_cgct" "$CLANDRO__PREFIX__LIB_DIR"
		fi
	done
}

