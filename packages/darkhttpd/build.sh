CLANDRO_PKG_HOMEPAGE=https://unix4lyfe.org/darkhttpd
CLANDRO_PKG_DESCRIPTION="A simple webserver, implemented in a single .c file."
CLANDRO_PKG_LICENSE="BSD"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.17"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/emikulic/darkhttpd/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=4fee9927e2d8bb0a302f0dd62f9ff1e075748fa9f5162c9481a7a58b41462b56
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	CFLAGS+=" $LDFLAGS"
}
