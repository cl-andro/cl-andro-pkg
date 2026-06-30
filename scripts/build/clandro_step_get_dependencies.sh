clandro_step_get_dependencies() {
	[[ "$CLANDRO_SKIP_DEPCHECK" == "true" || "$CLANDRO_PKG_METAPACKAGE" == "true" ]] && return 0
	[[ "$CLANDRO_INSTALL_DEPS" == "true" ]] && clandro_download_repo_file # Download repo files

	while read -r PKG PKG_DIR; do
		# Checking for duplicate dependencies
		local cyclic_dependence="false"
		if clandro_check_package_in_building_packages_list "$PKG_DIR"; then
			echo "A circular dependency was found on '$PKG', the old version of the package will be installed to resolve the conflict"
			cyclic_dependence="true"
			[[ "$CLANDRO_INSTALL_DEPS" == "false" ]] && clandro_download_repo_file
		fi

		[[ -z "$PKG" ]] && continue
		[[ "$PKG" == "ERROR" ]] && clandro_error_exit "Obtaining buildorder failed"

		if [[ "$CLANDRO_INSTALL_DEPS" == "true" || "$cyclic_dependence" = "true" ]]; then
			[[ "$PKG" == "ndk-sysroot" ]] && continue # llvm doesn't build if ndk-sysroot is installed:
			read -r DEP_ARCH DEP_VERSION DEP_VERSION_PAC DEP_ON_DEVICE_NOT_SUPPORTED < <(clandro_extract_dep_info "${PKG}" "${PKG_DIR}")
			local pkg_versioned="$PKG" build_dependency="false" force_build_dependency="$CLANDRO_FORCE_BUILD_DEPENDENCIES"
			[[ "${CLANDRO_WITHOUT_DEPVERSION_BINDING}" == "false" ]] && pkg_versioned+="@$DEP_VERSION"
			if [[ "$cyclic_dependence" == "false" ]]; then
				[[ "$CLANDRO_QUIET_BUILD" != "true" ]] && echo "Downloading dependency $pkg_versioned if necessary..."
				if [[ "$CLANDRO_FORCE_BUILD_DEPENDENCIES" == "true" && "$CLANDRO_ON_DEVICE_BUILD" == "true" && "$DEP_ON_DEVICE_NOT_SUPPORTED" == "true" ]]; then
					echo "Building dependency $PKG on device is not supported. It will be downloaded..."
					force_build_dependency="false"
				fi
			else
				force_build_dependency="false"
			fi
			if [[ "$force_build_dependency" = "true" ]]; then
				clandro_force_check_package_dependency && continue || :
				[[ "$CLANDRO_QUIET_BUILD" != "true" ]] && echo "Force building dependency $PKG instead of downloading due to -I flag..."
				build_dependency="true"
			else
				if clandro_package__is_package_version_built "$PKG" "$DEP_VERSION"; then
					[[ "$CLANDRO_QUIET_BUILD" != "true" ]] && echo "Skipping already built dependency $pkg_versioned"
					continue
				fi
				if ! CLANDRO_WITHOUT_DEPVERSION_BINDING="$([[ "${cyclic_dependence}" == "true" ]] && echo "true" || echo "${CLANDRO_WITHOUT_DEPVERSION_BINDING}")" clandro_download_deb_pac $PKG $DEP_ARCH $DEP_VERSION $DEP_VERSION_PAC; then
					[[ "$cyclic_dependence" == "true" || ( "$CLANDRO_FORCE_BUILD_DEPENDENCIES" == "true" && "$CLANDRO_ON_DEVICE_BUILD" == "true" ) ]] \
						&& clandro_error_exit "Download of $PKG$([[ "${CLANDRO_WITHOUT_DEPVERSION_BINDING}" == "false" && "${cyclic_dependence}" == "false" ]] && echo "@$DEP_VERSION") from $CLANDRO_REPO_URL failed"
					echo "Download of $pkg_versioned from $CLANDRO_REPO_URL failed, building instead"
					build_dependency="true"
				fi
			fi
			if [[ "$cyclic_dependence" == "false" ]]; then
				if [[ "$build_dependency" == "true" ]]; then
					clandro_run_build-package
					continue
				fi
				clandro_add_package_to_built_packages_list "$PKG"
			fi
			if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
				[[ "$CLANDRO_QUIET_BUILD" != "true" ]] && echo "extracting $PKG to $CLANDRO_COMMON_CACHEDIR-$DEP_ARCH..."
				(
					cd "$CLANDRO_COMMON_CACHEDIR-$DEP_ARCH"
					if [[ "$CLANDRO_REPO_PKG_FORMAT" == "debian" ]]; then
						# Ignore topdir `.`, to avoid possible  permission errors from tar
						ar p "${PKG}_${DEP_VERSION}_${DEP_ARCH}.deb" "data.tar.xz" | \
							tar xJ --no-overwrite-dir --transform='s#^.$#data#' -C /
					elif [[ "$CLANDRO_REPO_PKG_FORMAT" == "pacman" ]]; then
						tar -xJf "${PKG}-${DEP_VERSION_PAC}-${DEP_ARCH}.pkg.tar.xz" \
							--anchored --exclude=.{BUILDINFO,PKGINFO,MTREE,INSTALL} \
							--force-local --no-overwrite-dir -C /
					fi
				)
			fi
			mkdir -p "$CLANDRO_BUILT_PACKAGES_DIRECTORY"
			if [[ "$cyclic_dependence" == "false" && ( "$CLANDRO_WITHOUT_DEPVERSION_BINDING" == "false" || "$CLANDRO_ON_DEVICE_BUILD" == "false" ) ]]; then
				echo "$DEP_VERSION" > "$CLANDRO_BUILT_PACKAGES_DIRECTORY/$PKG"
			fi
		else # Build dependencies
			# Built dependencies are put in the default CLANDRO_OUTPUT_DIR instead of the specified one
			if [[ "$CLANDRO_FORCE_BUILD_DEPENDENCIES" == "true" ]]; then
				[[ "$CLANDRO_QUIET_BUILD" != "true" ]] && echo "Force building dependency $PKG..."
				read -r DEP_ARCH DEP_VERSION DEP_VERSION_PAC DEP_ON_DEVICE_NOT_SUPPORTED < <(clandro_extract_dep_info $PKG "${PKG_DIR}")
				[[ "$CLANDRO_ON_DEVICE_BUILD" == "true" && "$DEP_ON_DEVICE_NOT_SUPPORTED" == "true" ]] \
					&& clandro_error_exit "Building $PKG on device is not supported. Consider passing -I flag to download it instead"
				clandro_force_check_package_dependency && continue
			else
				[[ "$CLANDRO_QUIET_BUILD" != "true" ]] && echo "Building dependency $PKG if necessary..."
			fi
			clandro_run_build-package
		fi
	done < <(./scripts/buildorder.py $([[ "${CLANDRO_INSTALL_DEPS}" == "true" ]] && echo "-i") "$CLANDRO_PKG_BUILDER_DIR" $CLANDRO_PACKAGES_DIRECTORIES || echo "ERROR")
}

