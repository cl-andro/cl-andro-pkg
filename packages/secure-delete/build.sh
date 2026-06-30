CLANDRO_PKG_HOMEPAGE=https://www.thc.org/
CLANDRO_PKG_DESCRIPTION="Secure file, disk, swap, memory erasure utilities"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=3.1
CLANDRO_PKG_REVISION=6
CLANDRO_PKG_SRCURL=http://deb.debian.org/debian/pool/main/s/secure-delete/secure-delete_$CLANDRO_PKG_VERSION.orig.tar.gz
CLANDRO_PKG_SHA256=78af201401e6dc159298cb5430c28996a8bdc278391d942d1fe454534540ee3c
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make() {
	make -j1 CC="$CC"
}

clandro_step_make_install() {
	make install INSTALL_DIR="$CLANDRO_PREFIX/bin"
	install -Dm600 -t "$CLANDRO_PREFIX"/share/man/man1 sfill.1 smem.1 srm.1 sswap.1
}
