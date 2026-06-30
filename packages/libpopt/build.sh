CLANDRO_PKG_HOMEPAGE=https://www.linuxfromscratch.org/blfs/view/svn/general/popt.html
CLANDRO_PKG_DESCRIPTION="Library for parsing cmdline parameters"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.19
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=http://ftp.rpm.org/popt/releases/popt-1.x/popt-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=c25a4838fc8e4c1c8aacb8bd620edb3084a3d63bf8987fdad3ca2758c63240f9
CLANDRO_PKG_DEPENDS="libandroid-glob"
CLANDRO_PKG_BREAKS="libpopt-dev"
CLANDRO_PKG_REPLACES="libpopt-dev"
CLANDRO_PKG_RM_AFTER_INSTALL="lib/libpopt.la"

clandro_step_pre_configure() {
	LDFLAGS+=" -landroid-glob"
}
