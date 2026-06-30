clandro_step_setup_variables() {
	: "${CLANDRO_ARCH:="aarch64"}" # arm, aarch64, i686 or x86_64.
	: "${CLANDRO_OUTPUT_DIR:="${CLANDRO_SCRIPTDIR}/output"}"
	: "${CLANDRO_DEBUG_BUILD:="false"}"
	: "${CLANDRO_FORCE_BUILD:="false"}"
	: "${CLANDRO_FORCE_BUILD_DEPENDENCIES:="false"}"
	: "${CLANDRO_INSTALL_DEPS:="false"}"
	: "${CLANDRO_PKG_MAKE_PROCESSES:="$(nproc)"}"
	: "${CLANDRO_PKGS__BUILD__RM_ALL_PKGS_BUILT_MARKER_AND_INSTALL_FILES:="true"}"
	: "${CLANDRO_PKGS__BUILD__RM_ALL_PKG_BUILD_DEPENDENT_DIRS:="false"}"
	: "${CLANDRO_PKG_API_LEVEL:="24"}"
	: "${CLANDRO_CONTINUE_BUILD:="false"}"
	: "${CLANDRO_QUIET_BUILD:="false"}"
	: "${CLANDRO_WITHOUT_DEPVERSION_BINDING:="false"}"
	: "${CLANDRO_SKIP_DEPCHECK:="false"}"
	: "${CLANDRO_GLOBAL_LIBRARY:="false"}"
	: "${CLANDRO_TOPDIR:="$HOME/.clandro-build"}"
	: "${CLANDRO_PACMAN_PACKAGE_COMPRESSION:="xz"}"

	if [ -z "${CLANDRO_PACKAGE_FORMAT-}" ]; then
		if [ "$CLANDRO_ON_DEVICE_BUILD" = "true" ] && [ -n "${CLANDRO_APP_PACKAGE_MANAGER-}" ]; then
			CLANDRO_PACKAGE_FORMAT="$([ "${CLANDRO_APP_PACKAGE_MANAGER-}" = "apt" ] && echo "debian" || echo "${CLANDRO_APP_PACKAGE_MANAGER-}")"
		else
			CLANDRO_PACKAGE_FORMAT="debian"
		fi
	fi

	case "${CLANDRO_PACKAGE_FORMAT-}" in
		debian) export CLANDRO_PACKAGE_MANAGER="apt";;
		pacman) export CLANDRO_PACKAGE_MANAGER="pacman";;
		*) clandro_error_exit "Unsupported package format \"${CLANDRO_PACKAGE_FORMAT-}\". Only 'debian' and 'pacman' formats are supported";;
	esac

	# Default package library base
	if [ -z "${CLANDRO_PACKAGE_LIBRARY-}" ]; then
		export CLANDRO_PACKAGE_LIBRARY="bionic"
	fi

	if [ "$CLANDRO_PACKAGE_LIBRARY" = "glibc" ]; then
		clandro_build_props__set_termux_prefix_dir_and_sub_variables "$CLANDRO__PREFIX_GLIBC"
		if [ "$CLANDRO_ON_DEVICE_BUILD" = "false" ] && [ "$CLANDRO_PREFIX" != "$CGCT_DEFAULT_PREFIX" ]; then
			export CGCT_APP_PREFIX="$CLANDRO_PREFIX"
		fi
		if ! clandro_package__is_package_name_have_glibc_prefix "$CLANDRO_PKG_NAME"; then
			CLANDRO_PKG_NAME="$(clandro_package__add_prefix_glibc_to_package_name "${CLANDRO_PKG_NAME}")"
		fi
	fi

	if [ "$CLANDRO_ON_DEVICE_BUILD" = "true" ]; then
		# For on-device builds cross-compiling is not supported so we can
		# store information about built packages under $CLANDRO_TOPDIR.
		CLANDRO_BUILT_PACKAGES_DIRECTORY="$CLANDRO_TOPDIR/.built-packages"
		CLANDRO_PKGS__BUILD__RM_ALL_PKGS_BUILT_MARKER_AND_INSTALL_FILES="false"

		if [ "$CLANDRO_PACKAGE_LIBRARY" = "bionic" ]; then
			# On-device builds without clandro-exec are unsupported.
			if [[ ":${LD_PRELOAD:-}:" != ":${CLANDRO__PREFIX__LIB_DIR}/libclandro-exec"*".so:" ]]; then
				clandro_error_exit "On-device builds without clandro-exec are not supported."
			fi
		fi
	else
		CLANDRO_BUILT_PACKAGES_DIRECTORY="/data/data/.built-packages"
	fi

	# CLANDRO_PKG_MAINTAINER should be explicitly set in build.sh of the package.
	: "${CLANDRO_PKG_MAINTAINER:="default"}"

	clandro_step_setup_arch_variables
	CLANDRO_REAL_ARCH="$CLANDRO_ARCH"
	CLANDRO_REAL_HOST_PLATFORM="$CLANDRO_HOST_PLATFORM"

	if [ "$CLANDRO_PACKAGE_LIBRARY" = "bionic" ]; then
		if [ "$CLANDRO_ON_DEVICE_BUILD" = "false" ] && [ ! -d "$NDK" ]; then
			clandro_error_exit "NDK ($NDK) not pointing at a directory!"
		fi

		if [ "$CLANDRO_ON_DEVICE_BUILD" = "false" ] && ! grep -s -q "Pkg.Revision = $CLANDRO_NDK_VERSION_NUM" "$NDK/source.properties"; then
			clandro_error_exit "Wrong NDK version - we need $CLANDRO_NDK_VERSION"
		fi
	elif [ "$CLANDRO_PACKAGE_LIBRARY" = "glibc" ]; then
		if [ "$CLANDRO_ON_DEVICE_BUILD" = "true" ]; then
			if [ -n "${LD_PRELOAD-}" ]; then
				unset LD_PRELOAD
			fi
			if [ ! -d "${CLANDRO_PREFIX}/bin" ]; then
				clandro_error_exit "Glibc components are not installed, run './scripts/setup-clandro-glibc.sh'"
			fi
		else
			if [ ! -d "${CGCT_DIR}/${CLANDRO_ARCH}/bin" ]; then
				clandro_error_exit "The cgct tools were not found, run './scripts/setup-cgct.sh'"
			fi
		fi
	fi

	# The build tuple that may be given to --build configure flag:
	CLANDRO_BUILD_TUPLE=$(sh "$CLANDRO_SCRIPTDIR/scripts/config.guess")

	# We do not put all of build-tools/$CLANDRO_ANDROID_BUILD_TOOLS_VERSION/ into PATH
	# to avoid stuff like arm-linux-androideabi-ld there to conflict with ones from
	# the standalone toolchain.
	CLANDRO_D8=$ANDROID_HOME/build-tools/$CLANDRO_ANDROID_BUILD_TOOLS_VERSION/d8

	CLANDRO_COMMON_CACHEDIR="$CLANDRO_TOPDIR/_cache"
	CLANDRO_ELF_CLEANER=$CLANDRO_COMMON_CACHEDIR/clandro-elf-cleaner

	export prefix=${CLANDRO_PREFIX}
	export PREFIX=${CLANDRO_PREFIX}
	export CLANDRO_PREFIX=${CLANDRO_PREFIX}
	export CLANDRO_APP_PACKAGE=${CLANDRO_APP_PACKAGE}
	export CLANDRO_BASE_DIR=${CLANDRO_BASE_DIR}
	export CLANDRO_CACHE_DIR=${CLANDRO_CACHE_DIR}

	# Explicitly export in case the default was set.
	export CLANDRO_ARCH=${CLANDRO_ARCH}

	if [ "${CLANDRO_PACKAGES_OFFLINE-false}" = "true" ]; then
		# In "offline" mode store/pick cache from directory with
		# build.sh script.
		CLANDRO_PKG_CACHEDIR=$CLANDRO_PKG_BUILDER_DIR/cache
	else
		CLANDRO_PKG_CACHEDIR=$CLANDRO_TOPDIR/$CLANDRO_PKG_NAME/cache
	fi
	CLANDRO_PKG_CMAKE_BUILD=Ninja # Which cmake generator to use
	CLANDRO_PKG_ANTI_BUILD_DEPENDS="" # This cannot be used to "resolve" circular dependencies
	CLANDRO_PKG_BREAKS="" # https://www.debian.org/doc/debian-policy/ch-relationships.html#s-binarydeps
	CLANDRO_PKG_BUILDDIR=$CLANDRO_TOPDIR/$CLANDRO_PKG_NAME/build
	CLANDRO_PKG_BUILD_DEPENDS=""
	CLANDRO_PKG_BUILD_IN_SRC=false
	CLANDRO_PKG_BUILD_MULTILIB=false # multilib-compilation (compilation of 32-bit packages for 64-bit devices)
	CLANDRO_PKG_BUILD_ONLY_MULTILIB=false # Specifies that the package is compiled only via multilib-compilation. Enabled automatically if multilib-compilation is enabled and the `CLANDRO_PKG_EXCLUDED_ARCHES` variable contains `arm` and `i686` values.
	CLANDRO_PKG_MULTILIB_BUILDDIR=$CLANDRO_TOPDIR/$CLANDRO_PKG_NAME/multilib-build # path to the assembled components of the 32-bit package if multilib-compilation is enabled
	CLANDRO_PKG_CONFFILES=""
	CLANDRO_PKG_CONFLICTS="" # https://www.debian.org/doc/debian-policy/ch-relationships.html#s-conflicts
	CLANDRO_PKG_DEPENDS=""
	CLANDRO_PKG_DESCRIPTION="FIXME:Add description"
	CLANDRO_PKG_DISABLE_GIR=false # clandro_setup_gir
	CLANDRO_PKG_ESSENTIAL=false
	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS=""
	CLANDRO_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS=""
	CLANDRO_PKG_EXTRA_MAKE_ARGS=""
	CLANDRO_PKG_EXTRA_UNDEF_SYMBOLS_TO_CHECK="" # space-separated undefined symbols to check in clandro_step_massaging
	CLANDRO_PKG_FORCE_CMAKE=false # if the package has autotools as well as cmake, then set this to prefer cmake
	CLANDRO_PKG_GIT_BRANCH="" # branch defaults to 'v$CLANDRO_PKG_VERSION' unless this variable is defined
	CLANDRO_PKG_HAS_DEBUG=true # set to false if debug build doesn't exist or doesn't work, for example for python based packages
	CLANDRO_PKG_HOMEPAGE=""
	CLANDRO_PKG_HOSTBUILD=false # Set if a host build should be done in CLANDRO_PKG_HOSTBUILD_DIR:
	CLANDRO_PKG_HOSTBUILD_DIR=$CLANDRO_TOPDIR/$CLANDRO_PKG_NAME/host-build
	CLANDRO_PKG_LICENSE_FILE="" # Relative path from $CLANDRO_PKG_SRCDIR to LICENSE file. It is installed to $CLANDRO_PREFIX/share/$CLANDRO_PKG_NAME.
	CLANDRO_PKG_MASSAGEDIR=$CLANDRO_TOPDIR/$CLANDRO_PKG_NAME/massage
	CLANDRO_PKG_METAPACKAGE=false
	CLANDRO_PKG_NO_ELF_CLEANER=false # set this to true to disable running of clandro-elf-cleaner on built binaries
	CLANDRO_PKG_NO_REPLACE_GUESS_SCRIPTS=false # if true, do not find and replace config.guess and config.sub in source directory
	CLANDRO_PKG_NO_SHEBANG_FIX=false # if true, skip fixing shebang accordingly to CLANDRO_PREFIX
	CLANDRO_PKG_NO_SHEBANG_FIX_FILES="" # files to be excluded from fixing shebang
	CLANDRO_PKG_NO_STRIP=false # set this to true to disable stripping binaries
	CLANDRO_PKG_NO_STATICSPLIT=false
	CLANDRO_PKG_STATICSPLIT_EXTRA_PATTERNS=""
	CLANDRO_PKG_PACKAGEDIR=$CLANDRO_TOPDIR/$CLANDRO_PKG_NAME/package
	CLANDRO_PKG_PLATFORM_INDEPENDENT=false
	CLANDRO_PKG_PRE_DEPENDS=""
	CLANDRO_PKG_PROVIDES="" #https://www.debian.org/doc/debian-policy/#virtual-packages-provides
	CLANDRO_PKG_RECOMMENDS="" # https://www.debian.org/doc/debian-policy/ch-relationships.html#s-binarydeps
	CLANDRO_PKG_REPLACES=""
	CLANDRO_PKG_REVISION="0" # http://www.debian.org/doc/debian-policy/ch-controlfields.html#s-f-Version
	CLANDRO_PKG_RM_AFTER_INSTALL=""
	CLANDRO_PKG_SHA256=""
	CLANDRO_PKG_SRCDIR=$CLANDRO_TOPDIR/$CLANDRO_PKG_NAME/src
	CLANDRO_PKG_SUGGESTS=""
	CLANDRO_PKG_TMPDIR=$CLANDRO_TOPDIR/$CLANDRO_PKG_NAME/tmp
	CLANDRO_PKG_UNDEF_SYMBOLS_FILES="" # maintainer acknowledges these files have undefined symbols will not result in broken packages, eg: all, *.elf, ./path/to/file. "error" to always print results as errors
	CLANDRO_PKG_NO_OPENMP_CHECK=false # if true, skip the openmp check
	CLANDRO_PKG_SERVICE_SCRIPT=() # Fill with entries like: ("daemon name" 'script to execute'). Script is echoed with -e so can contain \n for multiple lines
	CLANDRO_PKG_GROUPS="" # https://wiki.archlinux.org/title/Pacman#Installing_package_groups
	CLANDRO_PKG_ON_DEVICE_BUILD_NOT_SUPPORTED=false # if the package does not support compilation on a device, then this package should not be compiled on devices
	CLANDRO_PKG_SETUP_PYTHON=false # setting python to compile a package
	CLANDRO_PYTHON_VERSION="$( # get the latest version of python
		if [[ "${CLANDRO_PACKAGE_LIBRARY}" == "bionic" ]]; then
			. "$CLANDRO_SCRIPTDIR/packages/python/build.sh"
		else # glibc
			. "$CLANDRO_SCRIPTDIR/gpkg/python/build.sh"
		fi
		echo "$_MAJOR_VERSION"
	)"
	CLANDRO_PKG_PYTHON_TARGET_DEPS="" # python modules to be installed via pip3
	CLANDRO_PKG_PYTHON_CROSS_BUILD_DEPS="" # python modules to be installed via build-pip
	CLANDRO_PKG_PYTHON_COMMON_BUILD_DEPS="" # python modules to be installed via pip3 or build-pip
	CLANDRO_PKG_PYTHON_RUNTIME_DEPS="" # python modules to be installed via pip3 in debscriptps
	CLANDRO_PYTHON_CROSSENV_PREFIX="$CLANDRO_TOPDIR/python${CLANDRO_PYTHON_VERSION}-crossenv-prefix-$CLANDRO_PACKAGE_LIBRARY-$CLANDRO_ARCH" # python modules dependency location (only used in non-devices)
	CLANDRO_PYTHON_CROSSENV_BUILDHOME="$CLANDRO_PYTHON_CROSSENV_PREFIX/build/lib/python${CLANDRO_PYTHON_VERSION}"
	CLANDRO_PYTHON_HOME=$CLANDRO__PREFIX__LIB_DIR/python${CLANDRO_PYTHON_VERSION} # location of python libraries
	CLANDRO_LLVM_VERSION="$( # get the latest version of LLVM
		if [[ "${CLANDRO_PACKAGE_LIBRARY}" == "bionic" ]]; then
			. "$CLANDRO_SCRIPTDIR/packages/libllvm/build.sh"
		else # glibc
			. "$CLANDRO_SCRIPTDIR/gpkg/llvm/build.sh"
		fi
		echo "$CLANDRO_PKG_VERSION"
	)"
	CLANDRO_LLVM_MAJOR_VERSION="${CLANDRO_LLVM_VERSION%%.*}"
	CLANDRO_LLVM_NEXT_MAJOR_VERSION="$((CLANDRO_LLVM_MAJOR_VERSION + 1))"
	CLANDRO_PKG_MESON_NATIVE=false
	CLANDRO_PKG_CMAKE_CROSSCOMPILING=true
	CLANDRO_PROOT_EXTRA_ENV_VARS="" # Extra environvent variables for proot command in clandro_setup_proot

	unset CFLAGS CPPFLAGS LDFLAGS CXXFLAGS
	unset CLANDRO_MESON_ENABLE_SOVERSION # setenv to enable SOVERSION suffix for shared libs built with Meson
}

# Setting architectural information according to the `CLANDRO_ARCH` variable
clandro_step_setup_arch_variables() {
	if [ "x86_64" = "$CLANDRO_ARCH" ] || [ "aarch64" = "$CLANDRO_ARCH" ]; then
		CLANDRO_ARCH_BITS=64
	else
		CLANDRO_ARCH_BITS=32
	fi

	if [ "$CLANDRO_PACKAGE_LIBRARY" = "bionic" ]; then
		CLANDRO_HOST_PLATFORM="${CLANDRO_ARCH}-linux-android"
	else
		CLANDRO_HOST_PLATFORM="${CLANDRO_ARCH}-linux-gnu"
	fi
	if [ "$CLANDRO_ARCH" = "arm" ]; then
		CLANDRO_HOST_PLATFORM="${CLANDRO_HOST_PLATFORM}eabi"
		if [ "$CLANDRO_PACKAGE_LIBRARY" = "glibc" ]; then
			CLANDRO_HOST_PLATFORM="${CLANDRO_HOST_PLATFORM}hf"
		fi
	fi
}
