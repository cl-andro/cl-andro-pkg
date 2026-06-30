CLANDRO_PKG_HOMEPAGE=https://potrace.sourceforge.net
CLANDRO_PKG_DESCRIPTION="Tool for transforming a bitmap into a smooth, scalable image"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.16
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://distfiles.macports.org/potrace/potrace-$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=be8248a17dedd6ccbaab2fcc45835bb0502d062e40fbded3bc56028ce5eb7acc
CLANDRO_PKG_DEPENDS="zlib"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--with-libpotrace
"
