CLANDRO_PKG_HOMEPAGE=https://github.com/lycheeverse/lychee
CLANDRO_PKG_DESCRIPTION="A fast, async, resource-friendly link checker written in Rust"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_LICENSE_FILE="LICENSE-MIT, LICENSE-APACHE"
CLANDRO_PKG_MAINTAINER="Yaksh Bariya <thunder-coding@termux.dev> & @clandro"
CLANDRO_PKG_VERSION="0.24.2"
CLANDRO_PKG_SRCURL=https://github.com/lycheeverse/lychee/archive/refs/tags/lychee-v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=62687c0a84ceec76d17e30e494dcf8e65c7099a2e24a6a521a41854b8eb3759d
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="openssl, resolv-conf"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="lychee-v\d+\.\d+\.\d+"

clandro_step_pre_configure() {
	clandro_setup_rust

	: "${CARGO_HOME:=$HOME/.cargo}"
	export CARGO_HOME

	cargo fetch --target "${CARGO_TARGET_NAME}"

	for d in $CARGO_HOME/registry/src/*/trust-dns-resolver-*; do
		sed -e "s|@CLANDRO_PREFIX@|$CLANDRO_PREFIX|" \
			$CLANDRO_PKG_BUILDER_DIR/trust-dns-resolver.diff \
			| patch --silent -p1 -d ${d} || :
	done
}

clandro_step_make() {
	cargo build --jobs $CLANDRO_PKG_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

clandro_step_make_install() {
	install -Dm755 -t $CLANDRO_PREFIX/bin target/${CARGO_TARGET_NAME}/release/lychee
}
