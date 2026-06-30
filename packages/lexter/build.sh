CLANDRO_PKG_HOMEPAGE=https://www.kyne.au/~mark/software/lexter.php
CLANDRO_PKG_DESCRIPTION="A real-time word puzzle for text terminals"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="Henrik Grimler @Grimler91"
CLANDRO_PKG_VERSION="1.0.3"
CLANDRO_PKG_REVISION=5
CLANDRO_PKG_SRCURL=https://www.kyne.au/~mark/software/download/lexter-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=b61a28fd5249b7d6c0df9be91c97c2acd00ccd9ad1e7b0c99808f6cdc96d5188
CLANDRO_PKG_DEPENDS="gettext, ncurses"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--datadir=$CLANDRO_PREFIX/share/lexter"
CLANDRO_PKG_GROUPS="games"

clandro_step_pre_configure() {
	autoreconf -vfi
}
