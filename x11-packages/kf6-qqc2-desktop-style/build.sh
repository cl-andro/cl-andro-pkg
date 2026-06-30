CLANDRO_PKG_HOMEPAGE='https://invent.kde.org/frameworks/qqc2-desktop-style'
CLANDRO_PKG_DESCRIPTION='A style for Qt Quick Controls 2 to make it follow your desktop theme'
CLANDRO_PKG_LICENSE="LGPL-2.0, LGPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.26.0"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/frameworks/${CLANDRO_PKG_VERSION%.*}/qqc2-desktop-style-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=1805fa31355ff86c02158fd2b8d396fd88835d01db97d8700314c48ee3360986
CLANDRO_PKG_DEPENDS="kf6-kcolorscheme (>= ${CLANDRO_PKG_VERSION%.*}), kf6-kconfig (>= ${CLANDRO_PKG_VERSION%.*}), kf6-kiconthemes (>= ${CLANDRO_PKG_VERSION%.*}), kf6-kirigami (>= ${CLANDRO_PKG_VERSION%.*}), kf6-sonnet (>= ${CLANDRO_PKG_VERSION%.*}), libc++, qt6-qtbase, qt6-qtdeclarative"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules (>= ${CLANDRO_PKG_VERSION%.*}), qt6-qttools"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"

clandro_step_post_massage() {
	local file="lib/qt6/plugins/kf6/kirigami/platform/org.kde.desktop.so"
	if [[ ! -f "${CLANDRO_PKG_MASSAGEDIR}${CLANDRO_PREFIX}/${file}" ]]; then
		clandro_error_exit "'$CLANDRO_PKG_NAME' is malformed, '$file' must exist!"
	fi
}
