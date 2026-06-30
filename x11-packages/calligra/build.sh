CLANDRO_PKG_HOMEPAGE=https://calligra.org/
CLANDRO_PKG_DESCRIPTION="Office and graphic art suite by KDE"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="26.04.1"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/release-service/${CLANDRO_PKG_VERSION}/src/calligra-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=193ce06bf7dc3225a8961123aa131c245d49519154bf095804dacaee06197685
# it could use qt6-qtwebengine, but that dependency is not available for 32-bit x86 architecture.
CLANDRO_PKG_DEPENDS="fontconfig, freetype, gsl, imath, kf6-karchive, kf6-kcmutils, kf6-kcolorscheme, kf6-kcompletion, kf6-kconfig, kf6-kconfigwidgets, kf6-kcoreaddons, kf6-kcrash, kf6-kdbusaddons, kf6-kguiaddons, kf6-ki18n, kf6-kiconthemes, kf6-kio, kf6-kitemviews, kf6-kjobwidgets, kf6-knotifications, kf6-knotifyconfig, kf6-ktextwidgets, kf6-kwidgetsaddons, kf6-kwindowsystem, kf6-kxmlgui, kf6-purpose, kf6-solid, kf6-sonnet, kf6-qqc2-desktop-style, kirigami-addons, libc++, libetonyek, libgit2, libodfgen, librevenge, libvisio, libwpd, libwpg, libwps, littlecms, mediainfo, mlt, okular, opengl, openssl, opentimelineio, perl, phonon-qt6, poppler, poppler-qt, qca, qt6-qtbase, qt6-qtdeclarative, qt6-qtmultimedia, qt6-qtnetworkauth, qt6-qtsvg, qtkeychain, shared-mime-info, zlib"
CLANDRO_PKG_BUILD_DEPENDS="boost, eigen, extra-cmake-modules, kf6-kconfig-cross-tools, kf6-kdoctools, kf6-kdoctools-cross-tools, qt6-qttools"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
-DUSE_DBUS=OFF
"

clandro_step_host_build() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "true" ]]; then
		return
	fi

	local QT6_HOSTBUILD_COMPILER_ARGS="
	-L$CLANDRO_PREFIX/opt/qt6/cross/lib
	-Wl,-rpath=$CLANDRO_PREFIX/opt/qt6/cross/lib
	-lQt6Core
	-lQt6Xml
	-I$CLANDRO_PREFIX/opt/qt6/cross/include/qt6/QtCore
	-I$CLANDRO_PREFIX/opt/qt6/cross/include/qt6/QtXml
	-I$CLANDRO_PREFIX/opt/qt6/cross/include/qt6
	"
	g++ "$CLANDRO_PKG_SRCDIR/devtools/rng2cpp/rng2cpp.cpp" \
		$QT6_HOSTBUILD_COMPILER_ARGS \
		-o rng2cpp

	g++ "$CLANDRO_PKG_SRCDIR/filters/sheets/excel/sidewinder/recordsxml2cpp.cpp" \
		$QT6_HOSTBUILD_COMPILER_ARGS \
		-o recordsxml2cpp
}

clandro_step_pre_configure() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DKF6_HOST_TOOLING=$CLANDRO_PREFIX/opt/kf6/cross/lib/cmake"
		export PATH="$CLANDRO_PKG_HOSTBUILD_DIR:$PATH"
	fi
}
