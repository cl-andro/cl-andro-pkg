CLANDRO_PKG_HOMEPAGE=https://xkbcommon.org/
CLANDRO_PKG_DESCRIPTION="Keymap handling library for toolkits and window systems"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.13.1"
CLANDRO_PKG_SRCURL=https://github.com/xkbcommon/libxkbcommon/archive/refs/tags/xkbcommon-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=aeb951964c2f7ecc08174cb5517962d157595e9e3f38fc4a130b91dc2f9fec18
CLANDRO_PKG_DEPENDS="libxcb, libxml2, libwayland, xkeyboard-config"
CLANDRO_PKG_BUILD_DEPENDS="libwayland-protocols, xorg-util-macros"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Denable-docs=false
-Denable-wayland=true
"

clandro_step_pre_configure() {
	clandro_setup_cmake
	clandro_setup_ninja
	clandro_setup_wayland_cross_pkg_config_wrapper
}
