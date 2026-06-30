CLANDRO_PKG_HOMEPAGE=https://github.com/trentbuck/binutils-is-llvm
CLANDRO_PKG_DESCRIPTION="Use llvm as binutils"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
# The version number is different from the original one.
CLANDRO_PKG_VERSION=0.3
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_SKIP_SRC_EXTRACT=true
CLANDRO_PKG_DEPENDS="lld, llvm"
CLANDRO_PKG_CONFLICTS="binutils"

clandro_step_make_install() {
	ln -sf lld "$CLANDRO_PREFIX/bin/ld"
	local bin
	# Please do not include `as`. `llvm-as` is pretty different from GNU as.
	# Clang's `-fno-integrated-as` will not work as expected when `as` is a symlink to `llvm-as`.
	# `bin/as` is provided by the `binutils-bin` subpackage which does not collide with this package.
	local -a _UTILS=("addr2line" "ar" "nm" "objcopy" "objdump" "ranlib" "readelf" "size" "strings" "strip")
	for bin in "${_UTILS[@]}"; do
		ln -sf "llvm-${bin}" "$CLANDRO_PREFIX/bin/${bin}"
	done
	ln -sf llvm-cxxfilt "$CLANDRO_PREFIX/bin/c++filt"

	local dir=$CLANDRO_PREFIX/share/$CLANDRO_PKG_NAME
	mkdir -p "$dir"
	touch "$dir/.placeholder"

	# Add some arch-prefixed symlinks like binutils.
	local -a _UTILS_WITH_HOST_PREFIX=("ar" "ld" "nm" "objdump" "ranlib" "readelf" "strip")
	for bin in "${_UTILS_WITH_HOST_PREFIX[@]}"; do
		ln -sf "$bin" "$CLANDRO_PREFIX/bin/$CLANDRO_HOST_PLATFORM-$bin"
	done
}

clandro_step_install_license() {
	install -Dm600 -t "$CLANDRO_PREFIX/share/doc/$CLANDRO_PKG_NAME" \
		"$CLANDRO_PKG_BUILDER_DIR/LICENSE"
}
