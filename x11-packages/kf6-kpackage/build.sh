CLANDRO_PKG_HOMEPAGE='https://invent.kde.org/frameworks/kpackage'
CLANDRO_PKG_DESCRIPTION='Framework that lets applications manage user installable packages of non-binary assets'
CLANDRO_PKG_LICENSE="LGPL-2.0, LGPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.26.0"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/frameworks/${CLANDRO_PKG_VERSION%.*}/kpackage-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=313cda4a335ecdb67bb8e2fcc15bdeb5970db17d5597282ca655bf97a98abab5
CLANDRO_PKG_DEPENDS="kf6-karchive (>= ${CLANDRO_PKG_VERSION%.*}), kf6-kcoreaddons (>= ${CLANDRO_PKG_VERSION%.*}), kf6-ki18n (>= ${CLANDRO_PKG_VERSION%.*}), libc++, qt6-qtbase"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules (>= ${CLANDRO_PKG_VERSION%.*}), qt6-qttools"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_HOSTBUILD=true
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
