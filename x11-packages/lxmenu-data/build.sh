CLANDRO_PKG_HOMEPAGE=https://github.com/lxde/lxmenu-data
CLANDRO_PKG_DESCRIPTION="Freedesktop.org desktop menus for LXDE"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.1.7"
CLANDRO_PKG_SRCURL=https://github.com/lxde/lxmenu-data/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=9f601c68f6e993451587dd422e352aa5478b7f584947587d38773f329b9b6ab4
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"

clandro_step_pre_configure() {
	./autogen.sh
}
