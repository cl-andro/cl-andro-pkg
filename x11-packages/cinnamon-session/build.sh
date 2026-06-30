CLANDRO_PKG_HOMEPAGE=https://github.com/linuxmint/cinnamon-session
CLANDRO_PKG_DESCRIPTION="The Cinnamon session manager"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.6.3"
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL="https://github.com/linuxmint/cinnamon-session/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=ac7426dc383bbec3bd1576cb569d0837d95a87ec166a897263e0941be95feed6
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+(?!-)"
CLANDRO_PKG_DEPENDS="cinnamon-desktop, glib, gtk3, keybinder, libcanberra, libice, libsm, libx11, libxau, libxcomposite, libxext, opengl, pango, pygobject, python, python-pip, python-psutil, xapp"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, glib-cross"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_PYTHON_TARGET_DEPS="setproctitle"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dxtrans=false
-Dfake-consolekit=true
"

clandro_step_pre_configure() {
	clandro_setup_gir
	clandro_setup_glib_cross_pkg_config_wrapper

	export CLANDRO_MESON_ENABLE_SOVERSION=1
}
