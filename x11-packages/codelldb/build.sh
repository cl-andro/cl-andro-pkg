CLANDRO_PKG_HOMEPAGE=https://github.com/vadimcn/codelldb
CLANDRO_PKG_DESCRIPTION="A native debugger extension for VSCode based on LLDB"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.12.2"
CLANDRO_PKG_SRCURL="https://github.com/vadimcn/codelldb/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=34e2aae22f5b5e4b03f854159d9a35f1c5527e0eb11b817e7d5e8bd513bb05e5
CLANDRO_PKG_AUTO_UPDATE=true
# codelldb does not work properly on 32-bit Android
CLANDRO_PKG_EXCLUDED_ARCHES="arm, i686"
CLANDRO_PKG_DEPENDS="lldb"
CLANDRO_PKG_CMAKE_BUILD="Unix Makefiles"
CLANDRO_PKG_EXTRA_MAKE_ARGS="vsix_full"

clandro_step_pre_configure() {
	clandro_setup_nodejs
	clandro_setup_rust

	# codelldb is a project that uses CMake in a slightly nonstandard way
	# (there is a place where the CMake build directory is hardcoded to
	# "[source directory]/build")
	# upstream only supports their official releases and not custom builds,
	# so this is not planned to be fixed upstream
	patch="$CLANDRO_PKG_BUILDER_DIR/fix-tsconfig-cmake-builddir-path.diff"
	echo "Applying patch: $(basename "$patch")"
	test -f "$patch" && sed \
		-e "s%\@CLANDRO_PKG_BUILDDIR\@%${CLANDRO_PKG_BUILDDIR}%g" \
		"$patch" | patch --silent -p1 -d"$CLANDRO_PKG_SRCDIR"

	patch="$CLANDRO_PKG_BUILDER_DIR/move-adapter-outside-vsix.diff"
	echo "Applying patch: $(basename "$patch")"
	test -f "$patch" && sed \
		-e "s%\@CLANDRO_PREFIX\@%${CLANDRO_PREFIX}%g" \
		-e "s%\@CLANDRO_PYTHON_HOME\@%${CLANDRO_PYTHON_HOME}%g" \
		"$patch" | patch --silent -p1 -d"$CLANDRO_PKG_SRCDIR"

	case $CLANDRO_ARCH in
		"aarch64") VSIX_ARCH="arm64";;
		"x86_64") VSIX_ARCH="x64";;
		*) clandro_error_exit "${CLANDRO_ARCH} is not a supported architecture."
	esac

	: "${CARGO_HOME:=$HOME/.cargo}"
	export CARGO_HOME
	rm -rf "$CARGO_HOME"/git/checkouts/weaklink-*

	cargo fetch --target "${CARGO_TARGET_NAME}"

	for dir in "$CARGO_HOME"/git/checkouts/weaklink-*/*; do
		patch --silent -p1 \
			-d "$dir" \
			< "$CLANDRO_PKG_BUILDER_DIR"/weaklink-android.diff
	done

	# goes with CMakeLists.txt.patch
	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DCARGO_TARGET_NAME=$CARGO_TARGET_NAME -DVSIX_PLATFORM=linux-$VSIX_ARCH"

	# avoids 'gyp: Undefined variable android_ndk_path in binding.gyp while trying to load binding.gyp'
	export GYP_DEFINES="android_ndk_path=''"
}

clandro_step_make_install() {
	# adapter binary and launcher binary for main package
	install -Dm700 -t "$CLANDRO_PREFIX/bin" "$CLANDRO_PKG_BUILDDIR/adapter/codelldb"
	install -Dm700 -t "$CLANDRO_PREFIX/bin" "$CLANDRO_PKG_BUILDDIR/bin/codelldb-launch"

	# python module for main package
	local codelldb_python_dest="$CLANDRO_PYTHON_HOME/site-packages/codelldb/"
	rm -rf "$codelldb_python_dest"
	mkdir -p "$codelldb_python_dest"
	cp -r "$CLANDRO_PKG_BUILDDIR"/adapter/scripts/codelldb/* "$codelldb_python_dest"
	install -Dm644 -t "$codelldb_python_dest" "$CLANDRO_PKG_BUILDDIR/adapter/scripts/debugger.py"

	# .vsix file for vsix-package-codelldb
	install -DTm644 "$CLANDRO_PKG_BUILDDIR/codelldb-full.vsix" \
		"$CLANDRO_PREFIX/opt/vsix-packages/codelldb-$CLANDRO_PKG_FULLVERSION.vsix"

	# subpackage file for code-oss-extension-codelldb
	install -DTm644 "$CLANDRO_PKG_SRCDIR/LICENSE" \
		"$CLANDRO_PREFIX/share/doc/code-oss-extension-codelldb/copyright"
}
