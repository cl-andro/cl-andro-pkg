#!/bin/bash

# Setting the TMPDIR variable
: "${TMPDIR:=/tmp}"
export TMPDIR

# Set the build-package.sh call depth
# If its the root call, then create a file to store the list of packages and their dependencies
# that have been compiled at any instant by recursive calls to build-package.sh
if (( ${CLANDRO_BUILD_PACKAGE_CALL_DEPTH-0} )); then
	export CLANDRO_BUILD_PACKAGE_CALL_DEPTH=$((CLANDRO_BUILD_PACKAGE_CALL_DEPTH+1))
else
	CLANDRO_BUILD_PACKAGE_CALL_DEPTH=0
	CLANDRO_BUILD_PACKAGE_CALL_BUILT_PACKAGES_LIST_FILE_PATH="${TMPDIR}/build-package-call-built-packages-list-$(date +"%Y-%m-%d-%H.%M.%S.")$((RANDOM%1000))"
	CLANDRO_BUILD_PACKAGE_CALL_BUILDING_PACKAGES_LIST_FILE_PATH="${TMPDIR}/build-package-call-building-packages-list-$(date +"%Y-%m-%d-%H.%M.%S.")$((RANDOM%1000))"
	export CLANDRO_BUILD_PACKAGE_CALL_DEPTH CLANDRO_BUILD_PACKAGE_CALL_BUILT_PACKAGES_LIST_FILE_PATH CLANDRO_BUILD_PACKAGE_CALL_BUILDING_PACKAGES_LIST_FILE_PATH
	echo -n " " > "$CLANDRO_BUILD_PACKAGE_CALL_BUILT_PACKAGES_LIST_FILE_PATH"
	touch "$CLANDRO_BUILD_PACKAGE_CALL_BUILDING_PACKAGES_LIST_FILE_PATH"
fi

set -euo pipefail

cd "$(realpath "$(dirname "$0")")"
CLANDRO_SCRIPTDIR=$(pwd)
export CLANDRO_SCRIPTDIR

# Store pid of current process in a file for docker__run_docker_exec_trap
# shellcheck source=scripts/utils/docker/docker.sh
source "$CLANDRO_SCRIPTDIR/scripts/utils/docker/docker.sh"
docker__create_docker_exec_pid_file

# Source the `clandro_package` library.
# shellcheck source=scripts/utils/clandro/package/clandro_package.sh
source "$CLANDRO_SCRIPTDIR/scripts/utils/clandro/package/clandro_package.sh"

export SOURCE_DATE_EPOCH=${SOURCE_DATE_EPOCH:-$(git -c log.showSignature=false log -1 --pretty=%ct 2>/dev/null || date "+%s")}

if [[ "$(uname -o)" == "Android" || -e "/system/bin/app_process" ]]; then
	if [[ "$(id -u)" == "0" ]]; then
		echo "On-device execution of this script as root is disabled."
		exit 1
	fi

	# This variable tells all parts of build system that
	# the build is being performed on device.
	export CLANDRO_ON_DEVICE_BUILD=true
else
	export CLANDRO_ON_DEVICE_BUILD=false
fi

# Automatically enable offline set of sources and build tools.
# Offline clandro-packages bundle can be created by executing
# script ./scripts/setup-offline-bundle.sh.
if [[ -f "${CLANDRO_SCRIPTDIR}/build-tools/.installed" ]]; then
	export CLANDRO_PACKAGES_OFFLINE=true
fi

# Lock file to prevent parallel running in the same environment.
CLANDRO_BUILD_LOCK_FILE="${TMPDIR}/.clandro-build.lck"
if [[ ! -e "$CLANDRO_BUILD_LOCK_FILE" ]]; then
	touch "$CLANDRO_BUILD_LOCK_FILE"
fi

CLANDRO_REPO_PKG_FORMAT="$(jq --raw-output '.pkg_format // "debian"' "${CLANDRO_SCRIPTDIR}/repo.json")"
export CLANDRO_REPO_PKG_FORMAT

# Special variable for internal use. It forces script to ignore
# lock file.
: "${CLANDRO_BUILD_IGNORE_LOCK:=false}"

# Utility function to log an error message and exit with an error code.
# shellcheck source=scripts/build/clandro_error_exit.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/clandro_error_exit.sh"

# Utility function to download a resource with an expected checksum.
# shellcheck source=scripts/build/clandro_download.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/clandro_download.sh"

# Utility function to run binaries under termux environment via proot.
# shellcheck source=scripts/build/setup/clandro_setup_proot.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/setup/clandro_setup_proot.sh"

# Utility function to setup blueprint-compiler (may be used by gnome-calculator and epiphany).
# shellcheck source=scripts/build/setup/clandro_setup_bpc.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/setup/clandro_setup_bpc.sh"

# Installing packages if necessary for the full operation of CGCT.
# shellcheck source=scripts/build/clandro_step_setup_cgct_environment.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/clandro_step_setup_cgct_environment.sh"

# Utility function to setup capnproto (may be used by bitcoin).
# shellcheck source=scripts/build/setup/clandro_setup_capnp.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/setup/clandro_setup_capnp.sh"

# Utility function for setting up Cargo C-ABI helpers.
# shellcheck source=scripts/build/setup/clandro_setup_cargo_c.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/setup/clandro_setup_cargo_c.sh"

