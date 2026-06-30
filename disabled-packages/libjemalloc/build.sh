CLANDRO_PKG_HOMEPAGE=http://www.canonware.com/jemalloc/
CLANDRO_PKG_DESCRIPTION="General-purpose scalable concurrent malloc(3) implementation"
CLANDRO_PKG_LICENSE="BSD 2-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=4.0.0
CLANDRO_PKG_SRCURL=https://github.com/jemalloc/jemalloc/releases/download/${CLANDRO_PKG_VERSION}/jemalloc-${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256="214dbc74c3669b34219b0c5a55cb96f07cb12f44c834ed9ee64d1185ee6c3ef2"
CLANDRO_PKG_BUILD_IN_SRC=true

CPPFLAGS+=" -D__GCC_HAVE_SYNC_COMPARE_AND_SWAP_4=1"
