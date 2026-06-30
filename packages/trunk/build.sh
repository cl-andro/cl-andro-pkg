CLANDRO_PKG_HOMEPAGE=https://trunkrs.dev/
CLANDRO_PKG_DESCRIPTION="Build, bundle & ship your Rust WASM application to the web"
CLANDRO_PKG_LICENSE="Apache-2.0, MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.21.14"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/trunk-rs/trunk/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=8687bcf96bdc4decee88458745bbb760ad31dfd109e955cf455c2b64caeeae2f
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="openssl, bzip2"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--no-default-features
--features native-tls
"

clandro_step_pre_configure() {
	clandro_setup_rust
}