# Utility function for setting up pkg-config wrapper.
# shellcheck source=scripts/build/setup/clandro_setup_pkg_config_wrapper.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/setup/clandro_setup_pkg_config_wrapper.sh"

# Utility function for setting up Crystal toolchain.
# shellcheck source=scripts/build/setup/clandro_setup_crystal.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/setup/clandro_setup_crystal.sh"

# Utility function for setting up DotNet toolchain.
# shellcheck source=scripts/build/setup/clandro_setup_dotnet.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/setup/clandro_setup_dotnet.sh"

# Utility function for setting up Flang toolchain.
# shellcheck source=scripts/build/setup/clandro_setup_flang.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/setup/clandro_setup_flang.sh"

# Utility function to setup a GHC cross-compiler toolchain targeting Android.
# shellcheck source=scripts/build/setup/clandro_setup_ghc.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/setup/clandro_setup_ghc.sh"

# Utility function to setup GHC iserv to cross-compile haskell-template.
# shellcheck source=scripts/build/setup/clandro_setup_ghc_iserv.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/setup/clandro_setup_ghc_iserv.sh"

# Utility function to setup cabal-install (may be used by ghc toolchain).
# shellcheck source=scripts/build/setup/clandro_setup_cabal.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/setup/clandro_setup_cabal.sh"

# Utility function to setup jailbreak-cabal. It is used to remove version constraints
# from Cabal packages.
# shellcheck source=scripts/build/setup/clandro_setup_jailbreak_cabal.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/setup/clandro_setup_jailbreak_cabal.sh"

# Utility function for setting up GObject Introspection cross environment.
# shellcheck source=scripts/build/setup/clandro_setup_gir.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/setup/clandro_setup_gir.sh"

# Utility function for setting up GN toolchain.
# shellcheck source=scripts/build/setup/clandro_setup_gn.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/setup/clandro_setup_gn.sh"

# Utility function for golang-using packages to setup a go toolchain.
# shellcheck source=scripts/build/setup/clandro_setup_golang.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/setup/clandro_setup_golang.sh"

# Utility function for setting up LDC cross environment.
# shellcheck source=scripts/build/setup/clandro_setup_ldc.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/setup/clandro_setup_ldc.sh"

# Utility function for setting up no-integrated (GNU Binutils) as.
# shellcheck source=scripts/build/setup/clandro_setup_no_integrated_as.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/setup/clandro_setup_no_integrated_as.sh"

# Utility function for setting up build-python for cross-compilation of Python and crossenv
# shellcheck source=scripts/build/setup/clandro_setup_build_python.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/setup/clandro_setup_build_python.sh"

# Utility function for python packages to setup a python.
# shellcheck source=scripts/build/setup/clandro_setup_python_pip.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/setup/clandro_setup_python_pip.sh"

# Utility function for rust-using packages to setup a rust toolchain.
# shellcheck source=scripts/build/setup/clandro_setup_rust.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/setup/clandro_setup_rust.sh"

# Utility function for swift-using packages to setup a swift toolchain
# shellcheck source=scripts/build/setup/clandro_setup_swift.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/setup/clandro_setup_swift.sh"

# Utility function to setup a current xmake build system.
# shellcheck source=scripts/build/setup/clandro_setup_xmake.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/setup/clandro_setup_xmake.sh"

# Utility function for zig-using packages to setup a zig toolchain.
# shellcheck source=scripts/build/setup/clandro_setup_zig.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/setup/clandro_setup_zig.sh"

# Utility function to setup a current ninja build system.
# shellcheck source=scripts/build/setup/clandro_setup_ninja.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/setup/clandro_setup_ninja.sh"

# Utility function to setup Node.js JavaScript Runtime
# shellcheck source=scripts/build/setup/clandro_setup_nodejs.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/setup/clandro_setup_nodejs.sh"

# Utility function to setup a current meson build system.
# shellcheck source=scripts/build/setup/clandro_setup_meson.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/setup/clandro_setup_meson.sh"

# Utility function to setup a current cmake build system
# shellcheck source=scripts/build/setup/clandro_setup_cmake.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/setup/clandro_setup_cmake.sh"

# Utility function to setup protobuf:
# shellcheck source=scripts/build/setup/clandro_setup_protobuf.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/setup/clandro_setup_protobuf.sh"

# Utility function to setup the current version of the tree-sitter CLI
# shellcheck source=scripts/build/setup/clandro_setup_treesitter.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/setup/clandro_setup_treesitter.sh"

# Setup variables used by the build. Not to be overridden by packages.
# shellcheck source=scripts/build/clandro_step_setup_variables.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/clandro_step_setup_variables.sh"

# Save away and restore build setups which may change between builds.
# shellcheck source=scripts/build/clandro_step_handle_buildarch.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/clandro_step_handle_buildarch.sh"

# Function to get CLANDRO_PKG_VERSION from build.sh
# shellcheck source=scripts/build/clandro_extract_dep_info.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/clandro_extract_dep_info.sh"

# Function that downloads a .deb (using the clandro_download function)
# shellcheck source=scripts/build/clandro_download_deb_pac.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/clandro_download_deb_pac.sh"

