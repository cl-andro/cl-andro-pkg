CLANDRO_PKG_HOMEPAGE=https://qalculate.github.io/
CLANDRO_PKG_DESCRIPTION="Powerful and easy to use command line calculator"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="5.10.0"
CLANDRO_PKG_SRCURL=https://github.com/Qalculate/libqalculate/releases/download/v$CLANDRO_PKG_VERSION/libqalculate-$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=904592d33a98ed4a26a59fa34c855578e096144fb91965b8afc90e06797dba8e
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++, libcurl, libgmp, libiconv, libmpfr, libxml2, readline"
CLANDRO_PKG_BREAKS="qalc-dev"
CLANDRO_PKG_REPLACES="qalc-dev"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--without-icu"

clandro_step_pre_configure() {
	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}
