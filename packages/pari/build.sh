CLANDRO_PKG_HOMEPAGE=https://pari.math.u-bordeaux.fr/
CLANDRO_PKG_DESCRIPTION="A computer algebra system designed for fast computations in number theory"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.17.3"
CLANDRO_PKG_SRCURL=https://pari.math.u-bordeaux.fr/pub/pari/unix/pari-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=8d9c4fcd584c468d27e0f23c36836587284452094c4b1c404c20c4b810462dcb
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="gzip, libgmp, readline"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--with-gmp=$CLANDRO_PREFIX
--with-readline=$CLANDRO_PREFIX
"

clandro_step_pre_configure() {
	LD="$CC"
	case $CLANDRO_ARCH_BITS in
		32) PARI_DOUBLE_FORMAT=1 ;;
		64) PARI_DOUBLE_FORMAT=- ;;
	esac
	export PARI_DOUBLE_FORMAT
}

clandro_step_configure() {
	./Configure --prefix=$CLANDRO_PREFIX --host=$CLANDRO_HOST_PLATFORM \
		$CLANDRO_PKG_EXTRA_CONFIGURE_ARGS
	CLANDRO_PKG_EXTRA_MAKE_ARGS="-C $(echo O*)"
}
