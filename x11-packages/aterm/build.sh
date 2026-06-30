CLANDRO_PKG_HOMEPAGE=https://sourceforge.net/projects/aterm/
CLANDRO_PKG_DESCRIPTION="An xterm replacement with transparency support"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.0.1
CLANDRO_PKG_REVISION=34
CLANDRO_PKG_SRCURL=https://downloads.sourceforge.net/aterm/aterm-${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=a161c3b2d9c7149130a41963899993af21eae92e8e362f4b5b3c7c4cb16760ce
CLANDRO_PKG_DEPENDS="libice, libsm, libx11, libxext, xorg-fonts-75dpi | xorg-fonts-100dpi"
CLANDRO_PKG_CONFLICTS="xterm"
CLANDRO_PKG_REPLACES="xterm"
CLANDRO_PKG_PROVIDES="xterm"
CLANDRO_PKG_BUILD_DEPENDS="libxt"
CLANDRO_PKG_BUILD_IN_SRC=true

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--enable-transparency=yes
--enable-background-image
--enable-fading
--enable-menubar
--enable-graphics
"

clandro_step_post_make_install() {
	cat <<- EOF > $CLANDRO_PREFIX/bin/xterm
	#!${CLANDRO_PREFIX}/bin/sh
	exec ${CLANDRO_PREFIX}/bin/aterm +tr "\${@}"
	EOF
	chmod 700 $CLANDRO_PREFIX/bin/xterm
}
