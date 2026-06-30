CLANDRO_PKG_HOMEPAGE=https://github.com/astrand/xclip
CLANDRO_PKG_DESCRIPTION="Command line interface to the X11 clipboard"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@Yisus7u7"
CLANDRO_PKG_VERSION=0.13
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://github.com/astrand/xclip/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=ca5b8804e3c910a66423a882d79bf3c9450b875ac8528791fb60ec9de667f758
CLANDRO_PKG_DEPENDS="libx11, libxmu"
CLANDRO_PKG_BUILD_DEPENDS="libxt"
CLANDRO_PKG_BUILD_IN_SRC=true
clandro_step_pre_configure(){
	CFLAGS+=" $CPPFLAGS"
	./bootstrap
}
