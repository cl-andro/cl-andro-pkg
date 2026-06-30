CLANDRO_PKG_HOMEPAGE=https://www.gnu.org/software/gdb/
CLANDRO_PKG_DESCRIPTION="The standard GNU Debugger that runs on many Unix-like systems and works for many programming languages"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
# This package depends on libpython${CLANDRO_PYTHON_VERSION}.so.
# Please revbump and rebuild when bumping CLANDRO_PYTHON_VERSION.
CLANDRO_PKG_VERSION="16.3"
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=https://mirrors.kernel.org/gnu/gdb/gdb-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=bcfcd095528a987917acf9fff3f1672181694926cc18d609c99d0042c00224c5
CLANDRO_PKG_DEPENDS="guile, libc++, libexpat, libgmp, libiconv, liblzma, libmpfr, libthread-db, ncurses, python, readline, zlib, zstd"
CLANDRO_PKG_BREAKS="gdb-dev"
CLANDRO_PKG_REPLACES="gdb-dev"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-shared
--disable-werror
--with-system-readline
--with-system-zlib
--with-curses
--with-guile
--with-python=$CLANDRO_PREFIX/bin/python
ac_cv_func_getpwent=no
ac_cv_func_getpwnam=no
"
CLANDRO_PKG_RM_AFTER_INSTALL="share/gdb/syscalls share/gdb/system-gdbinit"
CLANDRO_PKG_MAKE_INSTALL_TARGET="-C gdb install"

clandro_step_pre_configure() {
	if [ "$CLANDRO_ON_DEVICE_BUILD" = "false" ]; then
		export ac_cv_guild_program_name=/usr/bin/guild-3.0
	fi

	# Fix "undefined reference to 'rpl_gettimeofday'" when building:
	export gl_cv_func_gettimeofday_clobber=no
	export gl_cv_func_gettimeofday_posix_signature=yes
	export gl_cv_func_realpath_works=yes
	export gl_cv_func_lstat_dereferences_slashed_symlink=yes
	export gl_cv_func_memchr_works=yes
	export gl_cv_func_stat_file_slash=yes
	export gl_cv_func_frexp_no_libm=no
	export gl_cv_func_strerror_0_works=yes
	export gl_cv_func_working_strerror=yes
	export gl_cv_func_getcwd_path_max=yes

	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}

clandro_step_post_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin gdbserver/gdbserver
}
