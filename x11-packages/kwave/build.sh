CLANDRO_PKG_HOMEPAGE="https://apps.kde.org/kwave/"
CLANDRO_PKG_DESCRIPTION="A sound editor by KDE"
CLANDRO_PKG_LICENSE="GPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="26.04.1"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/release-service/${CLANDRO_PKG_VERSION}/src/kwave-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=ea9307b8fd470b113b5c4000bb77a7fd4d198fd71abf515a40a71543b28e666c
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="alsa-lib, audiofile, fftw, flac, id3lib, kf6-karchive, kf6-kcompletion, kf6-kconfig, kf6-kconfigwidgets, kf6-kcoreaddons, kf6-kcrash, kf6-kdbusaddons, kf6-ki18n, kf6-kiconthemes, kf6-kio, kf6-ktextwidgets, kf6-kwidgetsaddons, kf6-kxmlgui, libc++, libmad, libogg, libsamplerate, libvorbis, pulseaudio, qt6-qtbase, qt6-qtmultimedia"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules, kf6-kdoctools, libopus, librsvg"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DWITH_OSS=OFF
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"

clandro_step_pre_configure() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DKF6_HOST_TOOLING=$CLANDRO_PREFIX/opt/kf6/cross/lib/cmake/"
	fi
}
