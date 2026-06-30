CLANDRO_PKG_HOMEPAGE="https://www.qt.io/"
CLANDRO_PKG_DESCRIPTION="Virtual keyboard framework"
CLANDRO_PKG_LICENSE="GPL-3.0-only, LGPL-3.0-only"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.11.0"
CLANDRO_PKG_SRCURL="https://download.qt.io/official_releases/qt/${CLANDRO_PKG_VERSION%.*}/${CLANDRO_PKG_VERSION}/submodules/qtvirtualkeyboard-everywhere-src-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=d88a4b1713a313e3ac06c32837b5d00724d1dcf7b44c2594f1029f7c74a8e686
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++, hunspell, qt6-qtbase, qt6-qtdeclarative, qt6-qtpositioning, qt6-qtmultimedia, qt6-qtsvg"
CLANDRO_PKG_BUILD_DEPENDS="cmake, git, ninja"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
"
