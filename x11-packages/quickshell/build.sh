CLANDRO_PKG_HOMEPAGE="https://git.outfoxxed.me/quickshell/quickshell"
CLANDRO_PKG_DESCRIPTION="Flexible toolkit for making desktop shells with QtQuick"
CLANDRO_PKG_LICENSE="LGPL-3.0-only"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.3.0"
CLANDRO_PKG_SRCURL="https://github.com/quickshell-mirror/quickshell/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256="5229069b0f1d375f34b0a04a4e6a69156e2f010995d9ec5a943793424e589b5d"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="hicolor-icon-theme, libc++, libdrm, libglvnd, libwayland, libxcb, mesa, pipewire, qt6-qtbase, qt6-qtdeclarative, qt6-qtsvg, qt6-qtwayland"
CLANDRO_PKG_BUILD_DEPENDS="cli11, libwayland-protocols, qt6-shadertools, spirv-tools"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DCRASH_HANDLER=OFF
-DUSE_JEMALLOC=OFF
-DSERVICE_PAM=OFF
-DSERVICE_POLKIT=OFF
-DINSTALL_QML_PREFIX=lib/qt6/qml
"

clandro_step_pre_configure() {
	CXXFLAGS+=" -Wno-c++11-narrowing"
}
