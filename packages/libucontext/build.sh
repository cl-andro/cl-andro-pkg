CLANDRO_PKG_HOMEPAGE=https://github.com/kaniini/libucontext
CLANDRO_PKG_DESCRIPTION="A library which provides the ucontext.h C API"
CLANDRO_PKG_LICENSE="ISC"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.5"
CLANDRO_PKG_SRCURL=https://github.com/kaniini/libucontext/archive/refs/tags/libucontext-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=b3ca8d7d3e5c926a90ddb691f8a52ccb364069a745304a40c29f3b0d39b80c93
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="-Dfreestanding=true"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+(.\d+)?"
