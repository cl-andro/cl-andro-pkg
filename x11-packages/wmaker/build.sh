CLANDRO_PKG_HOMEPAGE=https://www.windowmaker.org/
CLANDRO_PKG_DESCRIPTION="An X11 window manager that reproduces the look and feel of the NeXTSTEP user interface"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.96.0"
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=https://github.com/window-maker/wmaker/releases/download/wmaker-${CLANDRO_PKG_VERSION}/WindowMaker-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=4fe130ba23cf4aa21c156ec8f01f748df537d0604ec06c6bbcec896df1926f6d
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="fontconfig, freetype, giflib, glib, harfbuzz, imagemagick, libandroid-shmem, libexif, libjpeg-turbo, libpng, libtiff, libwebp, libx11, libxext, libxft, libxinerama, libxmu, libxpm, pango"
CLANDRO_PKG_BUILD_DEPENDS="xorgproto"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--enable-pango
--x-includes=${CLANDRO_PREFIX}/include
--x-libraries=${CLANDRO_PREFIX}/lib"

clandro_step_pre_configure() {
	export LIBS="-landroid-shmem"
	export CFLAGS="$CFLAGS -I${CLANDRO_PKG_BUILDDIR}/WINGs"
	export LDFLAGS="$LDFLAGS -static-openmp"
}
