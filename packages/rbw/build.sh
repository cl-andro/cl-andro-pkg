CLANDRO_PKG_HOMEPAGE=https://github.com/doy/rbw
CLANDRO_PKG_DESCRIPTION="An unofficial command line client for Bitwarden"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.15.0"
CLANDRO_PKG_SRCURL=https://github.com/doy/rbw/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=660cfa4c727711665bef060046c28dd3924ca1e490fdc058d90d35372b2d2cf6
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="pinentry"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make() {
	clandro_setup_rust

	cargo build \
		--jobs "$CLANDRO_PKG_MAKE_PROCESSES" \
		--target "$CARGO_TARGET_NAME" \
		--no-default-features \
		--release
}

clandro_step_make_install() {
	install -Dm755 -t $CLANDRO_PREFIX/bin $CLANDRO_PKG_SRCDIR/target/${CARGO_TARGET_NAME}/release/rbw
	install -Dm755 -t $CLANDRO_PREFIX/bin $CLANDRO_PKG_SRCDIR/target/${CARGO_TARGET_NAME}/release/rbw-agent

	install -Dm644 /dev/null "${CLANDRO_PREFIX}/share/bash-completion/completions/rbw.bash"
	install -Dm644 /dev/null "${CLANDRO_PREFIX}/share/zsh/site-functions/_rbw"
	install -Dm644 /dev/null "${CLANDRO_PREFIX}/share/fish/vendor_completions.d/rbw.fish"
	install -Dm644 /dev/null "${CLANDRO_PREFIX}/share/elvish/lib/rbw.elv"
}

clandro_step_create_debscripts() {
	cat <<-EOF >./postinst
		#!${CLANDRO_PREFIX}/bin/sh
		rbw gen-completions bash > ${CLANDRO_PREFIX}/share/bash-completion/completions/rbw.bash
		rbw gen-completions zsh > ${CLANDRO_PREFIX}/share/zsh/site-functions/_rbw
		rbw gen-completions fish > ${CLANDRO_PREFIX}/share/fish/vendor_completions.d/rbw.fish
		rbw gen-completions elvish > ${CLANDRO_PREFIX}/share/elvish/lib/rbw.elv
	EOF
}
