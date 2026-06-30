CLANDRO_PKG_HOMEPAGE="https://apps.kde.org/neochat/"
CLANDRO_PKG_DESCRIPTION="A client for matrix, the decentralized communication protocol"
CLANDRO_PKG_LICENSE="GPL-2.0-or-later, LGPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="26.04.1"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/release-service/${CLANDRO_PKG_VERSION}/src/neochat-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=8adefd9e096cdd40b9ce460afa1fe92a616e1bbd34d8ffea9e02db3aabff0878
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="cmark, kf6-kcolorscheme, kf6-kconfig, kf6-kcoreaddons, kf6-kdbusaddons, kf6-ki18n, kf6-kio, kf6-kirigami, kf6-kitemmodels, kf6-knotifications, kf6-kquickcharts, kf6-kservice, kf6-kstatusnotifieritem, kf6-kwindowsystem, kf6-prison, kf6-purpose, kf6-qqc2-desktop-style, kf6-sonnet, kf6-syntax-highlighting, kirigami-addons, kquickimageeditor, kunifiedpush, libc++, libicu, libquotient, qcoro, qt6-qtbase, qt6-qtdeclarative, qt6-qtlocation, qt6-qtmultimedia, qt6-qtpositioning, qt6-qtspeech, qt6-qtwebview, qtkeychain"
CLANDRO_PKG_BUILD_DEPENDS="cmark-static, extra-cmake-modules, kf6-kdoctools, libquotient-static, qcoro-static"
CLANDRO_PKG_EXCLUDED_ARCHES="i686"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"

clandro_step_pre_configure() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DKF6_HOST_TOOLING=$CLANDRO_PREFIX/opt/kf6/cross/lib/cmake/"
	fi
}
