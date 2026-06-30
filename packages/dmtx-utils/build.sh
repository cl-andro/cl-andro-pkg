CLANDRO_PKG_HOMEPAGE=https://github.com/dmtx/dmtx-utils
CLANDRO_PKG_DESCRIPTION="A command line interface for libdmtx"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.7.6
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://github.com/dmtx/dmtx-utils/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=0d396ec14f32a8cf9e08369a4122a16aa2e5fa1675e02218f16f1ab777ea2a28
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_DEPENDS="imagemagick, libdmtx"

clandro_step_pre_configure() {
	autoreconf -fi
}
