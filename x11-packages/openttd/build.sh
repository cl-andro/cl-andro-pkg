CLANDRO_PKG_HOMEPAGE=https://www.openttd.org/
CLANDRO_PKG_DESCRIPTION="An engine for running Transport Tycoon Deluxe"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="15.3"
CLANDRO_PKG_SRCURL=git+https://github.com/OpenTTD/OpenTTD
CLANDRO_PKG_GIT_BRANCH="$CLANDRO_PKG_VERSION"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="fontconfig, freetype, libc++, libicu, liblzma, liblzo, libpng, openttd-gfx, openttd-msx, openttd-sfx, sdl2 | sdl2-compat, zlib"
CLANDRO_PKG_ANTI_BUILD_DEPENDS="sdl2-compat"
CLANDRO_PKG_RECOMMENDS="desktop-file-utils, hicolor-icon-theme"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DBINARY_NAME=openttd
-DCMAKE_INSTALL_DATADIR=share
-DCMAKE_INSTALL_BINDIR=bin
"
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS="
-DOPTION_DEDICATED=ON
"

clandro_step_host_build() {
	clandro_setup_cmake
	cmake "$CLANDRO_PKG_SRCDIR" $CLANDRO_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS
	make -j $CLANDRO_PKG_MAKE_PROCESSES
}

clandro_step_pre_configure() {
	if [ "$CLANDRO_ON_DEVICE_BUILD" = "false" ]; then
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DHOST_BINARY_DIR=$CLANDRO_PKG_HOSTBUILD_DIR"
	fi
	CXXFLAGS+=" -DU_USING_ICU_NAMESPACE=1"
}
