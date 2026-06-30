CLANDRO_PKG_HOMEPAGE=https://dev.lovelyhq.com/libburnia
CLANDRO_PKG_DESCRIPTION="Frontend for libraries libburn and libisofs"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.5.6
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://files.libburnia-project.org/releases/libisoburn-$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=2b80a6f73dd633a5d243facbe97a15e5c9a07644a5e1a242c219b9375a45f71b
CLANDRO_PKG_DEPENDS="libburn, libisofs, readline"
CLANDRO_PKG_CONFLICTS="xorriso"
CLANDRO_PKG_BREAKS="libisoburn-dev"
CLANDRO_PKG_REPLACES="libisoburn-dev"

# We don't have tk.
CLANDRO_PKG_RM_AFTER_INSTALL="bin/xorriso-tcltk"
