CLANDRO_PKG_HOMEPAGE="https://apps.kde.org/alligator/"
CLANDRO_PKG_DESCRIPTION="Alligator is a convergent, cross-platform feed reader, supporting standard RSS/Atom feeds"
CLANDRO_PKG_LICENSE="GPL-2.0-or-later, LGPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="26.04.1"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/release-service/${CLANDRO_PKG_VERSION}/src/alligator-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=75fd1bea0a1b8a905614db3d7f17c072c0246249f5158ddc85b7c74b54c2b559
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="kf6-kcolorscheme, kf6-kconfig, kf6-kcoreaddons, kf6-ki18n, kf6-kirigami, kf6-syndication, kirigami-addons, libc++, kf6-qqc2-desktop-style, qt6-qtbase, qt6-qtdeclarative"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules, python"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
"

clandro_step_pre_configure() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DKF6_HOST_TOOLING=$CLANDRO_PREFIX/opt/kf6/cross/lib/cmake/"
	fi
}
