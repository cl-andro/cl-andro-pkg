CLANDRO_PKG_HOMEPAGE=https://sheldon.cli.rs/
CLANDRO_PKG_DESCRIPTION="Fast, configurable, shell plugin manager"
CLANDRO_PKG_LICENSE="MIT, Apache-2.0"
CLANDRO_PKG_LICENSE_FILE="LICENSE-MIT, LICENSE-APACHE"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.8.5"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/rossmacarthur/sheldon/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=a32e181667ec8bf235f0c50f2671d3c0d78fbdd7502a61e2f88c7deacb534b20
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libcurl, libssh2, openssl, zlib"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	export LIBSSH2_SYS_USE_PKG_CONFIG=1
}

clandro_step_make() {
	clandro_setup_rust
	cargo build --jobs $CLANDRO_PKG_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

clandro_step_make_install() {
	install -Dm755 -t "${CLANDRO_PREFIX}"/bin target/${CARGO_TARGET_NAME}/release/sheldon

	# completions
	install -Dm644 completions/sheldon.bash "${CLANDRO_PREFIX}/share/bash-completion/completions/sheldon"
	install -Dm644 completions/sheldon.zsh "${CLANDRO_PREFIX}/share/zsh/site-functions/_sheldon"
}
