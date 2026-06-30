CLANDRO_PKG_HOMEPAGE="http://www.bastoul.net/cloog/index.php"
CLANDRO_PKG_DESCRIPTION="Library that generates loops for scanning polyhedra"
CLANDRO_PKG_GROUPS="science"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.21.1"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://github.com/periscop/cloog/archive/refs/tags/cloog-$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=eace8938416a3240c073bdf935b12d2f9c115ec574d9bcbcc9423fe96ed530eb
CLANDRO_PKG_DEPENDS="libisl, libosl"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--with-isl=system
--with-osl=system
"

clandro_step_pre_configure() {
	autoreconf -fi
}
