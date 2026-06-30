CLANDRO_PKG_HOMEPAGE="https://mierak.github.io/rmpc/"
CLANDRO_PKG_DESCRIPTION="A configurable TUI MPD client with album art support"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.11.0"
CLANDRO_PKG_SRCURL="https://github.com/mierak/rmpc/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=930019066228d18e9530a8c0d77f10e231ab5efbbbca73b331efcd6fbb47557d
CLANDRO_PKG_SUGGESTS="cava, ffmpeg, python-yt-dlp"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make() {
	clandro_setup_rust
	cargo build --jobs $CLANDRO_PKG_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release --locked
}

clandro_step_make_install() {
	install -Dm755 -t $CLANDRO_PREFIX/bin target/${CARGO_TARGET_NAME}/release/rmpc

	install -Dm 644 "target/completions/rmpc.bash" -t "$CLANDRO_PREFIX/share/bash-completion/completions/"
	install -Dm 644 "target/completions/rmpc.fish" -t "$CLANDRO_PREFIX/share/fish/vendor_completions.d/"
	install -Dm 644 "target/completions/_rmpc" -t "$CLANDRO_PREFIX/share/zsh/site-functions/"
	install -Dm 644 "target/man/rmpc.1" "$CLANDRO_PREFIX/share/man/man1/rmpc.1"
}
