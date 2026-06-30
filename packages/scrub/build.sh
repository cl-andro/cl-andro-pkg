CLANDRO_PKG_HOMEPAGE=https://github.com/chaos/scrub
CLANDRO_PKG_DESCRIPTION="Iteratively writes patterns on files or disk devices to make retreiving the data more difficult"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.6.1
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://github.com/chaos/scrub/archive/refs/tags/$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=838b061b2e1932b342fb9695c5579cdff5d2d72506cb41d6d8032eba18aed969
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	./autogen.sh
}