# Function that downloads and extracts multiple Ubuntu packages (using the clandro_download function)
# shellcheck source=scripts/build/clandro_download_ubuntu_packages.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/clandro_download_ubuntu_packages.sh"

# Script to download InRelease, verify it's signature and then download Packages.xz by hash
# shellcheck source=scripts/build/clandro_get_repo_files.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/clandro_get_repo_files.sh"

# Download or build dependencies. Not to be overridden by packages.
# shellcheck source=scripts/build/clandro_step_get_dependencies.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/clandro_step_get_dependencies.sh"

# Download python dependency modules for compilation.
# shellcheck source=scripts/build/clandro_step_get_dependencies_python.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/clandro_step_get_dependencies_python.sh"

# Handle config scripts that needs to be run during build. Not to be overridden by packages.
# shellcheck source=scripts/build/clandro_step_override_config_scripts.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/clandro_step_override_config_scripts.sh"

# Remove old src and build folders and create new ones
# shellcheck source=scripts/build/clandro_step_setup_build_folders.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/clandro_step_setup_build_folders.sh"

# Source the package build script and start building. Not to be overridden by packages.
# shellcheck source=scripts/build/clandro_step_start_build.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/clandro_step_start_build.sh"

# Cleans up files from already built packages. Not to be overridden by packages.
# shellcheck source=scripts/build/clandro_step_start_build.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/clandro_step_cleanup_packages.sh"

# Download or build dependencies. Not to be overridden by packages.
# shellcheck source=scripts/build/clandro_step_create_timestamp_file.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/clandro_step_create_timestamp_file.sh"

# Run just after sourcing $CLANDRO_PKG_BUILDER_SCRIPT. Can be overridden by packages.
# shellcheck source=scripts/build/get_source/clandro_step_get_source.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/get_source/clandro_step_get_source.sh"

# Run from clandro_step_get_source if CLANDRO_PKG_SRCURL begins with "git+".
# shellcheck source=scripts/build/get_source/clandro_step_get_source.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/get_source/clandro_git_clone_src.sh"

# Run from clandro_step_get_source if CLANDRO_PKG_SRCURL does not begin with "git+".
# shellcheck source=scripts/build/get_source/clandro_download_src_archive.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/get_source/clandro_download_src_archive.sh"

# Run from clandro_step_get_source after clandro_download_src_archive.
# shellcheck source=scripts/build/get_source/clandro_unpack_src_archive.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/get_source/clandro_unpack_src_archive.sh"

# Hook for packages to act just after the package sources have been obtained.
# Invoked from $CLANDRO_PKG_SRCDIR.
clandro_step_post_get_source() {
	return
}

# Optional host build. Not to be overridden by packages.
# shellcheck source=scripts/build/clandro_step_handle_host_build.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/clandro_step_handle_host_build.sh"

# Perform a host build. Will be called in $CLANDRO_PKG_HOSTBUILD_DIR.
# After clandro_step_post_get_source() and before clandro_step_patch_package()
# shellcheck source=scripts/build/clandro_step_host_build.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/clandro_step_host_build.sh"

# Setup a standalone Android NDK toolchain. Called from clandro_step_setup_toolchain.
# shellcheck source=scripts/build/toolchain/clandro_setup_toolchain_29.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/toolchain/clandro_setup_toolchain_29.sh"

# Setup a standalone Android NDK 23c toolchain. Called from clandro_step_setup_toolchain.
# shellcheck source=scripts/build/toolchain/clandro_setup_toolchain_23c.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/toolchain/clandro_setup_toolchain_23c.sh"

# Setup a standalone Glibc GNU toolchain. Called from clandro_step_setup_toolchain.
# shellcheck source=scripts/build/toolchain/clandro_setup_toolchain_gnu.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/toolchain/clandro_setup_toolchain_gnu.sh"

# Runs clandro_step_setup_toolchain_${CLANDRO_NDK_VERSION}. Not to be overridden by packages.
# shellcheck source=scripts/build/clandro_step_setup_toolchain.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/clandro_step_setup_toolchain.sh"

# Apply all *.patch files for the package. Not to be overridden by packages.
# shellcheck source=scripts/build/clandro_step_patch_package.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/clandro_step_patch_package.sh"

# Replace autotools build-aux/config.{sub,guess} with ours to add android targets.
# shellcheck source=scripts/build/clandro_step_replace_guess_scripts.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/clandro_step_replace_guess_scripts.sh"

# For package scripts to override. Called in $CLANDRO_PKG_BUILDDIR.
clandro_step_pre_configure() {
	return
}

# Setup configure args and run $CLANDRO_PKG_SRCDIR/configure. This function is called from clandro_step_configure
# shellcheck source=scripts/build/configure/clandro_step_configure_autotools.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/configure/clandro_step_configure_autotools.sh"

# Setup configure args and run cmake. This function is called from clandro_step_configure
# shellcheck source=scripts/build/configure/clandro_step_configure_cmake.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/configure/clandro_step_configure_cmake.sh"

# Setup configure args and run meson. This function is called from clandro_step_configure
# shellcheck source=scripts/build/configure/clandro_step_configure_meson.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/configure/clandro_step_configure_meson.sh"

# Setup configure args and run cabal. This function is called from clandro_step_configure
# shellcheck source=scripts/build/configure/clandro_step_configure_cabal.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/configure/clandro_step_configure_cabal.sh"

