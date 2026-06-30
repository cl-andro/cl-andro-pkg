CLANDRO_PKG_HOMEPAGE=https://gitlab.freedesktop.org/emersion/wlr-randr
CLANDRO_PKG_DESCRIPTION="Utility to manage outputs of a Wayland compositor"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@JesusChapman <jesuschapmandev@outlook.com>"
CLANDRO_PKG_VERSION=0.5.0
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://gitlab.freedesktop.org/emersion/wlr-randr/-/archive/v${CLANDRO_PKG_VERSION}/wlr-randr-v${CLANDRO_PKG_VERSION}.zip
CLANDRO_PKG_SHA256=23382ce43bb7fe0fdca6b09daeec6b320018824c6cdbed5048ff36dc7fcd0fd5
CLANDRO_PKG_DEPENDS="libwayland"
CLANDRO_PKG_BUILD_DEPENDS="libwayland-cross-scanner"

clandro_step_pre_configure(){
	clandro_setup_wayland_cross_pkg_config_wrapper
}
