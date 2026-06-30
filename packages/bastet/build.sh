CLANDRO_PKG_HOMEPAGE=http://fph.altervista.org/prog/bastet.html
CLANDRO_PKG_DESCRIPTION="Tetris clone with 'bastard' block-choosing AI"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.43.2"
CLANDRO_PKG_REVISION=13
CLANDRO_PKG_SRCURL="https://github.com/fph/bastet/archive/refs/tags/$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=f219510afc1d83e4651fbffd5921b1e0b926d5311da4f8fa7df103dc7f2c403f
CLANDRO_PKG_DEPENDS="libc++, ncurses"
CLANDRO_PKG_BUILD_DEPENDS="boost-headers, boost-static"
CLANDRO_PKG_EXTRA_MAKE_ARGS=" BOOST_PO=$CLANDRO_PREFIX/lib/libboost_program_options.a"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_GROUPS="games"

clandro_step_pre_configure() {
	# Code uses std::bind2nd removed in C++11:
	CXXFLAGS+=" -std=c++11"
}