# Configure the package
# shellcheck source=scripts/build/configure/clandro_step_configure.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/configure/clandro_step_configure.sh"

# Hook for packages after configure step
clandro_step_post_configure() {
	return
}

# Make package, either with ninja or make
# shellcheck source=scripts/build/clandro_step_make.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/clandro_step_make.sh"

# Make install, either with ninja, make of cargo
# shellcheck source=scripts/build/clandro_step_make_install.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/clandro_step_make_install.sh"

# Hook function for package scripts to override.
clandro_step_post_make_install() {
	return
}

# Install hooks (alpm-hooks) and hook-scripts into the pacman package
# shellcheck source=scripts/build/clandro_step_install_pacman_hooks.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/clandro_step_install_pacman_hooks.sh"

# Add service scripts from array CLANDRO_PKG_SERVICE_SCRIPT, if it is set
# shellcheck source=scripts/build/clandro_step_install_service_scripts.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/clandro_step_install_service_scripts.sh"

# Link/copy the LICENSE for the package to $CLANDRO_PREFIX/share/$CLANDRO_PKG_NAME/
# shellcheck source=scripts/build/clandro_step_install_license.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/clandro_step_install_license.sh"

# Function to cp (through tar) installed files to massage dir
# shellcheck source=scripts/build/clandro_step_copy_into_massagedir.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/clandro_step_copy_into_massagedir.sh"

# Hook function to create {pre,post}install, {pre,post}rm-scripts for subpkgs
# shellcheck source=scripts/build/clandro_step_create_subpkg_debscripts.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/clandro_step_create_subpkg_debscripts.sh"

# Create all subpackages. Run from clandro_step_massage
# shellcheck source=scripts/build/clandro_create_debian_subpackages.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/clandro_create_debian_subpackages.sh"

# Create all subpackages. Run from clandro_step_massage
# shellcheck source=scripts/build/clandro_create_pacman_subpackages.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/clandro_create_pacman_subpackages.sh"

# Function to run various cleanup/fixes
# shellcheck source=scripts/build/clandro_step_massage.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/clandro_step_massage.sh"

# Function to run strip symbols during clandro_step_massage
# shellcheck source=scripts/build/clandro_step_strip_elf_symbols.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/clandro_step_strip_elf_symbols.sh"

# Function to run clandro-elf-cleaner during clandro_step_massage
# shellcheck source=scripts/build/clandro_step_elf_cleaner.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/clandro_step_elf_cleaner.sh"

# Hook for packages before massage step
clandro_step_pre_massage() {
	return
}

# Hook for packages after massage step
clandro_step_post_massage() {
	return
}

# Function to create {pre,post}install, {pre,post}rm-scripts and similar
# shellcheck source=scripts/build/clandro_step_create_debscripts.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/clandro_step_create_debscripts.sh"

# Function to generate debscripts for python packages.
# shellcheck source=scripts/build/clandro_step_create_python_debscripts.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/clandro_step_create_python_debscripts.sh"

# Convert Debian maintainer scripts into pacman-compatible installation hooks.
# This is used only when creating pacman packages.
# shellcheck source=scripts/build/clandro_step_create_pacman_install_hook.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/clandro_step_create_pacman_install_hook.sh"

# Create the build deb file. Not to be overridden by package scripts.
# shellcheck source=scripts/build/clandro_step_create_debian_package.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/clandro_step_create_debian_package.sh"

# Create the build .pkg.tar.xz file. Not to be overridden by package scripts.
# shellcheck source=scripts/build/clandro_step_create_pacman_package.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/clandro_step_create_pacman_package.sh"

# Process 'update-alternatives' entries from `.alternatives` files.
# Not to be overridden by package scripts.
# shellcheck source=scripts/build/clandro_step_update_alternatives.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/clandro_step_update_alternatives.sh"

# Finish the build. Not to be overridden by package scripts.
# shellcheck source=scripts/build/clandro_step_finish_build.sh
source "$CLANDRO_SCRIPTDIR/scripts/build/clandro_step_finish_build.sh"

################################################################################

# shellcheck source=scripts/properties.sh
source "$CLANDRO_SCRIPTDIR/scripts/properties.sh"

if [[ "$CLANDRO_ON_DEVICE_BUILD" == "true" ]]; then
	# Setup CLANDRO_APP_PACKAGE_MANAGER
	# shellcheck source=/dev/null
	source "$CLANDRO_PREFIX/bin/clandro-setup-package-manager"

	# For on device builds cross compiling is not supported.
	# Target architecture must be same as for environment used currently.
	case "$CLANDRO_APP_PACKAGE_MANAGER" in
		"apt") CLANDRO_ARCH=$(dpkg --print-architecture);;
		"pacman") CLANDRO_ARCH=$(pacman-conf Architecture);;
	esac
	export CLANDRO_ARCH
fi

# Check if the package is in the compiled list
clandro_check_package_in_built_packages_list() {
	[[ ! -f "$CLANDRO_BUILD_PACKAGE_CALL_BUILT_PACKAGES_LIST_FILE_PATH" ]] && \
		clandro_error_exit "file '$CLANDRO_BUILD_PACKAGE_CALL_BUILT_PACKAGES_LIST_FILE_PATH' not found."
	# slightly faster than `grep -q $word $file`
	[[ " $(< "$CLANDRO_BUILD_PACKAGE_CALL_BUILT_PACKAGES_LIST_FILE_PATH") " == *" $1 "* ]]
	return $?
}

