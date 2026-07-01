CLANDRO_PKG_HOMEPAGE=https://upower.freedesktop.org/
CLANDRO_PKG_DESCRIPTION="Power management support for DeviceKit"
CLANDRO_PKG_LICENSE="GPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.91.2"
CLANDRO_PKG_SRCURL="https://gitlab.freedesktop.org/upower/upower/-/archive/v$CLANDRO_PKG_VERSION/upower-v$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=cd9a3a3f5e0aa21eac131253228757bbdc90ecd39768f46c325754e32daa3083
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="glib, gobject-introspection, clandro-api"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, glib-cross"
CLANDRO_PKG_VERSIONED_GIR=false

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dintrospection=enabled
-Dos_backend=dummy
-Dpolkit=disabled
-Dsystemdsystemunitdir=no
-Dgtk-doc=false
-Dman=false
"

clandro_step_pre_configure() {
	clandro_setup_gir
	clandro_setup_glib_cross_pkg_config_wrapper

	export CLANDRO_MESON_ENABLE_SOVERSION=1
}
