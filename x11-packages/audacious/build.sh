CLANDRO_PKG_HOMEPAGE=https://audacious-media-player.org
CLANDRO_PKG_DESCRIPTION="An advanced audio player"
CLANDRO_PKG_LICENSE="BSD 2-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.5.1"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_SRCURL=https://distfiles.audacious-media-player.org/audacious-${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=7194743a0a41b1d8f582c071488b77f7b917be47ca5e142dd76af5d81d36f9cd
CLANDRO_PKG_DEPENDS="libarchive, libc++, qt6-qtbase, qt6-qtsvg, dbus-glib"
CLANDRO_PKG_BUILD_DEPENDS="qt6-qtbase-cross-tools"
CLANDRO_PKG_RECOMMENDS="audacious-plugins"
# Audacious out-of-source build doesn't seem to work
CLANDRO_PKG_BUILD_IN_SRC=true
# Audacious has switched to Qt toolkit and it's the default GUI option now
# Disable GTK to reduce the size and dependencies
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--enable-libarchive
--disable-gtk
QTBINPATH=${CLANDRO_PREFIX}/opt/qt6/cross/lib/qt6
"
