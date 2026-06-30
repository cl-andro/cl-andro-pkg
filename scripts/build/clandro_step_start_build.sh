clandro_step_start_build() {
	# shellcheck source=/dev/null
	source "$CLANDRO_PKG_BUILDER_SCRIPT"
	# Path to hostbuild marker, for use if package has hostbuild step
	CLANDRO_HOSTBUILD_MARKER="$CLANDRO_PKG_HOSTBUILD_DIR/CLANDRO_BUILT_FOR_$CLANDRO_PKG_VERSION"

	if [ "$CLANDRO_PKG_METAPACKAGE" = "true" ]; then
		# Metapackage has no sources
		CLANDRO_PKG_SKIP_SRC_EXTRACT=true
		# Usually metapackages are also platform dependent but it is not always the
		# right decision to mark them as such when they depend on packages which may
		# not be available for all architectures
		# CLANDRO_PKG_PLATFORM_INDEPENDENT=true
	fi

	if [ -n "${CLANDRO_PKG_EXCLUDED_ARCHES:=""}" ] && [ "$CLANDRO_PKG_EXCLUDED_ARCHES" != "${CLANDRO_PKG_EXCLUDED_ARCHES/$CLANDRO_ARCH/}" ]; then
		echo "Skipping building $CLANDRO_PKG_NAME for arch $CLANDRO_ARCH"
		exit 0
	fi

	if [ -n "$CLANDRO_PKG_PYTHON_COMMON_BUILD_DEPS" ] || [[ "$CLANDRO_ON_DEVICE_BUILD" = "false" && -n "$CLANDRO_PKG_PYTHON_CROSS_BUILD_DEPS" ]] || [[ "$CLANDRO_ON_DEVICE_BUILD" = "true" && -n "$CLANDRO_PKG_PYTHON_TARGET_DEPS" ]]; then
		# Enable python setting
		CLANDRO_PKG_SETUP_PYTHON=true
	fi
	if [ -z "$CLANDRO_PKG_PYTHON_RUNTIME_DEPS" ]; then
		CLANDRO_PKG_PYTHON_RUNTIME_DEPS="$CLANDRO_PKG_PYTHON_TARGET_DEPS"
	fi
	if [ "$CLANDRO_PKG_PYTHON_RUNTIME_DEPS" = "false" ]; then
		CLANDRO_PKG_PYTHON_RUNTIME_DEPS=""
	fi

	CLANDRO_PKG_FULLVERSION=$CLANDRO_PKG_VERSION
	if [ "$CLANDRO_PKG_REVISION" != "0" ] || [ "$CLANDRO_PKG_FULLVERSION" != "${CLANDRO_PKG_FULLVERSION/-/}" ]; then
		# "0" is the default revision, so only include it if the upstream versions contains "-" itself
		CLANDRO_PKG_FULLVERSION+="-$CLANDRO_PKG_REVISION"
	fi
	# full format version for pacman
	local CLANDRO_PKG_VERSION_EDITED=${CLANDRO_PKG_VERSION//-/.}
	local INCORRECT_SYMBOLS=$(echo $CLANDRO_PKG_VERSION_EDITED | grep -o '[0-9][a-z]')
	if [ -n "$INCORRECT_SYMBOLS" ]; then
		local CLANDRO_PKG_VERSION_EDITED=${CLANDRO_PKG_VERSION_EDITED//${INCORRECT_SYMBOLS:0:1}${INCORRECT_SYMBOLS:1:1}/${INCORRECT_SYMBOLS:0:1}.${INCORRECT_SYMBOLS:1:1}}
	fi
	CLANDRO_PKG_FULLVERSION_FOR_PACMAN="${CLANDRO_PKG_VERSION_EDITED}"
	if [ -n "$CLANDRO_PKG_REVISION" ]; then
		CLANDRO_PKG_FULLVERSION_FOR_PACMAN+="-${CLANDRO_PKG_REVISION}"
	else
		CLANDRO_PKG_FULLVERSION_FOR_PACMAN+="-0"
	fi

	if [ "$CLANDRO_DEBUG_BUILD" = "true" ]; then
		if [ "$CLANDRO_PKG_HAS_DEBUG" = "true" ]; then
			DEBUG="-dbg"
		else
			echo "Skipping building debug build for $CLANDRO_PKG_NAME"
			exit 0
		fi
	else
		DEBUG=""
	fi

	if [ "$CLANDRO_DEBUG_BUILD" = "false" ] && [ "$CLANDRO_FORCE_BUILD" = "false" ]; then
		if [ -e "$CLANDRO_BUILT_PACKAGES_DIRECTORY/$CLANDRO_PKG_NAME" ] &&
			[ "$(cat "$CLANDRO_BUILT_PACKAGES_DIRECTORY/$CLANDRO_PKG_NAME")" = "$CLANDRO_PKG_FULLVERSION" ]; then
			echo "$CLANDRO_PKG_NAME@$CLANDRO_PKG_FULLVERSION built - skipping (rm $CLANDRO_BUILT_PACKAGES_DIRECTORY/$CLANDRO_PKG_NAME to force rebuild)"
			exit 0
		elif [ "$CLANDRO_ON_DEVICE_BUILD" = "true" ] &&
			([[ "$CLANDRO_APP_PACKAGE_MANAGER" = "apt" && "$(dpkg-query -W -f '${db:Status-Status} ${Version}\n' "$CLANDRO_PKG_NAME" 2>/dev/null)" = "installed $CLANDRO_PKG_FULLVERSION" ]] ||
			 [[ "$CLANDRO_APP_PACKAGE_MANAGER" = "pacman" && "$(pacman -Q $CLANDRO_PKG_NAME 2>/dev/null)" = "$CLANDRO_PKG_NAME $CLANDRO_PKG_FULLVERSION_FOR_PACMAN" ]]); then
			echo "$CLANDRO_PKG_NAME@$CLANDRO_PKG_FULLVERSION installed - skipping"
			exit 0
		fi
	fi

	if [ "$CLANDRO_ON_DEVICE_BUILD" = "true" ] || [ "$CLANDRO_ARCH_BITS" = "32" ]; then
		CLANDRO_PKG_BUILD_MULTILIB=false
	fi
	if [ "$CLANDRO_PKG_BUILD_MULTILIB" = "true" ] && [ $(tr ' ' '\n' <<< "${CLANDRO_PKG_EXCLUDED_ARCHES//,/}" | grep -c -e '^arm$' -e '^i686$') = "2" ]; then
		CLANDRO_PKG_BUILD_ONLY_MULTILIB=true
	fi

	echo "clandro - building $CLANDRO_PKG_NAME for arch $CLANDRO_ARCH..."
	test -t 1 && printf "\033]0;%s...\007" "$CLANDRO_PKG_NAME"

	# Avoid exporting PKG_CONFIG_LIBDIR until after clandro_step_host_build.
	clandro_step_setup_pkg_config_libdir

	local CLANDRO_PKG_BUILDDIR_ORIG="$CLANDRO_PKG_BUILDDIR"
	if [ "$CLANDRO_PKG_BUILD_IN_SRC" = "true" ]; then
		CLANDRO_PKG_BUILDDIR=$CLANDRO_PKG_SRCDIR
	fi
	if [ "$CLANDRO_PKG_BUILD_MULTILIB" = "true" ] && [ "$CLANDRO_PKG_BUILD_ONLY_MULTILIB" = "false" ] && ([ "$CLANDRO_PKG_BUILD_IN_SRC" = "true" ] || [ "$CLANDRO_PKG_MULTILIB_BUILDDIR" = "$CLANDRO_PKG_BUILDDIR" ]); then
		clandro_error_exit "It is not possible to build 32-bit and 64-bit versions of a package in one place, the build location must be separate."
	fi

	if [ "$CLANDRO_CONTINUE_BUILD" == "true" ]; then
		# If the package has a hostbuild step, verify that it has been built
		if [ "$CLANDRO_PKG_HOSTBUILD" == "true" ] && [ ! -f "$CLANDRO_HOSTBUILD_MARKER" ]; then
			clandro_error_exit "Cannot continue this build, hostbuilt tools are missing"
		fi

		# Set CLANDRO_ELF_CLEANER for on-device continued build
		if [ "$CLANDRO_PACKAGE_LIBRARY" = "bionic" ] && [ "$CLANDRO_ON_DEVICE_BUILD" = "true" ]; then
			CLANDRO_ELF_CLEANER="$(command -v clandro-elf-cleaner)"
		fi
		# The rest in this function can be skipped when doing
		# a continued build
		return
	fi

	if [ "$CLANDRO_ON_DEVICE_BUILD" = "true" ] && [ "$CLANDRO_PKG_ON_DEVICE_BUILD_NOT_SUPPORTED" = "true" ]; then
		clandro_error_exit "Package '$CLANDRO_PKG_NAME' is not available for on-device builds."
	fi

	# Delete and re-create the directories used for building the package
	clandro_step_setup_build_folders

	if [ "$CLANDRO_PKG_BUILD_IN_SRC" = "true" ]; then
		# Create a file for users to know that the build directory not containing any built files is expected behaviour
		echo "Building in src due to CLANDRO_PKG_BUILD_IN_SRC being set to true" > "$CLANDRO_PKG_BUILDDIR_ORIG/BUILDING_IN_SRC.txt"
	fi

	if [ "$CLANDRO_PACKAGE_LIBRARY" = "bionic" ]; then
		if [ "$CLANDRO_ON_DEVICE_BUILD" = "true" ]; then
			case "$CLANDRO_APP_PACKAGE_MANAGER" in
				"apt") apt install -y clandro-elf-cleaner;;
				"pacman") pacman -S clandro-elf-cleaner --needed --noconfirm;;
			esac
			CLANDRO_ELF_CLEANER="$(command -v clandro-elf-cleaner)"
		else
			local CLANDRO_ELF_CLEANER_VERSION
			CLANDRO_ELF_CLEANER_VERSION=$(bash -c ". $CLANDRO_SCRIPTDIR/packages/clandro-elf-cleaner/build.sh; echo \$CLANDRO_PKG_VERSION")
			clandro_download \
				"https://github.com/termux/clandro-elf-cleaner/releases/download/v${CLANDRO_ELF_CLEANER_VERSION}/clandro-elf-cleaner" \
				"$CLANDRO_ELF_CLEANER" \
				59645fb25b84d11f108436e83d9df5e874ba4eb76ab62948869a23a3ee692fa7
			chmod u+x "$CLANDRO_ELF_CLEANER"
		fi

		# Some packages search for libutil, libpthread and librt even
		# though this functionality is provided by libc.  Provide
		# library stubs so that such configure checks succeed.
		mkdir -p "$CLANDRO_PREFIX/lib"
		for lib in libutil.so libpthread.so librt.so; do
			if [ ! -f $CLANDRO_PREFIX/lib/$lib ]; then
				echo 'INPUT(-lc)' > $CLANDRO_PREFIX/lib/$lib
			fi
		done
	fi
}

clandro_step_setup_pkg_config_libdir() {
	export CLANDRO_PKG_CONFIG_LIBDIR=$CLANDRO__PREFIX__LIB_DIR/pkgconfig:$CLANDRO_PREFIX/share/pkgconfig
}
