CLANDRO_PKG_HOMEPAGE="https://invent.kde.org/frameworks/kcmutils"
CLANDRO_PKG_DESCRIPTION="Utilities for interacting with KCModules"
CLANDRO_PKG_LICENSE="LGPL-2.0-only, LGPL-3.0-only"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.25.0"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/frameworks/${CLANDRO_PKG_VERSION%.*}/kcmutils-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=cc7c01e948d7040e9e002ea5379ce8c05f2a85f28cdd4431aee106bdf0661c3d
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_DEPENDS="kf6-kconfig, kf6-kconfigwidgets, kf6-kcoreaddons, kf6-kguiaddons, kf6-ki18n, kf6-kio, kf6-kirigami, kf6-kitemviews, kf6-kservice, kf6-kwidgetsaddons, kf6-kxmlgui, libc++, qt6-qtbase, qt6-qtdeclarative"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules (>= ${CLANDRO_PKG_VERSION%.*}), qt6-qttools"
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

	cmake \
		-G Ninja \
		-S "${CLANDRO_PKG_SRCDIR}" \
		-B "${CLANDRO_PKG_HOSTBUILD_DIR}" \
		-DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_INSTALL_PREFIX="$CLANDRO_PREFIX/opt/kf6/cross" \
		-DCMAKE_PREFIX_PATH="$CLANDRO_PREFIX/opt/qt6/cross/lib/cmake" \
		-DCMAKE_MODULE_PATH="$CLANDRO_PREFIX/share/ECM/modules" \
		-DKDE_INSTALL_LIBEXECDIR_KF=lib/libexec/kf6 \
		-DKDE_INSTALL_CMAKEPACKAGEDIR=lib/cmake \
		-DECM_DIR="$CLANDRO_PREFIX/share/ECM/cmake" \
		-DTERMUX_PREFIX="$CLANDRO_PREFIX" \
		-DCMAKE_INSTALL_LIBDIR=lib \
		-DTOOLS_ONLY=ON
	ninja \
		-j ${CLANDRO_PKG_MAKE_PROCESSES} \
		install
}

clandro_step_post_make_install() {
	mkdir -p "$CLANDRO_PREFIX/opt/kf6/cross/lib/cmake"
	cp -r "$CLANDRO_PREFIX/lib/cmake/KF6KCMUtils" "$CLANDRO_PREFIX/opt/kf6/cross/lib/cmake"
	sed -e 's|_IMPORT_PREFIX "'"$CLANDRO_PREFIX"'"|_IMPORT_PREFIX "'"$CLANDRO_PREFIX"'/opt/kf6/cross"|' -i "$CLANDRO_PREFIX/opt/kf6/cross/lib/cmake/KF6KCMUtils/KF6KCMUtilsToolingTargets.cmake"
	sed -e 's|'"$CLANDRO_PREFIX"'/lib/libexec/kf6/kcmdesktopfilegenerator|'"$CLANDRO_PREFIX"'/opt/kf6/cross/lib/libexec/kf6/kcmdesktopfilegenerator|' -i "$CLANDRO_PREFIX/opt/kf6/cross/lib/cmake/KF6KCMUtils/KF6KCMUtilsToolingTargets-release.cmake"
}
