CLANDRO_PKG_HOMEPAGE="https://apps.kde.org/okular"
CLANDRO_PKG_DESCRIPTION="Multi-platform document viewer for PDF, comics, EPub, and images"
CLANDRO_PKG_LICENSE="GPL-2.0-or-later, LGPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="26.04.1"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/release-service/${CLANDRO_PKG_VERSION}/src/okular-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=3d87a0d9e9fe62435a913190a0a7edd75bec6a02ce2eda4089046adcffc6bba6
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="discount, djvulibre, freetype, kf6-karchive, kf6-kbookmarks, kf6-kcolorscheme, kf6-kcompletion, kf6-kconfig, kf6-kconfigwidgets, kf6-kcoreaddons, kf6-kcrash, kf6-ki18n, kf6-kiconthemes, kf6-kio, kf6-kparts, kf6-ktextwidgets, kf6-kwallet, kf6-kwidgetsaddons, kf6-kwindowsystem, kf6-kxmlgui, kf6-purpose, kf6-threadweaver, libc++, libkexiv2, libspectre, libtiff, phonon-qt6, poppler-qt, qt6-qtbase, qt6-qtdeclarative, qt6-qtspeech, qt6-qtsvg, unrar, zlib"
CLANDRO_PKG_BUILD_DEPENDS="ebook-tools, extra-cmake-modules, kdegraphics-mobipocket"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
-DFORCE_NOT_REQUIRED_DEPENDENCIES=KF6DocTools
"

clandro_step_pre_configure() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DKF6_HOST_TOOLING=$CLANDRO_PREFIX/opt/kf6/cross/lib/cmake/"
	fi
}
