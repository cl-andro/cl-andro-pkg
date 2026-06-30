CLANDRO_PKG_HOMEPAGE=https://github.com/pyca/bcrypt
CLANDRO_PKG_DESCRIPTION="Acceptable password hashing for your software and your servers"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="5.0.0"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://pypi.io/packages/source/b/bcrypt/bcrypt-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=f748f7c2d6fd375cc93d3fba7ef4a9e3a092421b8dbf34d8d4dc06be9492dfdd
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="python, python-pip"
CLANDRO_PKG_BUILD_DEPENDS="openssl"
CLANDRO_PKG_PYTHON_COMMON_BUILD_DEPS="wheel, setuptools-rust"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	clandro_setup_rust
}

clandro_step_post_configure() {
	export CARGO_BUILD_TARGET=${CARGO_TARGET_NAME}
	export PYO3_CROSS_LIB_DIR=$CLANDRO_PREFIX/lib
}
