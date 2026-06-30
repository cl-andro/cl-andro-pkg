CLANDRO_PKG_HOMEPAGE=https://github.com/kdabir/has
CLANDRO_PKG_DESCRIPTION="has checks presence of various command line tools and their versions on the path"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.5.2"
CLANDRO_PKG_SRCURL=$CLANDRO_PKG_HOMEPAGE/archive/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=965629d00b9c41fab2a9c37b551e3d860df986d86cdebd9b845178db8f1c998e
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_DEPENDS="bash, ncurses-utils"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true

clandro_step_make() {
	return
}

clandro_step_make_install() {
	local bin="$(basename $CLANDRO_PKG_HOMEPAGE)"
	install -D "$bin" -t "$CLANDRO_PREFIX/bin"
}
