CLANDRO_PKG_HOMEPAGE=https://typst.app/
CLANDRO_PKG_DESCRIPTION="A new markup-based typesetting system that is powerful and easy to learn"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.14.2"
CLANDRO_PKG_SRCURL="https://github.com/typst/typst/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=70a56445020ca05efc571c7b07a1a9f52eb93842d420518693c077ae74e54142
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
CLANDRO_PKG_DEPENDS="openssl"

clandro_step_pre_configure() {
	clandro_setup_rust

	: "${CARGO_HOME:=$HOME/.cargo}"
	export CARGO_HOME

	cargo vendor

	echo "" >> Cargo.toml
	echo '[patch.crates-io]' >> Cargo.toml
	echo 'time = { path = "./vendor/time" }' >> Cargo.toml
}

clandro_step_make() {
	clandro_setup_rust

	export GEN_ARTIFACTS=artifacts
	export OPENSSL_NO_VENDOR=1
	cargo build --jobs $CLANDRO_PKG_MAKE_PROCESSES -p typst-cli --target $CARGO_TARGET_NAME --release
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin target/${CARGO_TARGET_NAME}/release/typst

	local _artifacts="crates/typst-cli/artifacts"
	install -Dm644 -t "${CLANDRO_PREFIX}/share/man/man1/" "${_artifacts}/${CLANDRO_PKG_NAME}"*.1
	install -Dm644 -t "${CLANDRO_PREFIX}/share/zsh/site-functions/" "${_artifacts}/_${CLANDRO_PKG_NAME}"
	install -Dm644 -t "${CLANDRO_PREFIX}/share/fish/vendor_completions.d/" "${_artifacts}/${CLANDRO_PKG_NAME}.fish"
	install -Dm644 "${_artifacts}/${CLANDRO_PKG_NAME}.bash" "${CLANDRO_PREFIX}/share/bash-completion/completions/${CLANDRO_PKG_NAME}"
}

clandro_step_post_make_install() {
	# Remove the vendor sources to save space
	rm -rf "$CLANDRO_PKG_SRCDIR"/vendor
}
