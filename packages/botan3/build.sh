CLANDRO_PKG_HOMEPAGE=https://botan.randombit.net/
CLANDRO_PKG_DESCRIPTION="Crypto and TLS for Modern C++"
CLANDRO_PKG_LICENSE="BSD 2-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
# This specific package is for libbotan-3.
CLANDRO_PKG_VERSION="3.10.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://botan.randombit.net/releases/Botan-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=fde194236f6d5434f136ea0a0627f6cc9d26af8b96e9f1e1c7d8c82cd90f4f24
CLANDRO_PKG_DEPENDS="libbz2, libc++, liblzma, libsqlite, zlib"
CLANDRO_PKG_BUILD_DEPENDS="boost, boost-headers"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--cpu=$CLANDRO_ARCH
--os=android
--no-install-python-module
--without-documentation
--with-boost
--with-bzip2
--with-lzma
--with-sqlite3
--with-zlib
--prefix=$CLANDRO_PREFIX
--program-suffix=$(echo ${CLANDRO_PKG_VERSION#*:} | cut -d . -f 1)
"

clandro_step_pre_configure() {
	CXXFLAGS+=" $CPPFLAGS"
}

clandro_step_configure() {
	python3 $CLANDRO_PKG_SRCDIR/configure.py \
		$CLANDRO_PKG_EXTRA_CONFIGURE_ARGS
}

clandro_step_post_massage() {
	local _GUARD_FILE="lib/libbotan-3.so"
	if [ ! -e "${_GUARD_FILE}" ]; then
		clandro_error_exit "file ${_GUARD_FILE} not found."
	fi
}
