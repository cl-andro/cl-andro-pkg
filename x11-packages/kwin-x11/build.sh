CLANDRO_PKG_HOMEPAGE="https://invent.kde.org/plasma/kwin-x11"
CLANDRO_PKG_DESCRIPTION="An easy to use, but flexible, X Window Manager"
CLANDRO_PKG_LICENSE="LGPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.6.4"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/plasma/${CLANDRO_PKG_VERSION}/kwin-x11-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=81106d8b89fa2a9c93434e41aadc040ff2d7afb3b4693f423a45853806836e98
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_DEPENDS="aurorae, breeze, kf6-kauth, kf6-kcmutils, kf6-kcolorscheme, kf6-kconfig, kf6-kcoreaddons, kf6-kcrash, kf6-kdeclarative, kdecoration, kf6-kglobalaccel, kglobalacceld, kf6-kguiaddons, kf6-ki18n, kf6-kidletime, kf6-kirigami, kf6-kitemmodels, kf6-knewstuff, kf6-knotifications, kf6-kpackage, kf6-kservice, kf6-ksvg, kf6-kwidgetsaddons, kf6-kwindowsystem, kf6-kxmlgui, knighttime, libc++, libcanberra, libdisplay-info, libdrm, libepoxy, libplasma, libqaccessibilityclient-qt6, libwayland, libx11, libxcb, libxi, libxkbcommon, littlecms, mesa, plasma-activities, qt6-qt5compat, qt6-qtbase, qt6-qtdeclarative, qt6-qtsensors, qt6-qtsvg, qt6-qttools, qt6-qtwayland, xcb-util-cursor, xcb-util-keysyms, xcb-util-wm"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules, plasma-wayland-protocols, libwayland-protocols"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
-DBUILD_QT6=ON
-DKWIN_BUILD_SCREENLOCKER=OFF
-DCMAKE_INTERPROCEDURAL_OPTIMIZATION=OFF
"

clandro_step_host_build() {
	# we'll only build qtwaylandscanner_kde here
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "true" ]]; then
		return
	fi

	clandro_setup_cmake
	clandro_setup_ninja

	cmake -G Ninja \
		-S "${CLANDRO_PKG_SRCDIR}/src/wayland/tools" \
		-B "${CLANDRO_PKG_HOSTBUILD_DIR}" \
		-DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_INSTALL_PREFIX=$CLANDRO_PREFIX/opt/kf6/cross \
		-DCMAKE_PREFIX_PATH="$CLANDRO_PREFIX/opt/qt6/cross/lib/cmake" \
		-DCMAKE_MODULE_PATH="$CLANDRO_PREFIX/share/ECM/modules" \
		-DECM_DIR="$CLANDRO_PREFIX/share/ECM/cmake" \
		-DTERMUX_PREFIX="$CLANDRO_PREFIX" \
		-DCMAKE_INSTALL_LIBDIR=lib

	ninja -j ${CLANDRO_PKG_MAKE_PROCESSES}

	mkdir -p "$CLANDRO_PREFIX/opt/kf6/cross/bin"
	cp "$CLANDRO_PKG_HOSTBUILD_DIR/qtwaylandscanner_kde" "$CLANDRO_PREFIX/opt/kf6/cross/bin/"
}

clandro_step_pre_configure() {
	rm -rf $CLANDRO_HOSTBUILD_MARKER

	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "true" ]]; then
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DKF6_HOST_TOOLING=$CLANDRO_PREFIX/lib/cmake"
	else
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DKF6_HOST_TOOLING=$CLANDRO_PREFIX/opt/kf6/cross/lib/cmake"
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DQTWAYLANDSCANNER_KDE_EXECUTABLE=$CLANDRO_PREFIX/opt/kf6/cross/bin/qtwaylandscanner_kde"
	fi

	LDFLAGS+=" -landroid-shmem"
}
