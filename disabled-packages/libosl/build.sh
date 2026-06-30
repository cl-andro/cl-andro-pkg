CLANDRO_PKG_HOMEPAGE="http://icps.u-strasbg.fr/~bastoul/development/openscop"
CLANDRO_PKG_DESCRIPTION="A Specification and a Library for Data Exchange in Polyhedral Compilation Tools"
CLANDRO_PKG_GROUPS="science"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.9.7"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://github.com/periscop/openscop/archive/refs/tags/$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=bdb566af5c68cb8bb66dc204b1dcafebaa843a25dfdbcc64dfcc21a1912c3e66
CLANDRO_PKG_DEPENDS="libgmp"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_post_get_source() {
	rm -f CMakeLists.txt
}
clandro_step_pre_configure() {
	autoreconf -fi
}
