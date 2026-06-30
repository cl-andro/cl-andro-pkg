CLANDRO_PKG_HOMEPAGE=https://www.nongnu.org/man-db/
CLANDRO_PKG_DESCRIPTION="Utilities for examining on-line help files (manual pages)"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.7.5
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://download.savannah.nongnu.org/releases/man-db/man-db-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=5c4ddd0d67abbbcb408dc5804906f62210f7c863ef791198faca3d75681cca14
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--with-db=gdbm --with-pager=less --with-config-file=${CLANDRO_PREFIX}/etc/man_db.conf --disable-setuid --with-browser=lynx --with-gzip=gzip --with-systemdtmpfilesdir=${CLANDRO_PREFIX}/lib/tmpfiles.d"
CLANDRO_PKG_DEPENDS="flex, gdbm, groff, less, libandroid-support, libpipeline, lynx"

export GROFF_TMAC_PATH="${CLANDRO_PREFIX}/lib/groff/site-tmac:${CLANDRO_PREFIX}/share/groff/site-tmac:${CLANDRO_PREFIX}/share/groff/current/tmac"
