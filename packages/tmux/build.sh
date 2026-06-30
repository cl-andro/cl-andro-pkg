CLANDRO_PKG_HOMEPAGE=https://tmux.github.io/
CLANDRO_PKG_DESCRIPTION="Terminal multiplexer"
CLANDRO_PKG_LICENSE="ISC"
CLANDRO_PKG_MAINTAINER="Joshua Kahn <tom@termux.dev> & @clandro"
CLANDRO_PKG_VERSION="3.6a"
CLANDRO_PKG_SRCURL=https://github.com/tmux/tmux/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=cd8d97f344cd2faa89e41358428b3ada883e4c72fd7d4f43ccac93daec1442eb
CLANDRO_PKG_AUTO_UPDATE=true
# Link against libandroid-support for wcwidth(), see https://github.com/termux/termux-packages/issues/224
CLANDRO_PKG_DEPENDS="ncurses, libevent, libandroid-support, libandroid-glob"
# Set default TERM to screen-256color, see: https://raw.githubusercontent.com/tmux/tmux/3.3/CHANGES
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--disable-static --with-TERM=screen-256color --enable-sixel"
CLANDRO_PKG_BUILD_IN_SRC=true

CLANDRO_PKG_CONFFILES="etc/tmux.conf etc/profile.d/tmux.sh"

clandro_step_pre_configure() {
	LDFLAGS+=" -landroid-glob"
	./autogen.sh
}

clandro_step_post_make_install() {
	cp "$CLANDRO_PKG_BUILDER_DIR"/tmux.conf "$CLANDRO_PREFIX"/etc/tmux.conf

	mkdir -p "$CLANDRO_PREFIX"/etc/profile.d
	echo "export TMUX_TMPDIR=$CLANDRO_PREFIX/var/run" > "$CLANDRO_PREFIX"/etc/profile.d/tmux.sh

	mkdir -p "$CLANDRO_PREFIX"/share/bash-completion/completions
	clandro_download \
		https://raw.githubusercontent.com/imomaliev/tmux-bash-completion/homebrew_1.0.0/completions/tmux \
		"$CLANDRO_PREFIX"/share/bash-completion/completions/tmux \
		05e79fc1ecb27637dc9d6a52c315b8f207cf010cdcee9928805525076c9020ae
}

clandro_step_post_massage() {
	mkdir -p "${CLANDRO_PKG_MASSAGEDIR}/${CLANDRO_PREFIX}"/var/run
}
