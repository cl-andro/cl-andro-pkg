CLANDRO_PKG_HOMEPAGE=https://sourceforge.net/projects/nsis/
CLANDRO_PKG_DESCRIPTION="A professional open source system to create Windows installers"
# Licenses: zlib/libpng, bzip2, CPL-1.0
CLANDRO_PKG_LICENSE="custom"
CLANDRO_PKG_LICENSE_FILE="COPYING"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.12"
CLANDRO_PKG_SRCURL=https://prdownloads.sourceforge.net/nsis/nsis-${CLANDRO_PKG_VERSION}-src.tar.bz2
CLANDRO_PKG_SHA256=f3ed7a8e4aa2cf4e8cf47d3b563a02559e0cb4934db2662b2f9661b824e2b186
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libandroid-support, libc++, libiconv, nsis-stubs, zlib"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make_install() {
	scons \
		CC="$(command -v $CC)" \
		CXX="$(command -v $CXX)" \
		APPEND_CCFLAGS="$CFLAGS $CPPFLAGS" \
		APPEND_LINKFLAGS="$LDFLAGS" \
		SKIPSTUBS=all \
		SKIPPLUGINS=all \
		SKIPUTILS=all \
		SKIPMISC=all \
		NSIS_CONFIG_CONST_DATA_PATH=no \
		PREFIX="$CLANDRO_PREFIX/opt/nsis/nsis" \
		install-compiler
}

clandro_step_post_make_install() {
	ln -sfr $CLANDRO_PREFIX/opt/nsis/nsis/makensis $CLANDRO_PREFIX/bin/

	rm -rf _nsis-stubs
	mkdir -p _nsis-stubs
	pushd _nsis-stubs
	tar xf $CLANDRO_PKG_BUILDER_DIR/nsis-stubs.tar.xz --strip-components=1
	install -Dm600 -t $CLANDRO_PREFIX/opt/nsis/Stubs *
	popd
}