# Adds a package to the list of built packages if it is not in the list
clandro_add_package_to_built_packages_list() {
	if ! clandro_check_package_in_built_packages_list "$1"; then
		echo -n "$1 " >> "$CLANDRO_BUILD_PACKAGE_CALL_BUILT_PACKAGES_LIST_FILE_PATH"
	fi
}

# Check if the package is in the compiling list
clandro_check_package_in_building_packages_list() {
	[[ ! -f "$CLANDRO_BUILD_PACKAGE_CALL_BUILDING_PACKAGES_LIST_FILE_PATH" ]] && \
		clandro_error_exit "file '$CLANDRO_BUILD_PACKAGE_CALL_BUILDING_PACKAGES_LIST_FILE_PATH' not found."
	# slightly faster than `grep -q $word $file`
	[[ $'\n'"$(<"$CLANDRO_BUILD_PACKAGE_CALL_BUILDING_PACKAGES_LIST_FILE_PATH")"$'\n' == *$'\n'"$1"$'\n'* ]]
	return $?
}

# Configure variables (CLANDRO_ARCH, CLANDRO__PREFIX__INCLUDE_DIR, CLANDRO__PREFIX__LIB_DIR) for multilib-compilation
clandro_conf_multilib_vars() {
	# Change the 64-bit architecture type to its 32-bit counterpart in the `CLANDRO_ARCH` variable
	case "$CLANDRO_ARCH" in
		"aarch64") CLANDRO_ARCH="arm";;
		"x86_64") CLANDRO_ARCH="i686";;
		*) clandro_error_exit "It is impossible to set multilib arch for ${CLANDRO_ARCH} arch."
	esac
	CLANDRO__PREFIX__INCLUDE_SUBDIR="$CLANDRO__PREFIX__MULTI_INCLUDE_SUBDIR"
	CLANDRO__PREFIX__INCLUDE_DIR="$CLANDRO__PREFIX__MULTI_INCLUDE_DIR"
	CLANDRO__PREFIX__LIB_SUBDIR="$CLANDRO__PREFIX__MULTI_LIB_SUBDIR"
	CLANDRO__PREFIX__LIB_DIR="$CLANDRO__PREFIX__MULTI_LIB_DIR"
}

# Run functions for normal compilation and multilib-compilation
clandro_run_base_and_multilib_build_step() {
	case "${1}" in
		clandro_step_configure|clandro_step_make|clandro_step_make_install) local func="${1}";;
		*) clandro_error_exit "Unsupported function '${1}'."
	esac
	cd "$CLANDRO_PKG_BUILDDIR"
	if [[ "$CLANDRO_PKG_BUILD_ONLY_MULTILIB" == "false" ]]; then
		"${func}"
	fi
	if [[ "$CLANDRO_PKG_BUILD_MULTILIB" == "true" ]]; then
		(
			clandro_step_setup_multilib_environment
			"${func}_multilib"
		)
	fi
}

# Special hook to prevent use of "sudo" inside package build scripts.
# build-package.sh shouldn't perform any privileged operations.
sudo() {
	clandro_error_exit "Do not use 'sudo' inside build scripts. Build environment should be configured through ./scripts/setup-ubuntu.sh."
}

_show_usage() {
	echo "Usage: ./build-package.sh [options] PACKAGE_1 PACKAGE_2 ..."
	echo
	echo "Build a package by creating a .deb file in the output/ folder."
	echo
	echo "Available options:"
	[[ "$CLANDRO_ON_DEVICE_BUILD" = "false" ]] && echo "  -a The architecture to build for: aarch64(default), arm, i686, x86_64 or all."
	echo "  -c Continue previous build."
	echo "  -C Cleanup already built packages on low disk space."
	echo "  -d Build with debug symbols."
	echo "  -D Build a disabled package in disabled-packages/."
	echo "  -f Force build even if package has already been built."
	echo "  -F Force build even if package and its dependencies have already been built."
	[[ "$CLANDRO_ON_DEVICE_BUILD" = "false" ]] && echo "  -i Download and extract dependencies instead of building them."
	echo "  -I Download and extract dependencies instead of building them, keep existing $CLANDRO_BASE_DIR files."
	echo "  -L The package and its dependencies will be based on the same library."
	echo "  -q Quiet build."
	echo "  -Q Loud build -- set -x debug output and function tracing."
	echo "  -r Remove all package build dependent dirs that '-f/-F'"
	echo "     flags alone would not remove, like cache dir containing "
	echo "     package sources and host build dir. Ignored if '-f/-F'"
	echo "     flags are not passed."
	echo "  -w Install dependencies without version binding."
	echo "  -s Skip dependency check."
	echo "  -o Specify directory where to put built packages. Default: output/"
	echo "  --format Specify package output format (debian, pacman)."
	echo "  --library Specify library of package (bionic, glibc)."
	exit 1
}

declare -a PACKAGE_LIST=()

