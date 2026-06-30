CLANDRO_PKG_HOMEPAGE=https://github.com/hackerb9/lsix
CLANDRO_PKG_DESCRIPTION="Shows thumbnails in terminal using sixel graphics"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.9.1"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/hackerb9/lsix/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=310e25389da13c19a0793adcea87f7bc9aa8acc92d9534407c8fbd5227a0e05d
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="bash, imagemagick"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin lsix
}
