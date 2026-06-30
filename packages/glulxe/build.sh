CLANDRO_PKG_HOMEPAGE=https://www.eblong.com/zarf/glulx/
CLANDRO_PKG_DESCRIPTION="Interpreter for the Glulx portable VM for interactive fiction (IF) games"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=(0.6.1
                    1.0.4)
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=(https://www.eblong.com/zarf/glulx/glulxe-${CLANDRO_PKG_VERSION[0]//.}.tar.gz
                   https://www.eblong.com/zarf/glk/glktermw-${CLANDRO_PKG_VERSION[1]//.}.tar.gz)
CLANDRO_PKG_SHA256=(f81dc474d60d7d914fcde45844a4e1acafee50e13aebfcb563249cc56740769f
                   5968630b45e2fd53de48424559e3579db0537c460f4dc2631f258e1c116eb4ea)
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_DEPENDS="ncurses"
CLANDRO_PKG_GROUPS="games"

clandro_step_post_configure () {
	CC="$CC $CFLAGS $CPPFLAGS $LDFLAGS" PREFIX=$CLANDRO_PREFIX make -C glkterm
}

clandro_step_make_install () {
	install glulxe $CLANDRO_PREFIX/bin
}
