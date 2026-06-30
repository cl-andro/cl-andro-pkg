CLANDRO_PKG_HOMEPAGE=https://github.com/muellan/clipp
CLANDRO_PKG_DESCRIPTION="Command line interfaces for modern C++"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.2.3
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/muellan/clipp/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=73da8e3d354fececdea99f7deb79d0343647349563ace3eafb7f4cca6e86e90b
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_PLATFORM_INDEPENDENT=true

clandro_step_make_install() {
	install -Dm600 -t $CLANDRO_PREFIX/include include/clipp.h
}
