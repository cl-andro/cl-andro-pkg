CLANDRO_PKG_HOMEPAGE=https://www.borgbackup.org/
CLANDRO_PKG_DESCRIPTION="Deduplicating and compressing backup program"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="Joshua Kahn <tom@termux.dev> & @clandro"
CLANDRO_PKG_VERSION="1.4.4"
CLANDRO_PKG_SRCURL=https://github.com/borgbackup/borg/releases/download/${CLANDRO_PKG_VERSION}/borgbackup-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=2716bc124a24908efcac9436df31b716d1f0bbd828ad39b18f73bfdd772a651a
CLANDRO_PKG_DEPENDS="libacl, liblz4, openssl, python, python-pip, xxhash, zstd"
CLANDRO_PKG_PYTHON_COMMON_BUILD_DEPS="build, Cython, pkgconfig, setuptools, setuptools-scm, wheel"
CLANDRO_PKG_PYTHON_TARGET_DEPS="'msgpack==1.0.8', packaging"
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make_install() {
	cross-pip install --no-deps --prefix="$CLANDRO_PREFIX" "$CLANDRO_PKG_SRCDIR"
}

clandro_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$CLANDRO_PREFIX/bin/sh
	echo "Installing dependencies through pip..."
	pip3 install $CLANDRO_PKG_PYTHON_TARGET_DEPS
	EOF
}
