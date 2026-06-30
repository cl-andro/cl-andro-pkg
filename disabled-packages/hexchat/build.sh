CLANDRO_PKG_HOMEPAGE=https://hexchat.github.io/
CLANDRO_PKG_DESCRIPTION="A popular and easy to use graphical IRC (chat) client"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.16.2"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/hexchat/hexchat/archive/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=486d73cdb6a89fa91cfbe242107901d06e777bea25956a7786c4a831a2caa0e3
CLANDRO_PKG_DEPENDS="gdk-pixbuf, glib, gtk2, liblua53, libx11, openssl, pango, python"
CLANDRO_PKG_BUILD_DEPENDS="glib-cross"
CLANDRO_PKG_PYTHON_COMMON_BUILD_DEPS="cffi"

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dlibcanberra=disabled
-Ddbus=disabled
-Dwith-lua=lua53
-Dtext-frontend=true
-Dwith-perl=false
-Dwith-sysinfo=false
"

CLANDRO_PKG_RM_AFTER_INSTALL="share/locale"

clandro_step_pre_configure() {
	clandro_setup_glib_cross_pkg_config_wrapper
}
