clandro_step_setup_build_folders() {
	# Following directories may contain files with read-only
	# permissions which makes them undeletable. We need to fix
	# that.
	[ -d "$CLANDRO_PKG_BUILDDIR" ] && chmod +w -R "$CLANDRO_PKG_BUILDDIR" || true
	[ -d "$CLANDRO_PKG_MULTILIB_BUILDDIR" ] && chmod +w -R "$CLANDRO_PKG_MULTILIB_BUILDDIR" || true
	[ -d "$CLANDRO_PKG_SRCDIR" ] && chmod +w -R "$CLANDRO_PKG_SRCDIR" || true
	if [ "$CLANDRO_SKIP_DEPCHECK" = false ] && \
		   [ "$CLANDRO_INSTALL_DEPS" = true ] && \
		   [ "$CLANDRO_PKG_METAPACKAGE" = false ] && \
		   [ "$CLANDRO_PKGS__BUILD__RM_ALL_PKGS_BUILT_MARKER_AND_INSTALL_FILES" = true ] && \
		   [ "$CLANDRO_ON_DEVICE_BUILD" = false ]; then
		# Remove all previously extracted/built files from
		# $CLANDRO_PREFIX:
		rm -fr "$CLANDRO_PREFIX_CLASSICAL"
		rm -f "$CLANDRO_BUILT_PACKAGES_DIRECTORY"/*
	fi

	# Cleanup old build state:
	rm -Rf "$CLANDRO_PKG_BUILDDIR" \
		"$CLANDRO_PKG_MULTILIB_BUILDDIR" \
		"$CLANDRO_PKG_SRCDIR"

	# Cleanup old packaging state:
	rm -Rf "$CLANDRO_PKG_PACKAGEDIR" \
		"$CLANDRO_PKG_TMPDIR" \
		"$CLANDRO_PKG_MASSAGEDIR"

	# Cleanup cache directory containing package sources and hostbuild dir
	if [ "$CLANDRO_FORCE_BUILD" = true ] && \
			[ "$CLANDRO_PKGS__BUILD__RM_ALL_PKG_BUILD_DEPENDENT_DIRS" = true ]; then
		rm -Rf "$CLANDRO_PKG_CACHEDIR" "$CLANDRO_PKG_HOSTBUILD_DIR"
	fi

	# Create required directories, but not `CLANDRO_PKG_SRCDIR` as it
	# will be created during build. If `CLANDRO_PKG_SRCDIR` were
	# to be created, then `CLANDRO_PKG_SRCURL` like for `zip` would get
	# extracted to sub directories in `clandro_extract_src_archive()`.
	# If `CLANDRO_PKG_BUILD_IN_SRC` is `true`, then `CLANDRO_PKG_BUILDDIR`
	# will be equal to `CLANDRO_PKG_SRCDIR`, so do not create it in
	# that case.
	if [ "$CLANDRO_PKG_BUILDDIR" != "$CLANDRO_PKG_SRCDIR" ]; then
		mkdir -p "$CLANDRO_PKG_BUILDDIR"
	fi
	mkdir -p "$CLANDRO_COMMON_CACHEDIR" \
		 "$CLANDRO_COMMON_CACHEDIR-$CLANDRO_ARCH" \
		 "$CLANDRO_COMMON_CACHEDIR-all" \
		 "$CLANDRO_OUTPUT_DIR" \
		 "$CLANDRO_PKG_PACKAGEDIR" \
		 "$CLANDRO_PKG_TMPDIR" \
		 "$CLANDRO_PKG_CACHEDIR" \
		 "$CLANDRO_PKG_MASSAGEDIR"
	if [ "$CLANDRO_PKG_BUILD_MULTILIB" = "true" ] && [ "$CLANDRO_PKG_BUILD_ONLY_MULTILIB" = "false" ]; then
		mkdir -p "$CLANDRO_PKG_MULTILIB_BUILDDIR"
	fi
	if [ "$CLANDRO_PACKAGE_LIBRARY" = "bionic" ]; then
		mkdir -p $CLANDRO_PREFIX/{bin,etc,lib,libexec,share,share/LICENSES,tmp,include}
	elif [ "$CLANDRO_PACKAGE_LIBRARY" = "glibc" ]; then
		mkdir -p "$CLANDRO_PREFIX"/{bin,etc,lib,share,share/LICENSES,include}
		mkdir -p "$CLANDRO_PREFIX_CLASSICAL"/{bin,etc,tmp}
	fi

	# Required for creating `BUILDING_IN_SRC.txt` file in clandro_step_start_build
	if [ "$CLANDRO_PKG_BUILDDIR_ORIG" != "$CLANDRO_PKG_BUILDDIR" ]; then
		rm -Rf "$CLANDRO_PKG_BUILDDIR_ORIG"
		mkdir -p "$CLANDRO_PKG_BUILDDIR_ORIG"
	fi
}
