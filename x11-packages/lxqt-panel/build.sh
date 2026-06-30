CLANDRO_PKG_HOMEPAGE=https://lxqt.github.io
CLANDRO_PKG_DESCRIPTION="The LXQt desktop panel"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.4.0"
CLANDRO_PKG_SRCURL="https://github.com/lxqt/lxqt-panel/releases/download/${CLANDRO_PKG_VERSION}/lxqt-panel-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=23b9cda6e6ad47df61d2e813de2fced52597fd547de120d2eae8df5db4573702
CLANDRO_PKG_DEPENDS="kf6-kwindowsystem, layer-shell-qt, libc++, libdbusmenu-lxqt, liblxqt, libqtxdg, libsysstat, libxcb, libxkbcommon, libxtst, libx11, lxqt-globalkeys, lxqt-menu-data, pulseaudio, qt6-qtbase, xcb-util, xcb-util-image"
CLANDRO_PKG_BUILD_DEPENDS="lxqt-build-tools, qt6-qttools"
# TODO
# CPULOAD and NETWORKMONITOR require libstatgrab
# MOUNT plugin requires KF5Solid
# SENSORS plugin requires lm_sensors
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCPULOAD_PLUGIN=OFF
-DNETWORKMONITOR_PLUGIN=OFF
-DMOUNT_PLUGIN=OFF
-DSENSORS_PLUGIN=OFF
-DVOLUME_USE_ALSA=OFF
"
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DQt6LinguistTools_DIR=${CLANDRO_PREFIX}/opt/qt6/cross/lib/cmake/Qt6LinguistTools"
	fi

	# Add RUNPATH to the private libraries used by lxqt-panel's plugins
	LDFLAGS+=" -Wl,-rpath=${CLANDRO_PREFIX}/lib/lxqt-panel"
	export LDFLAGS
}
