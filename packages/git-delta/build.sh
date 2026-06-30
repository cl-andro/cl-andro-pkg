CLANDRO_PKG_HOMEPAGE="https://dandavison.github.io/delta/"
CLANDRO_PKG_DESCRIPTION="A syntax-highlighter for git and diff output"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="Joshua Kahn <tom@termux.dev> & @clandro"
CLANDRO_PKG_VERSION="0.19.2"
CLANDRO_PKG_SRCURL=https://github.com/dandavison/delta/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=f59b86f8c8dda4d76a3ba34b8553777a20c3b461646917d8e480fac6531bba9f
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="git, libgit2, oniguruma"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	export LIBGIT2_SYS_USE_PKG_CONFIG=1
	export RUSTONIG_SYSTEM_LIBONIG=1

	rm -f Makefile release.Makefile
	export CC_x86_64_unknown_linux_gnu=gcc
	export CFLAGS_x86_64_unknown_linux_gnu="-O2"

	local _ORIG_CFLAGS="$CFLAGS"
	clandro_setup_rust
	export CFLAGS="$_ORIG_CFLAGS"

	: "${CARGO_HOME:=$HOME/.cargo}"
	export CARGO_HOME

	cargo fetch --target "${CARGO_TARGET_NAME}"

	local f
	for f in "$CARGO_HOME"/registry/src/*/libgit2-sys-*/build.rs; do
		sed -i -E 's/\.range_version\(([^)]*)\.\.[^)]*\)/.atleast_version(\1)/g' "${f}"
	done
}

clandro_step_post_make_install() {
	install -Dm700 -t "$CLANDRO_PREFIX"/bin \
		"$CLANDRO_PKG_SRCDIR/target/$CARGO_TARGET_NAME"/release/delta

	install -Dm644 /dev/null "$CLANDRO_PREFIX"/share/bash-completion/completions/delta
	install -Dm644 /dev/null "$CLANDRO_PREFIX"/share/zsh/site-functions/_delta
	install -Dm644 /dev/null "$CLANDRO_PREFIX"/share/fish/vendor_completions.d/delta.fish
}

clandro_step_create_debscripts() {
	cat <<-EOF >./postinst
		#!${CLANDRO_PREFIX}/bin/sh
		delta --generate-completion bash > ${CLANDRO_PREFIX}/share/bash-completion/completions/delta
		delta --generate-completion zsh > ${CLANDRO_PREFIX}/share/zsh/site-functions/_delta
		delta --generate-completion fish > ${CLANDRO_PREFIX}/share/fish/vendor_completions.d/delta.fish
	EOF
}
