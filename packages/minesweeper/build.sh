CLANDRO_PKG_HOMEPAGE=https://github.com/benhsm/minesweeper
CLANDRO_PKG_DESCRIPTION="A simple terminal-based implementation of Minesweeper"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.3.1"
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_SRCURL=https://github.com/benhsm/minesweeper/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=18d33713b0ab1d3ee40741ba712124fc973e8d6cffd6e5d5649c358a0cbf30b2
CLANDRO_PKG_GROUPS="games"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make() {
	clandro_setup_golang

	go build -o minesweeper
}

clandro_step_make_install() {
	install -Dm755 -t "${CLANDRO_PREFIX}"/bin minesweeper
}
