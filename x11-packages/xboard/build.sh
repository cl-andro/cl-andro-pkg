CLANDRO_PKG_HOMEPAGE=https://www.gnu.org/software/xboard/
CLANDRO_PKG_DESCRIPTION="A graphical chessboard for the X Window System"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=4.9.1
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=https://mirrors.kernel.org/gnu/xboard/xboard-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=2b2e53e8428ad9b6e8dc8a55b3a5183381911a4dae2c0072fa96296bbb1970d6
CLANDRO_PKG_DEPENDS="glib, libcairo, librsvg, libx11, libxaw, libxmu, libxt, pango"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--without-gtk
"

clandro_step_pre_configure() {
	CFLAGS+=" -fcommon"
}
