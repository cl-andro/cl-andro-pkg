CLANDRO_PKG_HOMEPAGE=https://github.com/frankosterfeld/qtkeychain
CLANDRO_PKG_DESCRIPTION="Platform-independent Qt API for storing passwords securely."
CLANDRO_PKG_LICENSE="BSD 2-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.16.0"
CLANDRO_PKG_SRCURL="https://github.com/frankosterfeld/qtkeychain/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=3be26ec4ae30eecf0c2ff7572ba83799791b157c76e15a05ef35f23dc25e4054
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="dbus, glib, libc++, libsecret, qt6-qtbase"
CLANDRO_PKG_BUILD_DEPENDS="qt6-qtbase-cross-tools, qt6-qttools, qt6-qttools-cross-tools"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="-DBUILD_WITH_QT6=ON"
