CLANDRO_PKG_HOMEPAGE="https://invent.kde.org/libraries/kunifiedpush"
CLANDRO_PKG_DESCRIPTION="UnifiedPush client components"
CLANDRO_PKG_LICENSE="LGPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="26.04.1"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/release-service/${CLANDRO_PKG_VERSION}/src/kunifiedpush-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=4be7f9343bc2336484847ff46f2cdd26ec869a851fd0072a4d0b933d888708cf
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="kf6-kcmutils, kf6-kcoreaddons, kf6-ki18n, kf6-kservice, kf6-solid, libc++, openssl, qt6-qtbase, qt6-qtdeclarative, qt6-qtwebsockets"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules"
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
