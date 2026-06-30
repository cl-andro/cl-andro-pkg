CLANDRO_PKG_HOMEPAGE=https://mate-desktop.org/
CLANDRO_PKG_DESCRIPTION="Set of extensions for Caja, the MATE file manager"
CLANDRO_PKG_LICENSE="GPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.28.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://github.com/mate-desktop/caja-extensions/releases/download/v$CLANDRO_PKG_VERSION/caja-extensions-$CLANDRO_PKG_VERSION.tar.xz"
CLANDRO_PKG_SHA256=d2986c5e0740835fe271cfbd5823eeeaf03291af1763203f4700abb8109e3175
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="caja, dbus-glib, gettext, gst-plugins-base, imagemagick, samba"
CLANDRO_PKG_BUILD_DEPENDS="autoconf-archive, glib, mate-common, python, gst-plugins-base"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-upnp
--disable-gksu
"
