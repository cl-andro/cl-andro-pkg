CLANDRO_PKG_HOMEPAGE=https://github.com/cernekee/stoken
CLANDRO_PKG_DESCRIPTION="Software Token for Linux/UNIX"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.93"
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=https://github.com/cernekee/stoken/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=102e2d112b275efcdc20ef438670e4f24f08870b9072a81fda316efcc38aef9c
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_DEPENDS="libnettle, libxml2"

clandro_step_pre_configure() {
	autoreconf -fi
	LDFLAGS+=" -Wl,-undefined-version"
}
