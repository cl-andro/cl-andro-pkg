CLANDRO_PKG_HOMEPAGE=https://www.gnome.org/
CLANDRO_PKG_DESCRIPTION="GNOME desktop schemas contains a collection of GSettings schemas for settings shared by various components of a desktop."
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@Yisus7u7"
CLANDRO_PKG_VERSION="50.1"
CLANDRO_PKG_SRCURL=https://download.gnome.org/sources/gsettings-desktop-schemas/${CLANDRO_PKG_VERSION%.*}/gsettings-desktop-schemas-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=0a2aa25082672585d16fcdab61c7b0e33f035fb87476505c794f29565afa485b
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_RECOMMENDS="dconf"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner"
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dintrospection=true
"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true

clandro_step_pre_configure() {
	clandro_setup_gir
}
