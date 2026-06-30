CLANDRO_PKG_HOMEPAGE='https://packages.debian.org/sid/source/bsd-finger'
CLANDRO_PKG_DESCRIPTION="User information lookup program"
CLANDRO_PKG_LICENSE="BSD"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.17
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=https://salsa.debian.org/debian/bsd-finger/-/archive/upstream/${CLANDRO_PKG_VERSION}/bsd-finger-upstream-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=56e18928a04b38eadea741f9f07db6155ce56b6992defba3c0e32f9caeee9109
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_MAKE_ARGS="
MANDIR=$CLANDRO_PREFIX/share/man
"

clandro_step_post_get_source() {
	sed -n '1,/*\//p' finger/finger.c > LICENSE
}

clandro_step_configure() {
	./configure
}
