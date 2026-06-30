CLANDRO_PKG_HOMEPAGE=https://github.com/sharkdp/bat
CLANDRO_PKG_DESCRIPTION="A cat(1) clone with wings"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.26.1"
CLANDRO_PKG_SRCURL=https://github.com/sharkdp/bat/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=4474de87e084953eefc1120cf905a79f72bbbf85091e30cf37c9214eafcaa9c9
CLANDRO_PKG_AUTO_UPDATE=true
# bat calls less with '--RAW-CONTROL-CHARS' which busybox less does not support:
CLANDRO_PKG_DEPENDS="less, libgit2"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	export CFLAGS_"${CARGO_TARGET_NAME//-/_}"+=" -Dindex=strchr"

	# See https://github.com/nagisa/rust_libloading/issues/54
	export CC_x86_64_unknown_linux_gnu=gcc
	export CFLAGS_x86_64_unknown_linux_gnu=""

	clandro_setup_rust

	: "${CARGO_HOME:=$HOME/.cargo}"
	export CARGO_HOME

	cargo fetch --target "${CARGO_TARGET_NAME}"

	local f
	for f in "$CARGO_HOME"/registry/src/*/libgit2-sys-*/build.rs; do
		sed -i -E 's/\.range_version\(([^)]*)\.\.[^)]*\)/.atleast_version(\1)/g' "${f}"
	done
}

clandro_step_post_make_install() {
	find . -name bat.1 -type f -exec install -Dm644 {} "$CLANDRO_PREFIX/share/man/man1/bat.1" \;
	find . -name bat.bash -type f -exec install -Dm644 {} "$CLANDRO_PREFIX/share/bash-completion/completions/bat" \;
	find . -name bat.zsh -type f -exec install -Dm644 {} "$CLANDRO_PREFIX/share/zsh/site-functions/_bat" \;
	find . -name bat.fish -type f -exec install -Dm644 {} "$CLANDRO_PREFIX/share/fish/vendor_completions.d/bat.fish" \;
}
