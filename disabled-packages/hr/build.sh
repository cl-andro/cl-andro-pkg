CLANDRO_PKG_HOMEPAGE=https://github.com/LuRsT/hr
CLANDRO_PKG_DESCRIPTION="A horizontal ruler for your terminal"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.5"
CLANDRO_PKG_SRCURL=$CLANDRO_PKG_HOMEPAGE/archive/$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=d4bb6e8495a8adaf7a70935172695d06943b4b10efcbfe4f8fcf6d5fe97ca251
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_DEPENDS=bash
CLANDRO_PKG_PLATFORM_INDEPENDENT=true

clandro_step_make() {
	return
}

clandro_step_make_install() {
	local bin="$(basename $CLANDRO_PKG_HOMEPAGE)"
	install -D "$bin" -t "$CLANDRO_PREFIX/bin"
	install -D "$bin.1" -t "$CLANDRO_PREFIX/share/man/man1"
}
