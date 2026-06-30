CLANDRO_PKG_HOMEPAGE=https://github.com/go-musicfox/go-musicfox
CLANDRO_PKG_DESCRIPTION="A netease music player in terminal."
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@anhoder"
CLANDRO_PKG_VERSION="4.8.5"
CLANDRO_PKG_DEPENDS="libc++, libflac, libvorbis"
CLANDRO_PKG_SRCURL=https://github.com/go-musicfox/go-musicfox/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=bdb243dccbafee2d52026dab43501ab03253fe2f87660ad05e6db91676be4a24
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make() {
	clandro_setup_golang

	GIT_TAG="v${CLANDRO_PKG_VERSION}" make build
}

clandro_step_make_install() {
	install -Dm755 -t $CLANDRO_PREFIX/bin $CLANDRO_PKG_SRCDIR/bin/musicfox
}
