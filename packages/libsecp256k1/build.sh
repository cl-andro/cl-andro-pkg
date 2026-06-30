CLANDRO_PKG_HOMEPAGE=https://github.com/bitcoin-core/secp256k1
CLANDRO_PKG_DESCRIPTION="Optimized c library for ECDSA signatures and seret/public key operations on curve secp256k1"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1:0.7.1"
CLANDRO_PKG_SRCURL=https://github.com/bitcoin-core/secp256k1/archive/refs/tags/v${CLANDRO_PKG_VERSION#*:}.tar.gz
CLANDRO_PKG_SHA256=958f204dbafc117e73a2604285dc2eb2a5128344d3499c114dcba5de54cb7a9e
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

# These flags are suggested by electrum
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--enable-module-recovery
--enable-experimental
--enable-module-ecdh
"

clandro_step_pre_configure() {
	autoreconf -vfi
}
