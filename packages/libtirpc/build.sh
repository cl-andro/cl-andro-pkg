CLANDRO_PKG_HOMEPAGE="http://git.linux-nfs.org/?p=steved/libtirpc.git"
CLANDRO_PKG_DESCRIPTION="Transport Independent RPC library"
CLANDRO_PKG_LICENSE="BSD"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.3.7"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://downloads.sourceforge.net/sourceforge/libtirpc/libtirpc-${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=b47d3ac19d3549e54a05d0019a6c400674da716123858cfdb6d3bdd70a66c702
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-gssapi
--enable-rpcdb
"

clandro_step_post_get_source() {
	sed -i "s/AC_INIT(libtirpc, [^)]*)/AC_INIT(libtirpc, ${CLANDRO_PKG_VERSION##*:})/" configure.ac
}

clandro_step_pre_configure() {
	# Avoid build errors such as: version script assignment of 'TIRPC_0.3.0' to symbol '_svcauth_gss' failed: symbol not defined
	LDFLAGS+=" -Wl,-undefined-version"

	autoreconf -fiv
}
