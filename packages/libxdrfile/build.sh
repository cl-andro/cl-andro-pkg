CLANDRO_PKG_HOMEPAGE="https://userguide.mdanalysis.org/stable/formats/reference/xtc.html"
CLANDRO_PKG_DESCRIPTION="Library for reading and writing xtc, edr and trr files"
CLANDRO_PKG_GROUPS="science"
CLANDRO_PKG_LICENSE="BSD 2-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.1.4"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL="ftp://ftp.gromacs.org/pub/contrib/xdrfile-$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=e3c587c5ff24441a092fe2f3bc1dc03667bf126558f437161e779bfbcce48022

# enable fortran when we have gfortran
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--with-pic
--enable-shared
--disable-static
--disable-fortran
"
