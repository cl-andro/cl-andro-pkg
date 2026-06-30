CLANDRO_PKG_HOMEPAGE="https://apps.kde.org/konqueror/"
CLANDRO_PKG_DESCRIPTION="KDE File Manager & Web Browser"
CLANDRO_PKG_LICENSE="LGPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="26.04.1"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/release-service/${CLANDRO_PKG_VERSION}/src/konqueror-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=0049726058e323d46fd1eb6271b30cae6289d828baa4508db60ab0b2f477a4f9
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_DEPENDS="kf6-karchive, kf6-kbookmarks, kf6-kcmutils, kf6-kcodecs, kf6-kcolorscheme, kf6-kcompletion, kf6-kconfig, kf6-kconfigwidgets, kf6-kcoreaddons, kf6-kcrash, kf6-kdbusaddons, kf6-kguiaddons, kf6-ki18n, kf6-kiconthemes, kf6-kio, kf6-kitemviews, kf6-kjobwidgets, kf6-kparts, kf6-kservice, kf6-ktextwidgets, kf6-kwallet, kf6-kwidgetsaddons, kf6-kwindowsystem, kf6-kxmlgui, kf6-solid, kf6-sonnet, libc++, plasma-activities, qt6-qtbase, qt6-qtwebengine, zlib"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules, kf6-kdoctools"
CLANDRO_PKG_EXCLUDED_ARCHES="i686"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"

clandro_step_host_build() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		clandro_download_ubuntu_packages hunspell hunspell-en-us libhunspell-1.7-0
	fi
}

clandro_step_pre_configure() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		export LD_LIBRARY_PATH="$CLANDRO_PKG_HOSTBUILD_DIR/ubuntu_packages/usr/lib/x86_64-linux-gnu"

		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" \
			-DHunspell_EXECUTABLE=$CLANDRO_PKG_HOSTBUILD_DIR/ubuntu_packages/usr/bin/hunspell \
			-DKF6_HOST_TOOLING=$CLANDRO_PREFIX/opt/kf6/cross/lib/cmake/"
	fi
}
