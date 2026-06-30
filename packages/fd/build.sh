CLANDRO_PKG_HOMEPAGE=https://github.com/sharkdp/fd
CLANDRO_PKG_DESCRIPTION="Simple, fast and user-friendly alternative to find"
CLANDRO_PKG_LICENSE="Apache-2.0,MIT"
CLANDRO_PKG_LICENSE_FILE="LICENSE-APACHE,LICENSE-MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="10.4.2"
CLANDRO_PKG_SRCURL=https://github.com/sharkdp/fd/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=3a7e027af8c8e91c196ac259c703d78cd55c364706ddafbc66d02c326e57a456
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make() {
	clandro_setup_rust
	cargo build --jobs "$CLANDRO_PKG_MAKE_PROCESSES" --target "$CARGO_TARGET_NAME" --release
}

clandro_step_make_install() {
	install -Dm700 -t "$CLANDRO_PREFIX/bin" "target/${CARGO_TARGET_NAME}/release/fd"

	# Manpages.
	install -Dm600 doc/"${CLANDRO_PKG_NAME}".1 \
		"${CLANDRO_PREFIX}"/share/man/man1/"${CLANDRO_PKG_NAME}".1

	# Shell completions
	mkdir -p "${CLANDRO_PREFIX}/share/zsh/site-functions"
	mkdir -p "${CLANDRO_PREFIX}/share/bash-completion/completions"
	mkdir -p "${CLANDRO_PREFIX}/share/fish/vendor_completions.d"
	mkdir -p "${CLANDRO_PREFIX}/share/elvish/lib"
	(
		unset CC CXX CFLAGS CXXFLAGS CPPFLAGS LDFLAGS AR AS CPP LD RANLIB READELF STRIP
		cargo run -- --gen-completions     zsh > "${CLANDRO_PREFIX}/share/zsh/site-functions/_${CLANDRO_PKG_NAME}"
		cargo run -- --gen-completions    bash > "${CLANDRO_PREFIX}/share/bash-completion/completions/${CLANDRO_PKG_NAME}"
		cargo run -- --gen-completions    fish > "${CLANDRO_PREFIX}/share/fish/vendor_completions.d/${CLANDRO_PKG_NAME}.fish"
		cargo run -- --gen-completions  elvish > "${CLANDRO_PREFIX}/share/elvish/lib/${CLANDRO_PKG_NAME}.elv"
	)
}
