CLANDRO_PKG_HOMEPAGE=https://mate-desktop.org/
CLANDRO_PKG_DESCRIPTION="MATE menu editing tool"
CLANDRO_PKG_LICENSE="GPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.28.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://github.com/mate-desktop/mozo/releases/download/v$CLANDRO_PKG_VERSION/mozo-$CLANDRO_PKG_VERSION.tar.xz"
CLANDRO_PKG_SHA256=fe98984ffd6aa8c36d0594bcefdba03de39b42d41e007251680384f3cef44924
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="gtk3, python, mate-menus, pygobject, gettext, mate-panel"
CLANDRO_PKG_BUILD_DEPENDS="autoconf-archive, mate-common"
CLANDRO_PKG_RM_AFTER_INSTALL="
local
"

clandro_step_pre_configure() {
	clandro_setup_python_pip
}

clandro_step_post_make_install() {
	mkdir -p "$CLANDRO_PYTHON_HOME/site-packages"
}
