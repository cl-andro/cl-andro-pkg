CLANDRO_PKG_HOMEPAGE=https://www.chocolate-doom.org
CLANDRO_PKG_DESCRIPTION="Historically-accurate Doom, Heretic, Hexen, and Strife ports."
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.1.1"
CLANDRO_PKG_SRCURL=https://github.com/chocolate-doom/chocolate-doom/archive/refs/tags/chocolate-doom-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=1edcc41254bdc194beb0d33e267fae306556c4d24110a1d3d3f865717f25da23
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="sdl2 | sdl2-compat, sdl2-mixer, sdl2-net"
CLANDRO_PKG_ANTI_BUILD_DEPENDS="sdl2-compat"

clandro_step_pre_configure(){
	autoreconf -fi
	CFLAGS+=" -fcommon"
}
