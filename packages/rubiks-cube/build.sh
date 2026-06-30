CLANDRO_PKG_HOMEPAGE=https://github.com/been-jamming/rubiks_cube
CLANDRO_PKG_DESCRIPTION="A rubik's cube that runs in your terminal"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.2
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=git+https://github.com/been-jamming/rubiks_cube
CLANDRO_PKG_DEPENDS="ncurses"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_GROUPS="games"

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin rubiks_cube
}
