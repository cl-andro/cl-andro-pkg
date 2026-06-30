CLANDRO_PKG_HOMEPAGE=http://net-tools.sourceforge.net/
CLANDRO_PKG_DESCRIPTION="Configuration tools for Linux networking"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.10.0
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://sourceforge.net/projects/net-tools/files/net-tools-2.10.tar.xz
CLANDRO_PKG_SHA256=b262435a5241e89bfa51c3cabd5133753952f7a7b7b93f32e08cb9d96f580d69
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_MAKE_ARGS="BINDIR=$CLANDRO_PREFIX/bin SBINDIR=$CLANDRO_PREFIX/bin HAVE_HOSTNAME_TOOLS=0"

clandro_step_configure() {
	CFLAGS="$CFLAGS -D_LINUX_IN6_H -Dindex=strchr -Drindex=strrchr"
	sed -i "s#/usr#$CLANDRO_PREFIX#" $CLANDRO_PKG_SRCDIR/man/Makefile
	yes "" | make config || true
}
