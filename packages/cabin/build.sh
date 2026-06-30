CLANDRO_PKG_HOMEPAGE=https://github.com/cabinpkg/cabin
CLANDRO_PKG_DESCRIPTION="A package manager and build system for C++"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.13.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://github.com/cabinpkg/cabin/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=f9115bb0566800beedb41106e00f44a7eaf1dea0fa6528281e31de5f80864177
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_CONFLICTS="poac"
CLANDRO_PKG_REPLACES="poac"
CLANDRO_PKG_BUILD_DEPENDS="nlohmann-json"
CLANDRO_PKG_DEPENDS="fmt, libc++, libcurl, libgit2, libspdlog, libtbb"
CLANDRO_PKG_SUGGESTS="clang, make, pkg-config"
CLANDRO_PKG_EXCLUDED_ARCHES="arm, i686"

clandro_step_make() {
	make RELEASE=1 -j$CLANDRO_PKG_MAKE_PROCESSES
}

clandro_step_make_install() {
	install -Dm755 -t $CLANDRO_PREFIX/bin build/cabin
}
