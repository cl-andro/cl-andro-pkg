CLANDRO_PKG_HOMEPAGE=https://www.musicpd.org/clients/mpc/
CLANDRO_PKG_DESCRIPTION="Minimalist command line interface for MPD"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.35
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://www.musicpd.org/download/mpc/${CLANDRO_PKG_VERSION:0:1}/mpc-$CLANDRO_PKG_VERSION.tar.xz
CLANDRO_PKG_SHA256=382959c3bfa2765b5346232438650491b822a16607ff5699178aa1386e3878d4
CLANDRO_PKG_DEPENDS="libiconv, libmpdclient"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="-Diconv=enabled"

# There seems to be issues with sphinx-build when using concurrent builds:
CLANDRO_PKG_MAKE_PROCESSES=1

clandro_step_pre_configure() {
	LDFLAGS+=" -liconv"
}
