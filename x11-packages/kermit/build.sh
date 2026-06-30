CLANDRO_PKG_HOMEPAGE=https://github.com/orhun/kermit
CLANDRO_PKG_DESCRIPTION="A VTE-based simple and froggy terminal emulator"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/orhun/kermit/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=5ee5d7ed395b89a35678096ea7d3a7901714b9575f64813045fb3f6e7fc8c8a7
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="glib, gtk3, libvte, pango"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin ./kermit
}
