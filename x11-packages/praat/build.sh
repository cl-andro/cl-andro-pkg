CLANDRO_PKG_HOMEPAGE=https://www.praat.org
CLANDRO_PKG_DESCRIPTION="Doing phonetics by computer"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.4.65"
CLANDRO_PKG_SRCURL=https://github.com/praat/praat/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=bb3f9c520f93f4786903d59d7f64acdc4704d40ed88b4bbfd52ec75f07be6182
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="atk, gdk-pixbuf, glib, gtk3, harfbuzz, libc++, libcairo, pango, pulseaudio, zlib"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_post_get_source() {
	rm -f meson.build
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin praat
}
