CLANDRO_PKG_HOMEPAGE=https://docs.xfce.org/apps/gigolo/start
CLANDRO_PKG_DESCRIPTION="Gigolo is a frontend to easily manage connections to local and remote filesystems using GIO/GVfs."
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.6.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://archive.xfce.org/src/apps/gigolo/${CLANDRO_PKG_VERSION%.*}/gigolo-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=f27dbb51abe8144c1b981f2d820ad1b279c1bc4623d7333b7d4f5f4777eb45ed
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="glib, gtk3"

clandro_step_pre_configure() {
	clandro_setup_glib_cross_pkg_config_wrapper
}
