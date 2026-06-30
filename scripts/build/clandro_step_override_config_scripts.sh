# shellcheck disable=SC2031 # this warning is triggering erroneously because of the `$(. pkg/build.sh; echo "$var")`
clandro_step_override_config_scripts() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" = true || "$CLANDRO_PACKAGE_LIBRARY" = "glibc" ]]; then
		return
	fi

	# Make $CLANDRO_PREFIX/bin/sh executable on the builder, so that build
	# scripts can assume that it works on both builder and host later on:
	ln -sf /bin/sh "$CLANDRO_PREFIX/bin/sh"

	# Does this package or its build depend on 'libllvm'?
	if [[ "$CLANDRO_PKG_DEPENDS" != "${CLANDRO_PKG_DEPENDS/libllvm/}" ||
		"$CLANDRO_PKG_BUILD_DEPENDS" != "${CLANDRO_PKG_BUILD_DEPENDS/libllvm/}" ]]; then
		LLVM_DEFAULT_TARGET_TRIPLE="$CLANDRO_HOST_PLATFORM"
		case "$CLANDRO_ARCH" in
			"arm") LLVM_TARGET_ARCH=ARM;;
			"aarch64") LLVM_TARGET_ARCH=AArch64;;
			"i686") LLVM_TARGET_ARCH=X86;;
			"x86_64") LLVM_TARGET_ARCH=X86;;
		esac

		sed "$CLANDRO_SCRIPTDIR/packages/libllvm/llvm-config.in" \
			-e "s|@CLANDRO_PKG_VERSION@|$CLANDRO_LLVM_VERSION|g" \
			-e "s|@CLANDRO_PREFIX@|$CLANDRO_PREFIX|g" \
			-e "s|@LLVM_TARGET_ARCH@|$LLVM_TARGET_ARCH|g" \
			-e "s|@LLVM_DEFAULT_TARGET_TRIPLE@|$LLVM_DEFAULT_TARGET_TRIPLE|g" \
			-e "s|@CLANDRO_ARCH@|$CLANDRO_ARCH|g" \
			> "$CLANDRO_PREFIX/bin/llvm-config"
		chmod 755 "$CLANDRO_PREFIX/bin/llvm-config"
	fi

	# Does this package or its build depend on 'postgresql'?
	if [[ "$CLANDRO_PKG_DEPENDS" != "${CLANDRO_PKG_DEPENDS/postgresql/}" ||
		"$CLANDRO_PKG_BUILD_DEPENDS" != "${CLANDRO_PKG_BUILD_DEPENDS/postgresql/}" ]]; then
		local postgresql_version
		postgresql_version="$(. "$CLANDRO_SCRIPTDIR/packages/postgresql/build.sh"; echo "$CLANDRO_PKG_VERSION")"
		sed "$CLANDRO_SCRIPTDIR/packages/postgresql/pg_config.in" \
			-e "s|@POSTGRESQL_VERSION@|$postgresql_version|g" \
			-e "s|@CLANDRO_HOST_PLATFORM@|$CLANDRO_HOST_PLATFORM|g" \
			-e "s|@CLANDRO_PREFIX@|$CLANDRO_PREFIX|g" \
			> "$CLANDRO_PREFIX/bin/pg_config"
		chmod 755 "$CLANDRO_PREFIX/bin/pg_config"
	fi

	# Does this package or its build depend on 'aosp-libs' or 'aosp-utils'?
	# if so, complete the symbolic link chain from /system to $CLANDRO_PREFIX/opt/aosp,
	# otherwise break the symbolic link /system, to prevent the i686 and x86_64 builds of packages
	# that use purely traditional Autotools cross-compilation, like guile, from having
	# "checking whether we are cross compiling... no"
	# followed by
	# "configure: error: No iconv support.  Please recompile libunistring with iconv enabled."
	# if the Autotools cross-compilation temporary conftest binary manages to run
	# in Ubuntu due to the presence of /system/lib(64)/libc.so and /system/bin/linker(64)
	# that are intended only for use with packages that have a build dependency on 'aosp-libs'.
	# See scripts/setup-ubuntu.sh and scripts/build/setup/clandro_setup_proot.sh for more information.
	rm -f "$CLANDRO_APP__DATA_DIR/aosp"
	case "$CLANDRO_PKG_DEPENDS $CLANDRO_PKG_BUILD_DEPENDS" in
		*aosp-libs*|*aosp-utils*)
			ln -sf "$CLANDRO_PREFIX/opt/aosp" "$CLANDRO_APP__DATA_DIR/aosp"
		;;
	esac
}
