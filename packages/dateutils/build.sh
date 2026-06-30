CLANDRO_PKG_HOMEPAGE="https://www.fresse.org/dateutils/"
CLANDRO_PKG_DESCRIPTION="Command line date and time utilities"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.4.11"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/hroptatyr/dateutils/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=9041b220b8cdb0e4e12292d8f71e7ad65fffd67873e96a3e52bfd226240deaec
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS='--with-old-links=no'

clandro_step_host_build() {
	pushd $CLANDRO_PKG_SRCDIR
	autoreconf -fi
	./configure
	make -C build-aux yuck-bootstrap yuck.yucc yuck

	# Cleanup Makefile to prevent compiling with host parameters
	find -name Makefile -exec rm {} \;
	popd
}
