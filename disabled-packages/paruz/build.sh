CLANDRO_PKG_HOMEPAGE=https://github.com/joehillen/paruz
CLANDRO_PKG_DESCRIPTION="A fzf terminal UI for paru or pacman"
CLANDRO_PKG_LICENSE="Unlicense"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.1.2
CLANDRO_PKG_SRCURL=https://github.com/joehillen/paruz/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=1800e55136b2c17135a7139ae3f3f4706c60d23b957b9a92cb1d3bf2d5942123
CLANDRO_PKG_DEPENDS="bash, fzf"
CLANDRO_PKG_RECOMMENDS="pacman"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin paruz
}
