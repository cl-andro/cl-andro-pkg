CLANDRO_PKG_HOMEPAGE=https://www.gnu.org/software/indent/
CLANDRO_PKG_DESCRIPTION="C language source code formatting program"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.2.13
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://mirrors.kernel.org/gnu/indent/indent-$CLANDRO_PKG_VERSION.tar.xz
CLANDRO_PKG_SHA256=1b81ba4e9a006ca8e6eb5cbbe4cf4f75dfc1fc9301b459aa0d40393e85590a0b
CLANDRO_PKG_DEPENDS="libandroid-support"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_func_setlocale=no"
CLANDRO_PKG_RM_AFTER_INSTALL="bin/texinfo2man"
