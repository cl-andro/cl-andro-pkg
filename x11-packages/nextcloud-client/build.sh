CLANDRO_PKG_HOMEPAGE=https://nextcloud.com/
CLANDRO_PKG_DESCRIPTION="Command-line client tool for Nextcloud."
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="33.0.4"
CLANDRO_PKG_SRCURL="https://github.com/nextcloud/desktop/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=d450ed9d334dfcef21dedc11678562d0abb0fa808ac65c550a755bd6f3a5ce9f
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="dbus, dbus-glib, libc++, libp11, openssl, qtkeychain, qt6-qtbase, inotify-tools, libsqlite, kdsingleapplication, kf6-karchive, qt6-qtwebsockets, qt6-qtsvg, qt6-qt5compat"
CLANDRO_PKG_BUILD_DEPENDS="qt6-qtbase-cross-tools, qt6-qttools-cross-tools, pkg-config, qt6-qttools"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_GUI=OFF
-DBUILD_SHELL_INTEGRATION=OFF
-DBUILD_WITH_WEBENGINE=OFF
-DBUILD_UPDATER=OFF
-DTOKEN_AUTH_ONLY=OFF
-DBUILD_TESTING=OFF
"
