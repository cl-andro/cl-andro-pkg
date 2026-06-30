CLANDRO_PKG_HOMEPAGE=https://gitlab.freedesktop.org/libdecor/libdecor
CLANDRO_PKG_DESCRIPTION="Client-side decorations library for Wayland clients"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.2.5"
CLANDRO_PKG_SRCURL=https://gitlab.freedesktop.org/libdecor/libdecor/-/archive/${CLANDRO_PKG_VERSION}/libdecor-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=39c109a9a7eae943ba34d18a282c447d5729f9c486c8bc05ea305e4acd341522
# gtk3 dependency makes libdecor a "x11" package
CLANDRO_PKG_DEPENDS="dbus, glib, gtk3, libcairo, libwayland, libxkbcommon, pango"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Ddemo=false
-Ddbus=enabled
-Dinstall_demo=false
-Dgtk=enabled
"
