CLANDRO_PKG_HOMEPAGE=https://practical-scheme.net/gauche/
CLANDRO_PKG_DESCRIPTION="An R7RS Scheme implementation developed to be a handy script interpreter"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.9.15"
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL="https://github.com/shirok/Gauche/releases/download/release${CLANDRO_PKG_VERSION//./_}/Gauche-${CLANDRO_PKG_VERSION}.tgz"
CLANDRO_PKG_SHA256=3643e27bc7c8822cfd6fb2892db185f658e8e364938bc2ccfcedb239e35af783
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_DEPENDS="gdbm, libcrypt, libiconv, mbedtls, zlib"
CLANDRO_PKG_BUILD_DEPENDS="libatomic-ops"
CLANDRO_PKG_RECOMMENDS="llvm, ca-certificates"
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_BUILD_IN_SRC=true

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--with-ca-bundle=$CLANDRO_PREFIX/etc/tls/cert.pem
--with-slib=$CLANDRO_PREFIX/share/slib
"
# As of 0.9.10 some code hangs with threads enabled, e.g.
# ```
# (use rfc.uri)
# (uri-decode-string "")
# ```
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" --enable-threads=none"

clandro_step_host_build() {
	local _PREFIX_FOR_BUILD=$CLANDRO_PKG_HOSTBUILD_DIR/prefix
	mkdir -p $_PREFIX_FOR_BUILD

	find "$CLANDRO_PKG_SRCDIR" -mindepth 1 -maxdepth 1 ! -name build_gosh -exec cp -a \{\} ./ \;
	./configure --prefix=$_PREFIX_FOR_BUILD
	make -j $CLANDRO_PKG_MAKE_PROCESSES
	make install
}

clandro_step_pre_configure() {
	local _PREFIX_FOR_BUILD=$CLANDRO_PKG_HOSTBUILD_DIR/prefix

	cp $CLANDRO_PKG_BUILDER_DIR/fake-ndbm-makedb.c "$CLANDRO_PKG_SRCDIR"/ext/dbm/

	export BUILD_GOSH=$_PREFIX_FOR_BUILD/bin/gosh
	export PATH=$PATH:$_PREFIX_FOR_BUILD/bin

	autoreconf -fi
}
