CLANDRO_PKG_HOMEPAGE=https://tools.suckless.org/tabbed/
CLANDRO_PKG_DESCRIPTION="Generic tabbed interface"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.9"
CLANDRO_PKG_SRCURL=https://dl.suckless.org/tools/tabbed-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=0acf87457b7419e66fbfa3a9cec95ffb46d254c6b88b5e4bb7cc18c3a92008a8
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libx11, libxft"
CLANDRO_PKG_BUILD_DEPENDS="xorgproto"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_post_get_source() {
	if [ ! -e ./xembed.1 ]; then
		cp $CLANDRO_PKG_BUILDER_DIR/xembed.1 ./
	fi
}
