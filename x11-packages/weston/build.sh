CLANDRO_PKG_HOMEPAGE=https://gitlab.freedesktop.org/wayland/weston
CLANDRO_PKG_DESCRIPTION="Reference implementation of a wayland compositor"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="14.0.2"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://gitlab.freedesktop.org/wayland/weston/-/archive/${CLANDRO_PKG_VERSION}/weston-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=633f4e0f232ad150300c95ffcbc646fedf1349487bf389dbd2045fa69013d6e2
CLANDRO_PKG_DEPENDS="freerdp, libaml, libandroid-shmem, libcairo, libcairo, libevdev, libglvnd, libneatvnc, libseat, libwayland, libwebp, libxcb, libxcursor, libxkbcommon, littlecms, pango, xcb-util-cursor"
CLANDRO_PKG_BUILD_DEPENDS="libwayland-cross-scanner, libwayland-protocols"
# XXX: Do not depend on gbm
CLANDRO_PKG_ANTI_BUILD_DEPENDS="mesa"
CLANDRO_PKG_AUTO_UPDATE=true
# Weston uses x.y.9z and x.9y.9z versions as unstable prereleases, do not update to them.
CLANDRO_PKG_UPDATE_VERSION_REGEXP='^\d+(?:\.[0-8]?\d){2}$'
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dbackend-drm=false
-Dbackend-drm-screencast-vaapi=false
-Dremoting=false
-Dpipewire=false
-Drenderer-gl=true
-Dbackend-pipewire=false
-Dbackend-default=headless
-Dxwayland-path=$CLANDRO_PREFIX/bin/Xwayland
-Dsystemd=false
-Dsimple-clients=damage,shm,touch
-Ddemo-clients=false
-Dtests=false
"

clandro_step_pre_configure() {
	clandro_setup_wayland_cross_pkg_config_wrapper

	export LDFLAGS+=" -landroid-shmem"
}
