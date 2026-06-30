CLANDRO_PKG_HOMEPAGE=https://ardour.org/
CLANDRO_PKG_DESCRIPTION="A professional digital workstation for working with audio and MIDI"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="8.12"
CLANDRO_PKG_REVISION=7
CLANDRO_PKG_SRCURL=git+https://github.com/Ardour/ardour
CLANDRO_PKG_GIT_BRANCH="$CLANDRO_PKG_VERSION"
CLANDRO_PKG_DEPENDS="aubio, fftw, fontconfig, gdk-pixbuf, glib, gtk2, gtkmm2, libandroid-execinfo, libarchive, libatkmm-1.6, libc++, libcairo, libcairomm-1.0, libcurl, libglibmm-2.4, liblo, liblrdf, libpangomm-1.4, libsamplerate, libsigc++-2.0, libsndfile, libusb, libwebsockets, libx11, libxml2, lilv, pango, pulseaudio, rubberband, suil, taglib, vamp-plugin-sdk"
CLANDRO_PKG_BUILD_DEPENDS="boost, boost-headers"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--with-backends=dummy,pulseaudio
--no-fpu-optimization
--freedesktop
--no-nls
--no-phone-home
--no-ytk
--noconfirm
--optimize
"

clandro_step_pre_configure() {
	# this is a workaround for build-all.sh issue
	CLANDRO_PKG_DEPENDS+=", ardour-data"

	LDFLAGS+=" -landroid-execinfo"
}

clandro_step_configure() {
	./waf configure \
		--prefix=$CLANDRO_PREFIX \
		LINKFLAGS="$LDFLAGS" \
		$CLANDRO_PKG_EXTRA_CONFIGURE_ARGS
}

clandro_step_make() {
	./waf
}

clandro_step_make_install() {
	./waf install
}
