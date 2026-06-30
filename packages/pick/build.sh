CLANDRO_PKG_HOMEPAGE=https://github.com/calleerlandsson/pick
CLANDRO_PKG_DESCRIPTION="Utility to choose one option from a set of choices with fuzzy search functionality"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=4.0.0
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=https://github.com/calleerlandsson/pick/releases/download/v${CLANDRO_PKG_VERSION}/pick-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=de768fd566fd4c7f7b630144c8120b779a61a8cd35898f0db42ba8af5131edca
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="ncurses"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	export MANDIR=$CLANDRO_PREFIX/share/man
}
