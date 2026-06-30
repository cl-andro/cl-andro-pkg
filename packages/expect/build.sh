CLANDRO_PKG_HOMEPAGE=https://core.tcl.tk/expect/index
CLANDRO_PKG_DESCRIPTION="Tool for automating interactive terminal applications"
CLANDRO_PKG_LICENSE="Public Domain"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=5.45.4
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_SRCURL=http://downloads.sourceforge.net/project/expect/Expect/${CLANDRO_PKG_VERSION}/expect${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=49a7da83b0bdd9f46d04a04deec19c7767bb9a323e40c4781f89caf760b92c34
CLANDRO_PKG_DEPENDS="tcl"
CLANDRO_PKG_BREAKS="expect-dev"
CLANDRO_PKG_REPLACES="expect-dev"

clandro_step_pre_configure() {
	autoconf

	CPPFLAGS+=" -DHAVE_SYS_WAIT_H"
}

clandro_step_post_make_install() {
	cd $CLANDRO_PREFIX/lib
	ln -f -s expect${CLANDRO_PKG_VERSION}/libexpect${CLANDRO_PKG_VERSION}.so .
}
