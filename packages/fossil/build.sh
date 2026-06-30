CLANDRO_PKG_HOMEPAGE=https://www.fossil-scm.org
CLANDRO_PKG_DESCRIPTION="DSCM with built-in wiki, http interface and server, tickets database"
CLANDRO_PKG_LICENSE="BSD 2-Clause"
CLANDRO_PKG_LICENSE_FILE="COPYRIGHT-BSD2.txt"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.28"
CLANDRO_PKG_SRCURL=https://www.fossil-scm.org/home/tarball/version-$CLANDRO_PKG_VERSION/fossil-src-$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=84c18824ca227e7602d2408b663c3747f754ad306ed5c73ddab959d6589538a6
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="openssl, zlib"

clandro_step_pre_configure() {
	# Avoid mixup of flags between cross compilation
	# and native build.
	CC="$CC $CPPFLAGS $CFLAGS $LDFLAGS"
	unset CFLAGS LDFLAGS
}

clandro_step_configure() {
	# DO NOT add --disable-internal-sqlite, otherwise fossil panics >_<
	$CLANDRO_PKG_SRCDIR/configure \
		--prefix=$CLANDRO_PREFIX \
		--host=$CLANDRO_HOST_PLATFORM \
		--json \
		--with-openssl=$CLANDRO_PREFIX \
		--with-zlib=$CLANDRO_PREFIX
}
