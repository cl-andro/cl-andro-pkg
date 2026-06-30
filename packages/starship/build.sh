CLANDRO_PKG_HOMEPAGE=https://starship.rs
CLANDRO_PKG_DESCRIPTION="A minimal, blazing fast, and extremely customizable prompt for any shell"
CLANDRO_PKG_LICENSE="ISC"
CLANDRO_PKG_MAINTAINER="Joshua Kahn <tom@termux.dev> & @clandro"
CLANDRO_PKG_VERSION="1.25.1"
CLANDRO_PKG_SRCURL=https://github.com/starship/starship/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=521306b14066ee7e332d998ef5b5b6455fdc6085c52e86b6316a7cdc37bae1d8
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_DEPENDS="zlib"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--all-features"
CLANDRO_PKG_SUGGESTS="nerdfix, taplo"

clandro_step_pre_configure() {
	clandro_setup_rust
	cargo vendor
	find ./vendor \
		-mindepth 1 -maxdepth 1 -type d \
		! -wholename ./vendor/systemstat \
		-exec rm -rf '{}' \;

	local patch="$CLANDRO_PKG_BUILDER_DIR/systemstat-android-is-linux.diff"
	echo "Applying patch: $patch"
	patch -p1 < "$patch"

	echo "" >> Cargo.toml
	echo '[patch.crates-io]' >> Cargo.toml
	echo "systemstat = { path = \"./vendor/systemstat\" }" >> Cargo.toml

	clandro_setup_cmake
	: "${CARGO_HOME:=${HOME}/.cargo}"
	export CARGO_HOME

	rm -rf "$CARGO_HOME"/registry/src/*/cmake-*
	cargo fetch --target "${CARGO_TARGET_NAME}"

	local _CARGO_TARGET_LIBDIR="target/${CARGO_TARGET_NAME}/release/deps"
	mkdir -p "${_CARGO_TARGET_LIBDIR}"

	local -u env_host="${CARGO_TARGET_NAME//-/_}"
	export CARGO_TARGET_"${env_host}"_RUSTFLAGS+=" -C link-arg=$($CC -print-libgcc-file-name)"
}

clandro_step_post_make_install() {
	# shell completions
	mkdir -p "${CLANDRO_PREFIX}/share/zsh/site-functions"
	mkdir -p "${CLANDRO_PREFIX}/share/bash-completion/completions"
	mkdir -p "${CLANDRO_PREFIX}/share/fish/vendor_completions.d"
	mkdir -p "${CLANDRO_PREFIX}/share/elvish/lib"
	mkdir -p "${CLANDRO_PREFIX}/share/nushell/vendor/autoload"
	cargo run -- completions     zsh > "${CLANDRO_PREFIX}/share/zsh/site-functions/_${CLANDRO_PKG_NAME}"
	cargo run -- completions    bash > "${CLANDRO_PREFIX}/share/bash-completion/completions/${CLANDRO_PKG_NAME}"
	cargo run -- completions    fish > "${CLANDRO_PREFIX}/share/fish/vendor_completions.d/${CLANDRO_PKG_NAME}.fish"
	cargo run -- completions  elvish > "${CLANDRO_PREFIX}/share/elvish/lib/${CLANDRO_PKG_NAME}.elv"
	cargo run -- completions nushell > "${CLANDRO_PREFIX}/share/nushell/vendor/autoload/${CLANDRO_PKG_NAME}.nu"
}
