CLANDRO_PKG_HOMEPAGE=http://www.dest-unreach.org/socat/
CLANDRO_PKG_DESCRIPTION="Relay for bidirectional data transfer between two independent data channels"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.8.1.1"
CLANDRO_PKG_SRCURL=http://www.dest-unreach.org/socat/download/socat-$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=f68b602c80e94b4b7498d74ec408785536fe33534b39467977a82ab2f7f01ddb
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="openssl, readline"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-posixmq
ac_cv_header_resolv_h=no
ac_cv_c_compiler_gnu=yes
ac_compiler_gnu=yes
sc_cv_getprotobynumber_r=
" # sc_cv_sys_crdly_shift=9 sc_cv_sys_csize_shift=4 sc_cv_sys_tabdly_shift=11"
CLANDRO_PKG_BUILD_IN_SRC=true
