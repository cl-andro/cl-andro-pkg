CLANDRO_PKG_HOMEPAGE=https://github.com/linuxmint/cinnamon-control-center
CLANDRO_PKG_DESCRIPTION="Cinnamon control center"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.6.0"
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_SRCURL="https://github.com/linuxmint/cinnamon-control-center/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=2de5fbc5a9fcc2e1dad9c595dfb1d9047ff885d391f45d6ffe8b6711bb4e24e4
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+(?!-)"
CLANDRO_PKG_DEPENDS="glib, gtk3, libgnomekbd, libnotify, libx11, libxklavier, python-pip, upower, cinnamon-desktop, cinnamon-menus, cinnamon-settings-daemon"
CLANDRO_PKG_BUILD_DEPENDS="glib-cross"
CLANDRO_PKG_PYTHON_TARGET_DEPS="setproctitle"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dcolor=false
-Dmodemmanager=false
-Dnetworkmanager=false
-Donlineaccounts=false
-Dwacom=false
-Dpolkit=false
-Dudev=false
"

clandro_step_pre_configure() {
	clandro_setup_glib_cross_pkg_config_wrapper

	export CLANDRO_MESON_ENABLE_SOVERSION=1
}
