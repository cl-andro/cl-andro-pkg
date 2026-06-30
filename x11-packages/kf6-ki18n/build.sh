CLANDRO_PKG_HOMEPAGE="https://invent.kde.org/frameworks/ki18n"
CLANDRO_PKG_DESCRIPTION="KDE Gettext-based UI text internationalization"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.26.0"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/frameworks/${CLANDRO_PKG_VERSION%.*}/ki18n-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=484aad486bfafef6c86d8d5b26529258e67c74c96250c1ac212ddf568448c7c0
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_DEPENDS="gettext, iso-codes, libc++, qt6-qtbase, qt6-qtdeclarative"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules (>= ${CLANDRO_PKG_VERSION%.*}), python, qt6-qttools"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"

clandro_step_host_build() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "true" ]]; then
		return
	fi

	clandro_setup_cmake
	clandro_setup_ninja

	cmake -G Ninja \
		-S "${CLANDRO_PKG_SRCDIR}" \
		-B "${CLANDRO_PKG_HOSTBUILD_DIR}" \
		-DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_INSTALL_PREFIX=$CLANDRO_PREFIX/opt/kf6/cross \
		-DCMAKE_PREFIX_PATH="$CLANDRO_PREFIX/opt/qt6/cross/lib/cmake" \
		-DCMAKE_MODULE_PATH="$CLANDRO_PREFIX/share/ECM/modules" \
		-DECM_DIR="$CLANDRO_PREFIX/share/ECM/cmake" \
		-DTERMUX_PREFIX="$CLANDRO_PREFIX" \
		-DCMAKE_INSTALL_LIBDIR=lib

	ninja -j ${CLANDRO_PKG_MAKE_PROCESSES} install
}

clandro_step_pre_configure() {
	rm -rf $CLANDRO_HOSTBUILD_MARKER
}
