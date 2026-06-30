CLANDRO_PKG_HOMEPAGE=https://gnunet.org
CLANDRO_PKG_DESCRIPTION="A framework for secure peer-to-peer networking"
CLANDRO_PKG_LICENSE="AGPL-V3"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.27.0"
CLANDRO_PKG_SRCURL=https://ftpmirror.gnu.org/gnu/gnunet/gnunet-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=9dd8feb3f3b8d0993766a49ab618f80bb93017f3bc795b6dda84697397302a07
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libcurl, libgcrypt, libgnutls, libgpg-error, libidn2, libjansson, libltdl, libmicrohttpd, libsodium, libsqlite, libunistring, zlib"

clandro_step_pre_configure() {
	CPPFLAGS+=" -D_LINUX_IN6_H"
	./bootstrap meson
	rm -f $CLANDRO_PKG_SRCDIR/configure
}
