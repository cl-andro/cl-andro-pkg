CLANDRO_PKG_HOMEPAGE=https://0pointer.de/lennart/projects/libdaemon/
CLANDRO_PKG_DESCRIPTION="A lightweight C library that eases the writing of UNIX daemons"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.14
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://0pointer.de/lennart/projects/libdaemon/libdaemon-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=fd23eb5f6f986dcc7e708307355ba3289abe03cc381fc47a80bca4a50aa6b834
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_func_setpgrp_void=yes"

clandro_step_pre_configure() {
	autoreconf -fi
}
