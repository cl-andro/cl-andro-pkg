CLANDRO_PKG_HOMEPAGE=https://github.com/argp-standalone/argp-standalone
CLANDRO_PKG_DESCRIPTION="Standalone version of arguments parsing functions from GLIBC"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.5.0
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/argp-standalone/argp-standalone/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=c29eae929dfebd575c38174f2c8c315766092cec99a8f987569d0cad3c6d64f6
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"

clandro_step_pre_configure() {
	autoreconf -fi
}

clandro_step_post_make_install() {
	install -Dm600 $CLANDRO_PKG_SRCDIR/argp.h $CLANDRO_PREFIX/include
}
