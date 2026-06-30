CLANDRO_PKG_HOMEPAGE=https://rustscan.github.io/RustScan
CLANDRO_PKG_DESCRIPTION="The modern,fast,smart and effective port scanner"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="Krishna Kanhaiya @kcubeterm"
CLANDRO_PKG_VERSION="2.4.1"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_DEPENDS="nmap"
CLANDRO_PKG_SRCURL=https://github.com/RustScan/RustScan/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=fa99c18a12d4c0939ab69ddb84ef7b85a1ea01d8fc86df227449d89473531765
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	clandro_setup_rust

	rm -r Makefile
}
