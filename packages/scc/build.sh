CLANDRO_PKG_HOMEPAGE=https://github.com/boyter/scc
CLANDRO_PKG_DESCRIPTION="Counts physical the lines of code, blank lines, comment lines, and physical lines of source code"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.7.0"
CLANDRO_PKG_SRCURL=https://github.com/boyter/scc/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=447233f70ebcc24f1dafb27b093afdd17d3a1d662de96e8226130c5308b02d01
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make() {
	clandro_setup_golang

	go mod init || :
	go mod tidy
	go build
}

clandro_step_make_install() {
	install -Dm700 -t "$CLANDRO_PREFIX"/bin scc
}
