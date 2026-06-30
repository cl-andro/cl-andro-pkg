CLANDRO_PKG_HOMEPAGE="https://libntl.org"
CLANDRO_PKG_DESCRIPTION="A Library for doing Number Theory"
CLANDRO_PKG_GROUPS="science"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_LICENSE_FILE="doc/copying.txt"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="11.5.1"
CLANDRO_PKG_REVISION="1"
CLANDRO_PKG_SRCURL="https://libntl.org/ntl-$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=210d06c31306cbc6eaf6814453c56c776d9d8e8df36d74eb306f6a523d1c6a8a
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_BUILD_DEPENDS="perl"
CLANDRO_PKG_DEPENDS="libgf2x, libgmp"

clandro_step_configure() {
	cd src

	case "$CLANDRO_ARCH" in
		x86_64 | i686 )
			tune="x86";;
		* )
			tune="generic";;
	esac

	./configure \
		PREFIX=$CLANDRO_PREFIX\
		NATIVE=off \
		TUNE="$tune" \
		NTL_GMP_LIP=on \
		NTL_GF2X_LIB=off
}

clandro_step_make() {
	cd src
	make
}

clandro_step_make_install() {
	cd src
	make install
}
