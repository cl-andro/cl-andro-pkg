CLANDRO_PKG_HOMEPAGE=https://github.com/aeolwyr/tergent
CLANDRO_PKG_DESCRIPTION="A cryptoki/PKCS#11 library for Termux that uses Android Keystore as its backend"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.0.0
CLANDRO_PKG_REVISION=5
# Build from specific revision until patches are merged upstream, or
# we decide to maintain a fork
_COMMIT=831e300e3d75a9618963bbefbaad49bf37e2cf3c
CLANDRO_PKG_SRCURL=https://github.com/termux/tergent/archive/${_COMMIT}.tar.gz
CLANDRO_PKG_SHA256=8979504a0e705fca35a6ae81ba1665c5bafebe218008ee50b6dc4f8a8d611cec
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_DEPENDS="clandro-api"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	clandro_setup_rust
}

clandro_step_make() {
	local BUILD_TYPE=
	if [ $CLANDRO_DEBUG_BUILD = false ]; then
		BUILD_TYPE=--release
	fi

	cargo build --jobs $CLANDRO_PKG_MAKE_PROCESSES \
		--target $CARGO_TARGET_NAME ${BUILD_TYPE}
}

clandro_step_make_install() {
	local BUILD_TYPE=release
	if [ $CLANDRO_DEBUG_BUILD = true ]; then
		BUILD_TYPE=debug
	fi
	install -Dm600 -t $CLANDRO_PREFIX/lib \
		target/${CARGO_TARGET_NAME}/${BUILD_TYPE}/libtergent.so
}
