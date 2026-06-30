CLANDRO_PKG_HOMEPAGE=https://github.com/pyca/cryptography
CLANDRO_PKG_DESCRIPTION="Provides cryptographic recipes and primitives to Python developers"
CLANDRO_PKG_LICENSE="Apache-2.0, BSD 3-Clause"
CLANDRO_PKG_LICENSE_FILE="LICENSE, LICENSE.APACHE, LICENSE.BSD"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="48.0.0"
CLANDRO_PKG_SRCURL=https://github.com/pyca/cryptography/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=6afca628a004be66b3793481e02eb22ad4a067a052a6785c3736cc135dc7dc24
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="openssl, python, python-pip"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_PYTHON_COMMON_BUILD_DEPS="wheel"
CLANDRO_PKG_PYTHON_CROSS_BUILD_DEPS="maturin, 'cffi>=1.12'"
CLANDRO_PKG_PYTHON_TARGET_DEPS="'cffi>=1.12'"

clandro_step_configure() {
	clandro_setup_rust
	export CARGO_BUILD_TARGET="${CARGO_TARGET_NAME}"
	export PYO3_CROSS_LIB_DIR="${CLANDRO_PREFIX}/lib"
	export ANDROID_API_LEVEL="${CLANDRO_PKG_API_LEVEL}"
}

clandro_step_make_install() {
	# Needed by maturin
	# Seems to be needed as we are overriding clang binary name.
	# maturin does not ask for this environment variable when using NDK
	export ANDROID_API_LEVEL="$CLANDRO_PKG_API_LEVEL"
	# --no-build-isolation is needed to ensure that maturin is not built for
	# cross-python and picked up for execution instead of maturin built for
	# build-python
	cross-pip install --no-build-isolation --no-deps . --prefix $CLANDRO_PREFIX
}
