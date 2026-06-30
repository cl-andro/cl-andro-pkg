CLANDRO_PKG_HOMEPAGE=https://mailsync.sourceforge.net/
CLANDRO_PKG_DESCRIPTION="A way of synchronizing a collection of mailboxes"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=5.2.7
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://master.dl.sourceforge.net/project/mailsync/mailsync/${CLANDRO_PKG_VERSION}/mailsync_${CLANDRO_PKG_VERSION}-1.tar.gz
CLANDRO_PKG_SHA256=041bff09050d7c57134b53455e9dc7f858c1f8ba968e0cee6c73a226793aa833
CLANDRO_PKG_DEPENDS="libc++, libc-client"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--with-c-client=$CLANDRO_PREFIX"

clandro_step_pre_configure() {
	autoreconf -fi
}
