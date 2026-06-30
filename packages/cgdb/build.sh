CLANDRO_PKG_HOMEPAGE=https://cgdb.github.io/
CLANDRO_PKG_DESCRIPTION="A lightweight curses (terminal-based) interface to the GNU Debugger (GDB)"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.8.0
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://cgdb.me/files/cgdb-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=0d38b524d377257b106bad6d856d8ae3304140e1ee24085343e6ddf1b65811f1
CLANDRO_PKG_DEPENDS="libc++, ncurses, readline, gdb"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_lib_ncursesw6_addnwstr=yes ac_cv_file__dev_ptmx=yes
ac_cv_func_setpgrp_void=true ac_cv_rl_version=7
ac_cv_file__proc_self_status=yes
"
CLANDRO_PKG_RM_AFTER_INSTALL="share/applications share/pixmaps"
