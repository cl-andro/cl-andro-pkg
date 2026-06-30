CLANDRO_PKG_HOMEPAGE=https://github.com/lsof-org/lsof
CLANDRO_PKG_DESCRIPTION="Lists open files for running Unix processes"
CLANDRO_PKG_LICENSE="custom"
CLANDRO_PKG_LICENSE_FILE="COPYING"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.99.6"
CLANDRO_PKG_SRCURL=https://github.com/lsof-org/lsof/archive/refs/tags/${CLANDRO_PKG_VERSION}/lsof-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=2ce65158694e9c44dfc54916f5b843d887763c03128e0a1c77d62ae106537009
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libandroid-support, libtirpc"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--with-libtirpc
--with-selinux=no
"

clandro_step_pre_configure() {
	autoreconf -fiv
}
