CLANDRO_PKG_HOMEPAGE=https://github.com/ducaale/xh
CLANDRO_PKG_DESCRIPTION="A friendly and fast tool for sending HTTP requests"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.25.3"
CLANDRO_PKG_SRCURL=https://github.com/ducaale/xh/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=ba331c33dc5d222f43cc6ad9f602002817772fd52ae28541976db49f34935ae3
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	clandro_setup_rust

	# clash with rust host build
	unset CFLAGS
}

clandro_step_make() {
	cargo build --jobs $CLANDRO_PKG_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin target/${CARGO_TARGET_NAME}/release/xh
	ln -sf $CLANDRO_PREFIX/bin/xh{,s}

	install -Dm600 doc/xh.1 "${CLANDRO_PREFIX}"/share/man/man1/xh.1
	install -Dm644 completions/xh.bash "${CLANDRO_PREFIX}"/share/bash-completion/completions/xh.bash
	install -Dm644 completions/_xh "${CLANDRO_PREFIX}"/share/zsh/site-functions/_xh
	install -Dm644 completions/xh.fish "${CLANDRO_PREFIX}"/share/fish/vendor_completions.d/xh.fish
}
