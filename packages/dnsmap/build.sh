CLANDRO_PKG_HOMEPAGE=https://github.com/resurrecting-open-source-projects/dnsmap
CLANDRO_PKG_DESCRIPTION="Subdomain Bruteforcing Tool"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.36
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=https://github.com/resurrecting-open-source-projects/dnsmap/archive/refs/tags/$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=f52d6d49cbf9a60f601c919f99457f108d51ecd011c63e669d58f38d50ad853c
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	./autogen.sh
}
