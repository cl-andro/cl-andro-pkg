# Contributor: @Neo-Oli
CLANDRO_PKG_HOMEPAGE=https://www.colordiff.org/
CLANDRO_PKG_DESCRIPTION="Tool to colorize 'diff' output"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="Oliver Schmidhauser @Neo-Oli"
CLANDRO_PKG_VERSION=1.0.22
CLANDRO_PKG_SRCURL="https://www.colordiff.org/colordiff-${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=f96f73c54521c53f14dc164d5a3920c9ca21a0e5f8e9613f43812a98af3e22af
CLANDRO_PKG_DEPENDS="perl"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_AUTO_UPDATE=true

# Skip the 'make' build invocation
# as it only tries to rebuild the documentation.
clandro_step_make() {
	:
}

clandro_step_post_configure() {
	export INSTALL_DIR=${PREFIX}/bin
	export MAN_DIR=${PREFIX}/share/man/man1
	export ETC_DIR=${PREFIX}/etc
}
