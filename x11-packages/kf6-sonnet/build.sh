CLANDRO_PKG_HOMEPAGE='https://invent.kde.org/frameworks/sonnet'
CLANDRO_PKG_DESCRIPTION='Spelling framework for Qt'
CLANDRO_PKG_LICENSE="LGPL-2.0, LGPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.26.0"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/frameworks/${CLANDRO_PKG_VERSION%.*}/sonnet-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=3ac4e165c0b3c79eda416b754bb837292f354188a1220f2065f57f686489af25
CLANDRO_PKG_DEPENDS="aspell, hunspell, libc++, libvoikko, qt6-qtbase, qt6-qtdeclarative"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules (>= ${CLANDRO_PKG_VERSION%.*}), qt6-qttools, qt6-qtbase-cross-tools"
# hspell can be added to CLANDRO_PKG_BUILD_DEPENDS and CLANDRO_PKG_RECOMMENDS when available
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"
