CLANDRO_PKG_HOMEPAGE=https://mcrypt.sourceforge.net/
CLANDRO_PKG_DESCRIPTION="A library which provides a uniform interface to several symmetric encryption algorithms"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.5.8"
CLANDRO_PKG_REVISION=6
CLANDRO_PKG_SRCURL=https://downloads.sourceforge.net/mcrypt/libmcrypt-$CLANDRO_PKG_VERSION.tar.bz2
CLANDRO_PKG_SHA256=bf2f1671f44af88e66477db0982d5ecb5116a5c767b0a0d68acb34499d41b793
CLANDRO_PKG_BREAKS="libmcrypt-dev"
CLANDRO_PKG_REPLACES="libmcrypt-dev"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--mandir=$CLANDRO_PREFIX/share/man"

clandro_step_pre_configure() {
	# configure tries to compile and execute program which fails while cross-compiling in docker
	export ac_cv_header_stdc=yes
}
