CLANDRO_PKG_HOMEPAGE=https://www.gnu.org/software/global/
CLANDRO_PKG_DESCRIPTION="Source code search and browse tools"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.6.14"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://mirrors.kernel.org/gnu/global/global-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=f6e7fd0b68aed292e85bb686616baf6551d5c9424adcddca11d808ba318cb320
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_posix1_2008_realpath=yes
--with-posix-sort=$CLANDRO_PREFIX/bin/sort
--with-ncurses=$CLANDRO_PREFIX
"
# coreutils provides the posix sort executable:
CLANDRO_PKG_DEPENDS="coreutils, ncurses, libltdl"
