CLANDRO_PKG_HOMEPAGE=https://www.gnu.org/software/gengetopt/
CLANDRO_PKG_DESCRIPTION="gengetopt is a tool to write command line option parsing code for C programs"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.23
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_SRCURL=https://mirrors.kernel.org/gnu/gengetopt/gengetopt-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=b941aec9011864978dd7fdeb052b1943535824169d2aa2b0e7eae9ab807584ac
CLANDRO_PKG_DEPENDS="libc++"

clandro_step_pre_configure() {
	# gengetopt (2.23 at time of writing) uses std::unary_function, removed in C++ 17:
	CXXFLAGS+=" -std=c++11"
}
