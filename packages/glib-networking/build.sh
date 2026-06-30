CLANDRO_PKG_HOMEPAGE=https://gitlab.gnome.org/GNOME/glib-networking
CLANDRO_PKG_DESCRIPTION="Network-related giomodules for glib"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.80.1"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://ftp.gnome.org/pub/gnome/sources/glib-networking/${CLANDRO_PKG_VERSION%.*}/glib-networking-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=b80e2874157cd55071f1b6710fa0b911d5ac5de106a9ee2a4c9c7bee61782f8e
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="glib, openssl"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Denvironment_proxy=enabled
-Dgnome_proxy=disabled
-Dgnutls=disabled
-Dlibproxy=disabled
-Dopenssl=enabled
"
