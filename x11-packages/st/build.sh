CLANDRO_PKG_HOMEPAGE=https://st.suckless.org/
CLANDRO_PKG_DESCRIPTION="A simple virtual terminal emulator for X"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.9.3"
CLANDRO_PKG_SRCURL="https://dl.suckless.org/st/st-$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=9ed9feabcded713d4ded38c8cebf36a3b08f0042ef7934a0e2b2409da56e649b
CLANDRO_PKG_AUTO_UPDATE=true
# FIXME: config.h specified a Liberation Mono font which is not available in Termux.
# Needs a patch for ttf-dejavu font package or liberation font package should be added.
CLANDRO_PKG_DEPENDS="fontconfig, freetype, libx11, libxft"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_MAKE_ARGS="TERMINFO=$CLANDRO_PREFIX/share/terminfo"
CLANDRO_PKG_RM_AFTER_INSTALL="share/terminfo"

clandro_step_pre_configure() {
	cp config.def.h config.h
}
