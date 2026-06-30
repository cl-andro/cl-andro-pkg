CLANDRO_PKG_HOMEPAGE=https://tuxpaint.org/
CLANDRO_PKG_DESCRIPTION="A free, award-winning drawing program for children ages 3 to 12"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.9.35"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://downloads.sourceforge.net/tuxpaint/tuxpaint-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=c1c18af91be77e94fdaab2c928204c4c39ba39ac5da2f441aaf2ecab6d8bd0ad
CLANDRO_PKG_DEPENDS="fontconfig, fribidi, glib, libandroid-wordexp, libcairo, libimagequant, libpaper, libpng, librsvg, pango, sdl2 | sdl2-compat, sdl2-gfx, sdl2-image, sdl2-mixer, sdl2-pango, sdl2-ttf, zlib"
CLANDRO_PKG_ANTI_BUILD_DEPENDS="sdl2-compat"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_MAKE_INSTALL_TARGET="install install-xdg"

clandro_step_host_build() {
	local _PREFIX_FOR_BUILD=$CLANDRO_PKG_HOSTBUILD_DIR/prefix

	# Need imagemagick that can handle SVG format.
	local IMAGEMAGICK_BUILD_SH=$CLANDRO_SCRIPTDIR/packages/imagemagick/build.sh
	local IMAGEMAGICK_SRCURL=$(. $IMAGEMAGICK_BUILD_SH; echo $CLANDRO_PKG_SRCURL)
	local IMAGEMAGICK_SHA256=$(. $IMAGEMAGICK_BUILD_SH; echo $CLANDRO_PKG_SHA256)
	local IMAGEMAGICK_TARFILE=$CLANDRO_PKG_CACHEDIR/$(basename $IMAGEMAGICK_SRCURL)
	clandro_download $IMAGEMAGICK_SRCURL $IMAGEMAGICK_TARFILE $IMAGEMAGICK_SHA256
	mkdir -p imagemagick
	cd imagemagick
	tar xf $IMAGEMAGICK_TARFILE --strip-components=1
	./configure --prefix=$_PREFIX_FOR_BUILD \
		--with-jpeg \
		--with-png \
		--with-rsvg
	make -j ${CLANDRO_PKG_MAKE_PROCESSES} install
}

clandro_step_pre_configure() {
	# this is a workaround for build-all.sh issue
	CLANDRO_PKG_DEPENDS+=", tuxpaint-data"

	local _PREFIX_FOR_BUILD="$CLANDRO_PKG_HOSTBUILD_DIR/prefix"
	export PATH="$_PREFIX_FOR_BUILD/bin:$PATH"
	export XDG_DATA_HOME="$CLANDRO_PREFIX/share" XDG_DATA_DIRS="$CLANDRO_PREFIX" XDG_CURRENT_DESKTOP="X-Generic"

	# Disabling gtk-update-icon-cache
	ln -s /usr/bin/true "$_PREFIX_FOR_BUILD/bin/update-desktop-database" ||:
	ln -s /usr/bin/true "$_PREFIX_FOR_BUILD/bin/gtk-update-icon-cache" ||:

	CPPFLAGS+=" -U__ANDROID__"
	LDFLAGS+=" -landroid-wordexp"
}

clandro_step_post_configure() {
	# https://github.com/termux/termux-packages/issues/12458
	mkdir -p trans
}

clandro_step_post_make_install() {
	rm -rf $CLANDRO_PREFIX/applications/mimeinfo.cache
}
