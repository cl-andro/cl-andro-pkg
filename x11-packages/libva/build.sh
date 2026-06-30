CLANDRO_PKG_HOMEPAGE="https://github.com/intel/libva"
CLANDRO_PKG_DESCRIPTION="Video Acceleration (VA) API for Linux"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.23.0"
CLANDRO_PKG_SRCURL="https://github.com/intel/libva/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=b10aceb30e93ddf13b2030eb70079574ba437be9b3b76065caf28a72c07e23e7
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++, libdrm, libx11, libxext, libxfixes, libwayland"
CLANDRO_PKG_BUILD_DEPENDS="libglvnd, mesa, mesa-dev"
clandro_step_pre_configure() {
	clandro_setup_wayland_cross_pkg_config_wrapper
}
