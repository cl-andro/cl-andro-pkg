CLANDRO_PKG_HOMEPAGE=https://gnunn1.github.io/tilix-web
CLANDRO_PKG_DESCRIPTION="A tiling terminal emulator for Linux using GTK+ 3"
CLANDRO_PKG_LICENSE="MPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_VERSION=1.9.6
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/gnunn1/tilix/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=be389d199a6796bd871fc662f8a37606a1f84e5429f24e912d116f16c5f0a183
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="dconf, gdk-pixbuf, glib, gsettings-desktop-schemas, gtk3, libcairo, libsecret, libvte, libx11, pango"
CLANDRO_PKG_BUILD_DEPENDS="ldc, binutils-cross"

clandro_step_configure() {
	clandro_setup_ldc
}

clandro_step_make_install() {
	bash install.sh $CLANDRO_PREFIX
}
