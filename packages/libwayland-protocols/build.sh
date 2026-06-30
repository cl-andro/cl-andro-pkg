CLANDRO_PKG_HOMEPAGE=https://wayland.freedesktop.org/
CLANDRO_PKG_DESCRIPTION="Wayland protocols library"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.48"
CLANDRO_PKG_SRCURL=https://gitlab.freedesktop.org/wayland/wayland-protocols/-/releases/${CLANDRO_PKG_VERSION}/downloads/wayland-protocols-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=398036ac0eb6484982ddbde7ff86848d753231f9cdeeae983f06b52946625aa1
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_BUILD_DEPENDS="libwayland, libwayland-cross-scanner"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dtests=false
"

clandro_step_pre_configure() {
	clandro_setup_wayland_cross_pkg_config_wrapper
}
