CLANDRO_PKG_HOMEPAGE="https://invent.kde.org/plasma/breeze"
CLANDRO_PKG_DESCRIPTION="Artwork, styles and assets for the Breeze visual style for the Plasma Desktop"
CLANDRO_PKG_LICENSE="LGPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.6.4"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/plasma/${CLANDRO_PKG_VERSION}/breeze-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=15ec98c5bdae5cb762c162a2aae87605531e20cf80a7ebeaa36e8d694018ffda
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="kf6-breeze-icons, kf6-frameworkintegration, kf6-kcmutils, kf6-kcolorscheme, kf6-kconfig, kf6-kcoreaddons, kdecoration, kf6-ki18n, kf6-kiconthemes, kf6-kwidgetsaddons, kf6-kpackage, libc++, qt6-qtbase, qt6-qtdeclarative, qt6-qtsvg"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules, kf6-kirigami"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
-DBUILD_QT6=ON
-DBUILD_QT5=OFF
"
clandro_step_pre_configure() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DKF6_HOST_TOOLING=$CLANDRO_PREFIX/opt/kf6/cross/lib/cmake/"
	fi
}
