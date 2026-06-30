CLANDRO_PKG_HOMEPAGE='https://invent.kde.org/frameworks/kio'
CLANDRO_PKG_DESCRIPTION='Resource and network access abstraction'
CLANDRO_PKG_LICENSE="LGPL-2.0, LGPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.26.0"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/frameworks/${CLANDRO_PKG_VERSION%.*}/kio-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=567f64db9766986b5535d884a5db30203685c33e67f56892bceff30e1bd5cc8a
CLANDRO_PKG_DEPENDS="kf6-karchive (>= ${CLANDRO_PKG_VERSION%.*}), kf6-kauth (>= ${CLANDRO_PKG_VERSION%.*}), kf6-kbookmarks (>= ${CLANDRO_PKG_VERSION%.*}), kf6-kcolorscheme (>= ${CLANDRO_PKG_VERSION%.*}), kf6-kcompletion (>= ${CLANDRO_PKG_VERSION%.*}), kf6-kconfig (>= ${CLANDRO_PKG_VERSION%.*}), kf6-kcoreaddons (>= ${CLANDRO_PKG_VERSION%.*}), kf6-kdbusaddons (>= ${CLANDRO_PKG_VERSION%.*}), kf6-kguiaddons (>= ${CLANDRO_PKG_VERSION%.*}), kf6-ki18n (>= ${CLANDRO_PKG_VERSION%.*}), kf6-kiconthemes (>= ${CLANDRO_PKG_VERSION%.*}), kf6-kitemviews (>= ${CLANDRO_PKG_VERSION%.*}), kf6-kjobwidgets (>= ${CLANDRO_PKG_VERSION%.*}), kf6-kservice (>= ${CLANDRO_PKG_VERSION%.*}), kf6-kwallet (>= ${CLANDRO_PKG_VERSION%.*}), kf6-kwidgetsaddons (>= ${CLANDRO_PKG_VERSION%.*}), kf6-kwindowsystem (>= ${CLANDRO_PKG_VERSION%.*}), kf6-solid (>= ${CLANDRO_PKG_VERSION%.*}), libacl, libandroid-shmem, libc++, libmount, libxml2, libxslt, qt6-qtbase, util-linux"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules (>= ${CLANDRO_PKG_VERSION%.*}), kf6-kdoctools (>= ${CLANDRO_PKG_VERSION%.*}), kf6-kdoctools-cross-tools (>= ${CLANDRO_PKG_VERSION%.*}), qt6-qttools"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"

clandro_step_pre_configure() {
	LDFLAGS+=" -landroid-shmem"
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DKF6_HOST_TOOLING=$CLANDRO_PREFIX/opt/kf6/cross/lib/cmake"
	fi
}
