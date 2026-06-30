CLANDRO_PKG_HOMEPAGE=https://sourceforge.net/projects/mtpaint/
CLANDRO_PKG_DESCRIPTION="Simple paint program for creating icons and pixel based artwork"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
_COMMIT=7cae5d663ed835a365d89a535536c39e18862a83
CLANDRO_PKG_VERSION="1:3.50.12"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/wjaguar/mtPaint/archive/${_COMMIT}.zip
CLANDRO_PKG_SHA256=12d861af3e6db4167390bbcf1fd1b79960753acd6ec049bc6cd0d9898c137e89
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_DEPENDS="atk, freetype, gdk-pixbuf, glib, gtk3, harfbuzz, libandroid-glob, libcairo, libiconv, libjpeg-turbo, libpng, libtiff, libwebp, libx11, littlecms, openjpeg, pango, zlib"
CLANDRO_PKG_RECOMMENDS="gifsicle"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--prefix=$CLANDRO_PREFIX
cflags
gtk3
jpeg
lcms2
man
tiff
"

clandro_step_post_get_source() {
	local v=$(sed -En 's/^MT_V="([^"]+)".*/\1/p' configure)
	if [ "${v}" != "${CLANDRO_PKG_VERSION#*:}" ]; then
		clandro_error_exit "Version string '$CLANDRO_PKG_VERSION' does not seem to be correct."
	fi
}

clandro_step_pre_configure() {
	LDFLAGS+=" -landroid-glob"
}

clandro_step_configure() {
	sh $CLANDRO_PKG_SRCDIR/configure ${CLANDRO_PKG_EXTRA_CONFIGURE_ARGS}
}
