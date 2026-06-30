CLANDRO_PKG_HOMEPAGE=https://libbsd.freedesktop.org
CLANDRO_PKG_DESCRIPTION="utility functions from BSD systems"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.11.7"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://libbsd.freedesktop.org/releases/libbsd-$CLANDRO_PKG_VERSION.tar.xz
CLANDRO_PKG_SHA256=9baa186059ebbf25c06308e9f991fda31f7183c0f24931826d83aa6abd8a0261
CLANDRO_PKG_DEPENDS="libmd"
CLANDRO_PKG_BREAKS="libbsd-dev"
CLANDRO_PKG_REPLACES="libbsd-dev"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	# Fix linker script error
	LDFLAGS+=" -Wl,--undefined-version"
}
