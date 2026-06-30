CLANDRO_PKG_HOMEPAGE=https://www.finnie.org/software/2ping/
CLANDRO_PKG_DESCRIPTION="A bi-directional ping utility"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=4.5.1
CLANDRO_PKG_REVISION=5
CLANDRO_PKG_SRCURL=https://github.com/rfinnie/2ping/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=0f85dc21be1266daccfbba903819ca8935ebdbe002b1e0305bfda258af44fdcd
CLANDRO_PKG_DEPENDS="python"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_PYTHON_COMMON_BUILD_DEPS="wheel"

clandro_step_post_make_install() {
	install -Dm600 -t $CLANDRO_PREFIX/share/man/man1 doc/2ping.1
}
