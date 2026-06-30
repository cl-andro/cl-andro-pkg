CLANDRO_PKG_HOMEPAGE=https://sourceforge.net/projects/pcmanfm/
CLANDRO_PKG_DESCRIPTION="Extremely fast and lightweight file manager"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.4.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/lxde/pcmanfm/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=cda4f5ad7e049dcdf3b051b9de4c779adcd55bd720e9c96c45275389aa84264e
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_DEPENDS="atk, glib, gtk3, libcairo, libfm, libx11, lxmenu-data, pango"
CLANDRO_PKG_RECOMMENDS="xarchiver"

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--with-gtk=3
"

clandro_step_pre_configure() {
	autoreconf -fi
}
