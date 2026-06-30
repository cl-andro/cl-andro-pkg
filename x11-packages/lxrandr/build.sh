CLANDRO_PKG_HOMEPAGE=http://www.lxde.org/
CLANDRO_PKG_DESCRIPTION="LXDE monitor configuration tool"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.3.3"
CLANDRO_PKG_SRCURL="https://github.com/lxde/lxrandr/archive/refs/tags/$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=24d0abaee830b0b2973ba9d2e46b3c801445342f7d5d3297c021a8a4a471f512
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_DEPENDS="xorg-xrandr, gtk3"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--enable-gtk3"

clandro_step_pre_configure() {
	./autogen.sh
}
