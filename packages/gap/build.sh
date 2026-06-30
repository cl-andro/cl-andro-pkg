CLANDRO_PKG_HOMEPAGE=https://www.gap-system.org/
CLANDRO_PKG_DESCRIPTION="GAP is a system for computational discrete algebra, with particular emphasis on Computational Group Theory"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.15.1"
CLANDRO_PKG_SRCURL=https://github.com/gap-system/gap/releases/download/v${CLANDRO_PKG_VERSION}/gap-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=6049d53e99b12e25c2d848db21ac4a06380a46fe4c4157243d556fe06930042c
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="readline, libgmp, zlib, gap-packages"
CLANDRO_PKG_BREAKS="gap-dev"
CLANDRO_PKG_REPLACES="gap-dev"
CLANDRO_PKG_GROUPS="science"

clandro_step_post_make_install() {
	mkdir -p $CLANDRO_PREFIX/lib/gap/pkg
	# install at least gapdoc, smallgrp, transgrp, primgrp or else
	# this package is mostly useless.
	cp -r $CLANDRO_PKG_SRCDIR/pkg/gapdoc $CLANDRO_PREFIX/lib/gap/pkg/
	cp -r $CLANDRO_PKG_SRCDIR/pkg/smallgrp $CLANDRO_PREFIX/lib/gap/pkg/
	cp -r $CLANDRO_PKG_SRCDIR/pkg/transgrp $CLANDRO_PREFIX/lib/gap/pkg/
	cp -r $CLANDRO_PKG_SRCDIR/pkg/primgrp $CLANDRO_PREFIX/lib/gap/pkg/

	# To save some disk space, compress transgrp data in place
	# (GAP transparently allows read access to those)
	gzip -9 -n -f $CLANDRO_PREFIX/lib/gap/pkg/transgrp/data/*.*
}
