CLANDRO_PKG_HOMEPAGE=https://github.com/williamh/dotconf
CLANDRO_PKG_DESCRIPTION="dot.conf configuration file parser"
CLANDRO_PKG_VERSION="1.4.1"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_SRCURL=https://github.com/williamh/dotconf/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=5922c46cacf99b2ecc4853d28a2bda4a489292e73276e604bd9cba29dfca892d
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"

clandro_step_pre_configure () {
	aclocal && libtoolize --force && autoreconf -fi
}
