CLANDRO_PKG_HOMEPAGE=https://vifm.info/
CLANDRO_PKG_DESCRIPTION="File manager with vi like keybindings"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.14.3"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/vifm/vifm/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=9e21e69f0bfa00a470c01f4b83e011af6a4e69626237a8d12afc0d79a7819be8
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="ncurses, file"

clandro_step_pre_configure() {
	autoreconf -if
}
