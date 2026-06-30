CLANDRO_PKG_HOMEPAGE=https://github.com/dmtx/libdmtx
CLANDRO_PKG_DESCRIPTION="A software library that enables programs to read and write Data Matrix barcodes"
CLANDRO_PKG_LICENSE="BSD 2-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.7.8"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/dmtx/libdmtx/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=2394bf1d1d693a5a4ca3cfcc1bb28a4d878bdb831ea9ca8f3d5c995d274bdc39
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"

clandro_step_pre_configure() {
	autoreconf -fi
}
