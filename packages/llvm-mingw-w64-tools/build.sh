CLANDRO_PKG_HOMEPAGE=https://github.com/mstorsjo/llvm-mingw
CLANDRO_PKG_DESCRIPTION="MinGW-w64 tools for LLVM-MinGW"
CLANDRO_PKG_LICENSE="custom"
CLANDRO_PKG_MAINTAINER="@licy183"
CLANDRO_PKG_VERSION=12.0.0
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://downloads.sourceforge.net/mingw-w64/mingw-w64/mingw-w64-release/mingw-w64-v${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=cc41898aac4b6e8dd5cffd7331b9d9515b912df4420a3a612b5ea2955bbeed2f
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_BUILD_DEPENDS="llvm-mingw-w64-ucrt"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_configure() {
	:
}

clandro_step_make() {
	mkdir -p "$CLANDRO_PREFIX/opt/llvm-mingw-w64"
	local _INSTALL_PREFIX="$CLANDRO_PREFIX/opt/llvm-mingw-w64"
	local _INCLUDE_DIR="$_INSTALL_PREFIX/generic-w64-mingw32/include"

	( # Build gendef
	cd mingw-w64-tools/gendef && mkdir -p build
	cd build && \
	../configure --host="$CLANDRO_HOST_PLATFORM" --prefix="$_INSTALL_PREFIX"
	make -j "$CLANDRO_PKG_MAKE_PROCESSES"
	make install-strip
	mkdir -p "$_INSTALL_PREFIX/share/gendef"
	install -m644 ../COPYING "$_INSTALL_PREFIX/share/gendef"
	)

	( # Build widl
	cd mingw-w64-tools/widl && mkdir -p build
	cd build && \
	../configure --host="$CLANDRO_HOST_PLATFORM" \
				--prefix="$_INSTALL_PREFIX" \
				--target=x86_64-w64-mingw32 \
				--with-widl-includedir="$_INCLUDE_DIR"
	make -j "$CLANDRO_PKG_MAKE_PROCESSES"
	make install-strip
	mkdir -p "$_INSTALL_PREFIX/share/widl"
	install -m644 ../../../COPYING "$_INSTALL_PREFIX/share/widl"
	)

	# The build above produced x86_64-w64-mingw32-widl, add symlinks to it
	# with other prefixes.
	local _arch
	for _arch in aarch64 armv7 i686; do
		ln -sf x86_64-w64-mingw32-widl "$_INSTALL_PREFIX/bin/$_arch-w64-mingw32-widl"
	done
	for _arch in aarch64 armv7 i686 x86_64; do
		ln -sf x86_64-w64-mingw32-widl "$_INSTALL_PREFIX/bin/$_arch-w64-mingw32uwp-widl"
	done
}

clandro_step_make_install() {
	local _INSTALL_PREFIX="$CLANDRO_PREFIX/opt/llvm-mingw-w64"
	mkdir -p "$CLANDRO_PREFIX/bin"

	# Symlinks tools to $PREFIX/bin
	local _tool
	for _tool in gendef {aarch64,armv7,i686,x86_64}-w64-mingw32{,uwp}-widl; do
		ln -sfr "$_INSTALL_PREFIX/bin/$_tool" "$CLANDRO_PREFIX/bin/$_tool"
	done
}

clandro_step_install_license() {
	mkdir -p "$CLANDRO_PREFIX/share/doc/$CLANDRO_PKG_NAME"

	cp "$CLANDRO_PREFIX/opt/llvm-mingw-w64/share/gendef/COPYING" "$CLANDRO_PREFIX/share/doc/$CLANDRO_PKG_NAME/COPYING-gendef"
	cp "$CLANDRO_PREFIX/opt/llvm-mingw-w64/share/widl/COPYING" "$CLANDRO_PREFIX/share/doc/$CLANDRO_PKG_NAME/COPYING-widl"
}
