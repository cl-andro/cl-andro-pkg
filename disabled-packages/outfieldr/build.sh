CLANDRO_PKG_HOMEPAGE=https://gitlab.com/ve-nt/outfieldr
CLANDRO_PKG_DESCRIPTION="A TLDR client in Zig"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.0.3
CLANDRO_PKG_SRCURL=git+https://gitlab.com/ve-nt/outfieldr
CLANDRO_PKG_GIT_BRANCH=$CLANDRO_PKG_VERSION
CLANDRO_PKG_DEPENDS="libc++"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXCLUDED_ARCHES="arm, i686"
CLANDRO_ZIG_VERSION="0.9.1"

clandro_step_make() {
	clandro_setup_zig
	ZIG_TARGET_NAME=${CLANDRO_ARCH}-linux-android
	zig build -Dtarget=$ZIG_TARGET_NAME
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin bin/tldr
}