(( $# )) || _show_usage
while (( $# )); do
	case "$1" in
		--) shift 1; break;;
		-h|--help) _show_usage;;
		--format)
			if [[ -z "${2-}" ]]; then
				clandro_error_exit "./build-package.sh: option '--format' requires an argument"
			fi
			shift 1
			export CLANDRO_PACKAGE_FORMAT="$1"
		;;
		--library)
			if [[ -z "${2-}" ]]; then
				clandro_error_exit "./build-package.sh: option '--library' requires an argument"
			fi
			shift 1
			export CLANDRO_PACKAGE_LIBRARY="$1"
		;;
		-a)
			if [[ "$CLANDRO_ON_DEVICE_BUILD" == "true" ]]; then
				clandro_error_exit "./build-package.sh: option '-a' is not available for on-device builds"
			fi
			if [[ -z "${2-}" ]]; then
				clandro_error_exit "./build-package.sh: option '-a' requires an argument"
			fi
			shift 1
			export CLANDRO_ARCH="$1"
		;;
		-d) export CLANDRO_DEBUG_BUILD=true;;
		-D) CLANDRO_IS_DISABLED=true;;
		-f) CLANDRO_FORCE_BUILD=true;;
		-F) CLANDRO_FORCE_BUILD_DEPENDENCIES=true && CLANDRO_FORCE_BUILD=true;;
		-i)
			if [[ "$CLANDRO_ON_DEVICE_BUILD" == "true" ]]; then
				clandro_error_exit "./build-package.sh: option '-i' is not available for on-device builds"
			fi
			export CLANDRO_INSTALL_DEPS=true
		;;
		-I)
			export CLANDRO_INSTALL_DEPS=true
			export CLANDRO_PKGS__BUILD__RM_ALL_PKGS_BUILT_MARKER_AND_INSTALL_FILES=false
		;;
		-L) export CLANDRO_GLOBAL_LIBRARY=true;;
		-q) export CLANDRO_QUIET_BUILD=true;;
		-Q) export PS4='+$0 \[\e[32m\]${FUNCNAME[0]:-<global scope>}${FUNCNAME[*]:+()}:$LINENO\[\e[0m\] '; set -x;;
		-r) export CLANDRO_PKGS__BUILD__RM_ALL_PKG_BUILD_DEPENDENT_DIRS=true;;
		-w) export CLANDRO_WITHOUT_DEPVERSION_BINDING=true;;
		-s) export CLANDRO_SKIP_DEPCHECK=true;;
		-o)
			if [[ -z "${2-}" ]]; then
				clandro_error_exit "./build-package.sh: option '-o' requires an argument"
			fi
			shift 1
			CLANDRO_OUTPUT_DIR="$(realpath -m "$1")"
		;;
		-c) CLANDRO_CONTINUE_BUILD=true;;
		-C) CLANDRO_CLEANUP_BUILT_PACKAGES_ON_LOW_DISK_SPACE=true;;
		-*) clandro_error_exit "./build-package.sh: illegal option '$1'";;
		*) PACKAGE_LIST+=("$1");;
	esac
	shift 1
done
unset -f _show_usage

# Dependencies should be used from repo only if they are built for
# same package name.
if [[ "$CLANDRO_REPO_APP__PACKAGE_NAME" != "$CLANDRO_APP_PACKAGE" ]]; then
	echo "Ignoring -i option to download dependencies since repo package name ($CLANDRO_REPO_APP__PACKAGE_NAME) does not equal app package name ($CLANDRO_APP_PACKAGE)"
	CLANDRO_INSTALL_DEPS=false
fi

case "$CLANDRO_REPO_PKG_FORMAT" in
	debian|pacman) :;;
	*) clandro_error_exit "'pkg_format' is incorrectly specified in repo.json file. Only 'debian' and 'pacman' formats are supported";;
esac

if [[ -n "${CLANDRO_PACKAGE_FORMAT-}" ]]; then
	case "${CLANDRO_PACKAGE_FORMAT-}" in
		debian|pacman) :;;
		*) clandro_error_exit "Unsupported package format \"${CLANDRO_PACKAGE_FORMAT-}\". Only 'debian' and 'pacman' formats are supported";;
	esac
fi

if [[ -n "${CLANDRO_PACKAGE_LIBRARY-}" ]]; then
	case "${CLANDRO_PACKAGE_LIBRARY-}" in
		bionic|glibc) :;;
		*) clandro_error_exit "Unsupported library \"${CLANDRO_PACKAGE_LIBRARY-}\". Only 'bionic' and 'glibc' library are supported";;
	esac
fi

if [[ "${CLANDRO_INSTALL_DEPS-false}" = "true" || "${CLANDRO_PACKAGE_LIBRARY-bionic}" = "glibc" ]]; then
	# Setup PGP keys for verifying integrity of dependencies.
	# Keys are obtained from our keyring package.
	gpg --list-keys 2C7F29AE97891F6419A9E2CDB0076E490B71616B > /dev/null 2>&1 || {
		gpg --import "$CLANDRO_SCRIPTDIR/packages/clandro-keyring/grimler.gpg"
		gpg --no-tty --command-file <(echo -e "trust\n5\ny") --edit-key 2C7F29AE97891F6419A9E2CDB0076E490B71616B
	}
	gpg --list-keys CC72CF8BA7DBFA0182877D045A897D96E57CF20C > /dev/null 2>&1 || {
		gpg --import "$CLANDRO_SCRIPTDIR/packages/clandro-keyring/termux-autobuilds.gpg"
		gpg --no-tty --command-file <(echo -e "trust\n5\ny") --edit-key CC72CF8BA7DBFA0182877D045A897D96E57CF20C
	}
	gpg --list-keys 998DE27318E867EA976BA877389CEED64573DFCA > /dev/null 2>&1 || {
		gpg --import "$CLANDRO_SCRIPTDIR/packages/clandro-keyring/termux-pacman.gpg"
		gpg --no-tty --command-file <(echo -e "trust\n5\ny") --edit-key 998DE27318E867EA976BA877389CEED64573DFCA
	}