clandro_force_check_package_dependency() {
	if clandro_check_package_in_built_packages_list "$PKG" && clandro_package__is_package_version_built "$PKG" "$DEP_VERSION"; then
		[[ "$CLANDRO_QUIET_BUILD" != "true" ]] && echo "Skipping already built dependency $PKG$([[ "${CLANDRO_WITHOUT_DEPVERSION_BINDING}" == "false" ]] && echo "@$DEP_VERSION")"
		return 0
	fi
	return 1
}

clandro_run_build-package() {
	local set_library
	if [[ "$CLANDRO_GLOBAL_LIBRARY" = "true" ]]; then
		set_library="$CLANDRO_PACKAGE_LIBRARY -L"
	else
		set_library="bionic"
		if clandro_package__is_package_name_have_glibc_prefix "$PKG"; then
			set_library="glibc"
		fi
	fi
	CLANDRO_BUILD_IGNORE_LOCK=true ./build-package.sh \
		$([[ "${CLANDRO_INSTALL_DEPS}" == "true" ]] && echo "-I" || echo "-s") \
		$([[ "${CLANDRO_FORCE_BUILD}" == "true" && "${CLANDRO_FORCE_BUILD_DEPENDENCIES}" == "true" ]] && echo "-F") \
		$([[ "${CLANDRO_PKGS__BUILD__RM_ALL_PKG_BUILD_DEPENDENT_DIRS}" == "true" ]] && echo "-r") \
		$([[ "${CLANDRO_WITHOUT_DEPVERSION_BINDING}" = "true" ]] && echo "-w") \
			--format $CLANDRO_PACKAGE_FORMAT --library $set_library "${PKG_DIR}"
}

clandro_download_repo_file() {
	clandro_get_repo_files

	# When doing build on device, ensure that apt lists are up-to-date.
	if [[ "$CLANDRO_ON_DEVICE_BUILD" = "true" ]]; then
		case "$CLANDRO_APP_PACKAGE_MANAGER" in
			"apt") apt update;;
			"pacman") pacman -Sy;;
		esac
	fi
}
