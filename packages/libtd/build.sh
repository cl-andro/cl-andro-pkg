CLANDRO_PKG_HOMEPAGE=https://core.telegram.org/tdlib/
CLANDRO_PKG_DESCRIPTION="Library for building Telegram clients"
CLANDRO_PKG_LICENSE="BSL-1.0"
CLANDRO_PKG_MAINTAINER="@clandro"
# Upstream does not seem to do tagged releases since 1.8.0
CLANDRO_PKG_VERSION=1.8.50
CLANDRO_PKG_REVISION=1
_COMMIT_HASH=e78c346a6b5bf8a2cee97987000e11c8ce9968f3
CLANDRO_PKG_SRCURL=https://github.com/tdlib/td/archive/${_COMMIT_HASH}.tar.gz
CLANDRO_PKG_SHA256=ecb0a303700872dbd4a05707bf2767871386f597dd9af7fe5d81bca40911e520
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_DEPENDS="libc++, readline, openssl (>= 1.1.1), zlib"
CLANDRO_PKG_HOSTBUILD=true

clandro_step_host_build() {
	clandro_setup_cmake
	clandro_setup_ninja
	cmake "-DCMAKE_BUILD_TYPE=Release" "$CLANDRO_PKG_SRCDIR" -G"Ninja"
	cmake --build . --target prepare_cross_compiling
}

clandro_step_post_make_install() {
	# Fix rebuilds without ./clean.sh.
	rm -rf $CLANDRO_PKG_HOSTBUILD_DIR
}
