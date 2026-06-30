CLANDRO_PKG_HOMEPAGE=https://launchpad.net/libdbusmenu
CLANDRO_PKG_DESCRIPTION="A small library designed to make sharing and displaying of menu structures over DBus"
CLANDRO_PKG_LICENSE="LGPL-2.1, LGPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
_MAJOR_VERSION=16.04
CLANDRO_PKG_VERSION=${_MAJOR_VERSION}.0
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://launchpad.net/libdbusmenu/${_MAJOR_VERSION}/${CLANDRO_PKG_VERSION}/+download/libdbusmenu-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=b9cc4a2acd74509435892823607d966d424bd9ad5d0b00938f27240a1bfa878a
CLANDRO_PKG_DEPENDS="glib, json-glib"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, valac"
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-dumper
--enable-introspection=yes
--enable-vala=yes
"

clandro_step_pre_configure() {
	clandro_setup_gir
}
