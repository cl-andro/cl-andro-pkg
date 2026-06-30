CLANDRO_PKG_HOMEPAGE=https://www.nongnu.org/icoutils/
CLANDRO_PKG_DESCRIPTION="Extracts and converts images in MS Windows(R) icon and cursor files"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.32.3
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://savannah.nongnu.org/download/icoutils/icoutils-$CLANDRO_PKG_VERSION.tar.bz2
CLANDRO_PKG_SHA256=17abe02d043a253b68b47e3af69c9fc755b895db68fdc8811786125df564c6e0
CLANDRO_PKG_DEPENDS="libpng, perl"

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--mandir=$CLANDRO_PREFIX/share/man
"