fi

for (( i=0; i < ${#PACKAGE_LIST[@]}; i++ )); do
	# Following commands must be executed under lock to prevent running
	# multiple instances of "./build-package.sh".
	#
	# To provide a sane environment for each package,
	# builds are done in an explicit subshell for each.
	# shellcheck disable=SC2031
	(
		if [[ "$CLANDRO_BUILD_IGNORE_LOCK" != "true" ]]; then
			flock -n 5 || clandro_error_exit "Another build is already running within same environment."
		fi
		(
		# Handle 'all' arch:
		if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" && -n "${CLANDRO_ARCH+x}" && "${CLANDRO_ARCH}" == 'all' ]]; then
			_SELF_ARGS=()
			[[ "${CLANDRO_CLEANUP_BUILT_PACKAGES_ON_LOW_DISK_SPACE:-}" == "true" ]] && _SELF_ARGS+=("-C")
			[[ "${CLANDRO_DEBUG_BUILD:-}" == "true" ]] && _SELF_ARGS+=("-d")
			[[ "${CLANDRO_IS_DISABLED:-}" == "true" ]] && _SELF_ARGS+=("-D")
			[[ "${CLANDRO_FORCE_BUILD:-}" == "true" && "${CLANDRO_FORCE_BUILD_DEPENDENCIES:-}" != "true" ]] && _SELF_ARGS+=("-f")
			[[ "${CLANDRO_FORCE_BUILD:-}" == "true" && "${CLANDRO_FORCE_BUILD_DEPENDENCIES:-}" == "true" ]] && _SELF_ARGS+=("-F")
			[[ "${CLANDRO_INSTALL_DEPS:-}" == "true" && "${CLANDRO_PKGS__BUILD__RM_ALL_PKGS_BUILT_MARKER_AND_INSTALL_FILES:-}" != "false" ]] && _SELF_ARGS+=("-i")
			[[ "${CLANDRO_INSTALL_DEPS:-}" == "true" && "${CLANDRO_PKGS__BUILD__RM_ALL_PKGS_BUILT_MARKER_AND_INSTALL_FILES:-}" == "false" ]] && _SELF_ARGS+=("-I")
			[[ "${CLANDRO_GLOBAL_LIBRARY:-}" == "true" ]] && _SELF_ARGS+=("-L")
			[[ -n "${CLANDRO_OUTPUT_DIR:-}" ]] && _SELF_ARGS+=("-o" "$CLANDRO_OUTPUT_DIR")
			[[ "${CLANDRO_PKGS__BUILD__RM_ALL_PKG_BUILD_DEPENDENT_DIRS:-}" == "true" ]] && _SELF_ARGS+=("-r")
			[[ "${CLANDRO_WITHOUT_DEPVERSION_BINDING:-}" == "true" ]] && _SELF_ARGS+=("-w")
			[[ -n "${CLANDRO_PACKAGE_FORMAT:-}" ]] && _SELF_ARGS+=("--format" "$CLANDRO_PACKAGE_FORMAT")
			[[ -n "${CLANDRO_PACKAGE_LIBRARY:-}" ]] && _SELF_ARGS+=("--library" "$CLANDRO_PACKAGE_LIBRARY")

			for arch in 'aarch64' 'arm' 'i686' 'x86_64'; do
				env CLANDRO_ARCH="$arch" CLANDRO_BUILD_IGNORE_LOCK=true ./build-package.sh \
					"${_SELF_ARGS[@]}" "${PACKAGE_LIST[i]}"
			done
			exit
		fi

		# Check the package to build:
		CLANDRO_PKG_NAME="$(basename "${PACKAGE_LIST[i]}")"
		CLANDRO_PKG_BUILDER_DIR=""
		if [[ ${PACKAGE_LIST[i]} == *"/"* ]]; then
			# Path to directory which may be outside this repo:
			if [[ ! -d "${PACKAGE_LIST[i]}" ]]; then clandro_error_exit "'${PACKAGE_LIST[i]}' seems to be a path but is not a directory"; fi
			CLANDRO_PKG_BUILDER_DIR="$(realpath "${PACKAGE_LIST[i]}")"
		else
			# Package name:
			# FIXME: CLANDRO_PACKAGES_DIRECTORIES should be made into an array.
			for package_directory in $CLANDRO_PACKAGES_DIRECTORIES; do
				if [[ -d "${CLANDRO_SCRIPTDIR}/${package_directory}/${CLANDRO_PKG_NAME}" ]]; then
					export CLANDRO_PKG_BUILDER_DIR="${CLANDRO_SCRIPTDIR}/$package_directory/$CLANDRO_PKG_NAME"
					break
				elif [[ -n "${CLANDRO_IS_DISABLED=""}" && -d "${CLANDRO_SCRIPTDIR}/disabled-packages/${CLANDRO_PKG_NAME}" ]]; then
					export CLANDRO_PKG_BUILDER_DIR="$CLANDRO_SCRIPTDIR/disabled-packages/$CLANDRO_PKG_NAME"
					break
				fi
			done
			if [[ -z "${CLANDRO_PKG_BUILDER_DIR}" ]]; then
				clandro_error_exit "No package $CLANDRO_PKG_NAME found in any of the enabled repositories. Are you trying to set up a custom repository?"
			fi
		fi
		export CLANDRO_PKG_BUILDER_DIR
		CLANDRO_PKG_BUILDER_SCRIPT=$CLANDRO_PKG_BUILDER_DIR/build.sh
		if [[ ! -f "$CLANDRO_PKG_BUILDER_SCRIPT" ]]; then
			clandro_error_exit "No build.sh script at package dir $CLANDRO_PKG_BUILDER_DIR!"
		fi

		clandro_step_setup_variables
		clandro_step_handle_buildarch

		clandro_step_cleanup_packages
		clandro_step_start_build

		if ! clandro_check_package_in_building_packages_list "${CLANDRO_PKG_BUILDER_DIR#"${CLANDRO_SCRIPTDIR}/"}"; then
			echo "${CLANDRO_PKG_BUILDER_DIR#"${CLANDRO_SCRIPTDIR}/"}" >> "$CLANDRO_BUILD_PACKAGE_CALL_BUILDING_PACKAGES_LIST_FILE_PATH"
		fi

		if [[ "$CLANDRO_CONTINUE_BUILD" == "false" ]]; then
			clandro_step_get_dependencies
			if [[ "$CLANDRO_PACKAGE_LIBRARY" == "glibc" ]]; then
				clandro_step_setup_cgct_environment
			fi
			clandro_step_override_config_scripts
		fi

		clandro_step_create_timestamp_file

		if [[ "$CLANDRO_CONTINUE_BUILD" == "false" ]]; then
			cd "$CLANDRO_PKG_CACHEDIR"
			clandro_step_get_source
			cd "$CLANDRO_PKG_SRCDIR"
			clandro_step_post_get_source
			clandro_step_handle_host_build
		fi

		clandro_step_setup_toolchain

		if [[ "$CLANDRO_CONTINUE_BUILD" == "false" ]]; then
			clandro_step_get_dependencies_python
			clandro_step_patch_package
			clandro_step_replace_guess_scripts
			cd "$CLANDRO_PKG_SRCDIR"
			clandro_step_pre_configure
		fi

		# Even on continued build we might need to setup paths
		# to tools so need to run part of configure step
		clandro_run_base_and_multilib_build_step clandro_step_configure

		if [[ "$CLANDRO_CONTINUE_BUILD" == "false" ]]; then
			cd "$CLANDRO_PKG_BUILDDIR"
			clandro_step_post_configure
		fi
		clandro_run_base_and_multilib_build_step clandro_step_make
		clandro_run_base_and_multilib_build_step clandro_step_make_install
		cd "$CLANDRO_PKG_BUILDDIR"
		clandro_step_post_make_install
		clandro_step_install_pacman_hooks
		clandro_step_install_service_scripts
		clandro_step_install_license
		cd "$CLANDRO_PKG_MASSAGEDIR"
		clandro_step_copy_into_massagedir
		cd "$CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX_CLASSICAL"
		clandro_step_pre_massage
		cd "$CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX_CLASSICAL"
		clandro_step_massage
		cd "$CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX_CLASSICAL"
		clandro_step_post_massage
		# At the final stage (when the package is archiving) it is better to use commands from the system
		if [[ "$CLANDRO_ON_DEVICE_BUILD" = "false" ]]; then
			export PATH="/usr/bin:$PATH"
		fi
		cd "$CLANDRO_PKG_MASSAGEDIR"
		case "$CLANDRO_PACKAGE_FORMAT" in
			debian) clandro_step_create_debian_package;;
			pacman) clandro_step_create_pacman_package;;
			*) clandro_error_exit "Unknown package format '$CLANDRO_PACKAGE_FORMAT'.";;
		esac
		# Save a list of compiled packages for further work with it
		if clandro_check_package_in_building_packages_list "${CLANDRO_PKG_BUILDER_DIR#"${CLANDRO_SCRIPTDIR}/"}"; then
			sed -i "\|^${CLANDRO_PKG_BUILDER_DIR#"${CLANDRO_SCRIPTDIR}/"}$|d" "$CLANDRO_BUILD_PACKAGE_CALL_BUILDING_PACKAGES_LIST_FILE_PATH"
		fi
		clandro_add_package_to_built_packages_list "$CLANDRO_PKG_NAME"
		clandro_step_finish_build
		) 5>&-
	) 5< "$CLANDRO_BUILD_LOCK_FILE"
done

# Removing a file to store a list of compiled packages
if (( ! CLANDRO_BUILD_PACKAGE_CALL_DEPTH )); then
	rm "$CLANDRO_BUILD_PACKAGE_CALL_BUILT_PACKAGES_LIST_FILE_PATH"
	rm "$CLANDRO_BUILD_PACKAGE_CALL_BUILDING_PACKAGES_LIST_FILE_PATH"
fi
