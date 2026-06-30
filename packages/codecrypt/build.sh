CLANDRO_PKG_HOMEPAGE=http://e-x-a.org/codecrypt/
CLANDRO_PKG_DESCRIPTION="The post-quantum cryptography tool"
CLANDRO_PKG_LICENSE="LGPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.8
CLANDRO_PKG_REVISION=10
CLANDRO_PKG_SRCURL=https://github.com/exaexa/codecrypt/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=25f11bc361b4f8aca7245698334b5715b7d594d708a75e8cdb2aa732dc46eb96
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_DEPENDS="cryptopp, fftw, libc++, libgmp"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--with-cryptopp"

clandro_step_pre_configure() {
	./autogen.sh
	export LIBS="-lm"
	export CRYPTOPP_CFLAGS="-I$CLANDRO_PREFIX/include"
	export CRYPTOPP_LIBS="-L$CLANDRO_PREFIX/lib -lcryptopp"
}
