CLANDRO_PKG_HOMEPAGE=https://fcitx-im.org/
CLANDRO_PKG_DESCRIPTION="A generic input method framework"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="5.1.19"
CLANDRO_PKG_SRCURL=https://github.com/fcitx/fcitx5/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=a6e4d99a82298845df9f8dc5036c1aaed258c2d3f5bd215b8f91c75410167ff0
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_DEPENDS="dbus, enchant, fcitx5-data, fmt, gdk-pixbuf, glib, iso-codes, libandroid-execinfo, libc++, libcairo, libevent, libexpat, libuuid, libuv, libxcb, libxkbcommon, libxkbfile, pango, xcb-imdkit, xcb-util, xcb-util-keysyms, xcb-util-wm, yoga, zlib"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules, nlohmann-json"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DDL_INCLUDE_DIR=$CLANDRO_PREFIX/include
-DDL_LIBRARY=0
-DPTHREAD_INCLUDE_DIR=$CLANDRO_PREFIX/include
-DENABLE_TEST=OFF
-DENABLE_WAYLAND=OFF
-DUSE_SYSTEM_YOGA=ON
"

clandro_step_pre_configure() {
	LDFLAGS+=" -ldl"
	CXXFLAGS+=" -fexperimental-library"
}
