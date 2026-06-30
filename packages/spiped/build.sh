CLANDRO_PKG_HOMEPAGE=https://www.tarsnap.com/spiped.html
CLANDRO_PKG_DESCRIPTION="a utility for creating symmetrically encrypted and authenticated pipes between socket addresses"
CLANDRO_PKG_LICENSE="BSD 2-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.6.4"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/Tarsnap/spiped/archive/refs/tags/$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=e094d8a3408e0689936be00743d1a9818b5d7a9faf6a34fcb44388a40c92bf05
CLANDRO_PKG_DEPENDS="openssl"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"

clandro_step_pre_configure() {
	if [[ "${CLANDRO_ARCH}" == "arm" ]]; then
		# armv8 specific features check also enables them for armv7. But why?
		patch -p1 --silent <"${CLANDRO_PKG_BUILDER_DIR}"/disable_armv8_specific_features.diff
	fi
}

clandro_step_make() {
	CFLAGS+=" $CPPFLAGS"
	env LDADD_EXTRA="$LDFLAGS" \
		make -j "$CLANDRO_PKG_MAKE_PROCESSES" BINDIR="$CLANDRO_PREFIX/bin" \
		MAN1DIR="$CLANDRO_PREFIX/share/man/man1"
}

clandro_step_make_install() {
	make install BINDIR="$CLANDRO_PREFIX/bin" \
		MAN1DIR="$CLANDRO_PREFIX/share/man/man1"
}
