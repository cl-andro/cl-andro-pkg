CLANDRO_PKG_HOMEPAGE=https://github.com/lxde/lxde-icon-theme
CLANDRO_PKG_DESCRIPTION="LXDE default icon theme based on nuoveXT2"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.5.2"
CLANDRO_PKG_SRCURL=https://github.com/lxde/lxde-icon-theme/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=5b71da247ba25ddcd991a3a184ca5ac92f40b7676766e1e59437067a20f7ecf7
CLANDRO_PKG_DEPENDS="gtk-update-icon-cache"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"

clandro_step_pre_configure() {
	autoreconf -fiv
}
