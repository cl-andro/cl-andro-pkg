CLANDRO_PKG_HOMEPAGE=https://github.com/rui314/mold
CLANDRO_PKG_DESCRIPTION="mold: A Modern Linker"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.41.0"
CLANDRO_PKG_SRCURL=https://github.com/rui314/mold/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=0a61abac85d818437b425df856822e9d6e9982baeae5a93bcb02fe6c0060c61a
CLANDRO_PKG_DEPENDS="libandroid-spawn, libc++, openssl, zlib, zstd"
CLANDRO_PKG_AUTO_UPDATE=true

# dont depend on system libtbb, xxhash
# https://github.com/rui314/mold/commit/add94b86266b40bc66789e26358675da9d603919#commitcomment-80494077
