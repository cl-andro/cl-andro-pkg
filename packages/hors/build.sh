CLANDRO_PKG_HOMEPAGE=https://github.com/WindSoilder/hors
CLANDRO_PKG_DESCRIPTION="Instant coding answers via the command line (howdoi in rust)"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="Krishna Kanhaiya @kcubeterm"
CLANDRO_PKG_VERSION=0.8.2
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=https://github.com/WindSoilder/hors/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=22419b26f64a2793759d3a3616df58196897cd9227074f475aeb3e1c366296a9
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	clandro_setup_rust

	rm -f Makefile
}
