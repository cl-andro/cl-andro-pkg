CLANDRO_PKG_HOMEPAGE=https://zssh.sourceforge.net/
CLANDRO_PKG_DESCRIPTION="A program for interactively transferring files to a remote machine while using the secure shell (ssh)"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.5c
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://downloads.sourceforge.net/zssh/zssh-${CLANDRO_PKG_VERSION}.tgz
CLANDRO_PKG_SHA256=a2e840f82590690d27ea1ea1141af509ee34681fede897e58ae8d354701ce71b
CLANDRO_PKG_DEPENDS="libandroid-glob, lrzsz, openssh, readline"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	autoreconf -fi

	echo "ac_cv_func_getpgrp_void=yes" >> config.cache
	LDFLAGS+=" -landroid-glob"
}
