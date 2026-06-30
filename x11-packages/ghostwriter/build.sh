CLANDRO_PKG_HOMEPAGE=https://ghostwriter.kde.org/
CLANDRO_PKG_DESCRIPTION="Text editor for Markdown"
CLANDRO_PKG_LICENSE="Apache-2.0, BSD 2-Clause, BSD 3-Clause, CC0-1.0, GPL-3.0-or-later, LGPL-2.1-or-later, MIT, OFL-1.1, custom"
CLANDRO_PKG_LICENSE_FILE="
LICENSES/Apache-2.0.txt
LICENSES/BSD-2-Clause.txt
LICENSES/BSD-3-Clause.txt
LICENSES/CC0-1.0.txt
LICENSES/GPL-3.0-or-later.txt
LICENSES/LGPL-2.1-or-later.txt
LICENSES/MIT.txt
LICENSES/OFL-1.1.txt
LICENSES/CC-BY-SA-4.0.txt
"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="26.04.1"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/release-service/${CLANDRO_PKG_VERSION}/src/ghostwriter-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=fbe2ba851cd71ed64bd2f86fc544c02bc06547ddc4c9cec9a1d658c5de15e1a3
CLANDRO_PKG_DEPENDS="libc++, kf6-kconfigwidgets, kf6-kcoreaddons, kf6-kwidgetsaddons, kf6-kxmlgui, kf6-sonnet, qt6-qtwebchannel, qt6-qtwebengine, qt6-qtbase, qt6-qtpositioning"
CLANDRO_PKG_SUGGESTS="cmake, pandoc"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules, kf6-kdoctools, kf6-kdoctools-cross-tools, qt6-qttools, qt6-qttools-cross-tools"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXCLUDED_ARCHES="i686"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"

clandro_step_pre_configure() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DKF6_HOST_TOOLING=$CLANDRO_PREFIX/opt/kf6/cross/lib/cmake"
	fi
}
