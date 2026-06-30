CLANDRO_PKG_HOMEPAGE=https://github.com/libxls/libxls
CLANDRO_PKG_DESCRIPTION="A C library for reading Excel files in the nasty old binary OLE format"
CLANDRO_PKG_LICENSE="BSD 2-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.6.3"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://github.com/libxls/libxls/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=587c9f0ebb5647eb68ec1e0ed8c3f7f6102622d6dd83473a21d3a36dee04eed7
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--program-prefix=lib"

clandro_step_pre_configure() {
	autoreconf -fi
}
