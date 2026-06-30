CLANDRO_PKG_HOMEPAGE=https://python.org/
CLANDRO_PKG_DESCRIPTION="Python 3 programming language intended to enable clear programs"
# License: PSF-2.0
CLANDRO_PKG_LICENSE="custom"
CLANDRO_PKG_LICENSE_FILE="LICENSE"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=3.11.10
CLANDRO_PKG_SRCURL=https://www.python.org/ftp/python/${CLANDRO_PKG_VERSION}/Python-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=07a4356e912900e61a15cb0949a06c4a05012e213ecd6b4e84d0f67aabbee372
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_DEPENDS="gdbm, libandroid-posix-semaphore, libandroid-support, libbz2, libcrypt, libexpat, libffi, liblzma, libsqlite, ncurses, ncurses-ui-libs, openssl, readline, zlib"
CLANDRO_PKG_BUILD_DEPENDS="tk"
CLANDRO_PKG_RECOMMENDS="python-ensurepip-wheels, python-pip"
CLANDRO_PKG_SUGGESTS="python-tkinter"
CLANDRO_PKG_BREAKS="python2 (<= 2.7.15), python-dev"
CLANDRO_PKG_REPLACES="python-dev"
# Let "python3" will be alias to this package.
CLANDRO_PKG_PROVIDES="python3"

# https://github.com/termux/termux-packages/issues/15908
CLANDRO_PKG_MAKE_PROCESSES=1

_MAJOR_VERSION="${CLANDRO_PKG_VERSION%.*}"

# Set ac_cv_func_wcsftime=no to avoid errors such as "character U+ca0025 is not in range [U+0000; U+10ffff]"
# when executing e.g. "from time import time, strftime, localtime; print(strftime(str('%Y-%m-%d %H:%M'), localtime()))"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_file__dev_ptmx=yes ac_cv_file__dev_ptc=no ac_cv_func_wcsftime=no"
# Avoid trying to include <sys/timeb.h> which does not exist on android-21:
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_func_ftime=no"
# Avoid trying to use AT_EACCESS which is not defined:
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_func_faccessat=no"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" --build=$CLANDRO_BUILD_TUPLE --with-system-ffi --with-system-expat --without-ensurepip"
# Hard links does not work on Android 6:
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_func_linkat=no"
# Do not assume getaddrinfo is buggy when cross compiling:
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_buggy_getaddrinfo=no"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" --enable-loadable-sqlite-extensions"
# Fix https://github.com/termux/termux-packages/issues/2236:
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_little_endian_double=yes"
# Force enable posix semaphores.
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_posix_semaphores_enabled=yes"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_func_sem_open=yes"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_func_sem_timedwait=yes"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_func_sem_getvalue=yes"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_func_sem_unlink=yes"
# Force enable posix shared memory.
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_func_shm_open=yes"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_func_shm_unlink=yes"

CLANDRO_PKG_RM_AFTER_INSTALL="
lib/python${_MAJOR_VERSION}/test
lib/python${_MAJOR_VERSION}/*/test
lib/python${_MAJOR_VERSION}/*/tests
lib/python${_MAJOR_VERSION}/site-packages/*/
"

clandro_step_pre_configure() {
	# -O3 gains some additional performance on at least aarch64.
	CFLAGS="${CFLAGS/-Oz/-O3}"

	# Needed when building with clang, as setup.py only probes
	# gcc for include paths when finding headers for determining
	# if extension modules should be built (specifically, the
	# zlib extension module is not built without this):
	CPPFLAGS+=" -I$CLANDRO_STANDALONE_TOOLCHAIN/sysroot/usr/include"
	LDFLAGS+=" -L$CLANDRO_STANDALONE_TOOLCHAIN/sysroot/usr/lib"
	if [ $CLANDRO_ARCH = x86_64 ]; then LDFLAGS+=64; fi

	if [ "$CLANDRO_ON_DEVICE_BUILD" = "true" ]; then
		# Python's configure script fails with
		#    Fatal: you must define __ANDROID_API__
		# if __ANDROID_API__ is not defined.
		CPPFLAGS+=" -D__ANDROID_API__=$(getprop ro.build.version.sdk)"
	else
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" --with-build-python=python$_MAJOR_VERSION"
	fi

	export LIBCRYPT_LIBS="-lcrypt"
}

clandro_step_post_make_install() {
	(cd $CLANDRO_PREFIX/bin
	ln -sf idle${_MAJOR_VERSION} idle
	ln -sf python${_MAJOR_VERSION} python
	ln -sf python${_MAJOR_VERSION}-config python-config
	ln -sf pydoc${_MAJOR_VERSION} pydoc)
	(cd $CLANDRO_PREFIX/share/man/man1
	ln -sf python${_MAJOR_VERSION}.1 python.1)
}

clandro_step_post_massage() {
	# Verify that desired modules have been included:
	for module in _bz2 _curses _lzma _sqlite3 _ssl _tkinter zlib; do
		if [ ! -f "${CLANDRO_PREFIX}/lib/python${_MAJOR_VERSION}/lib-dynload/${module}".*.so ]; then
			clandro_error_exit "Python module library $module not built"
		fi
	done
}

clandro_step_create_debscripts() {
	# This is a temporary script and will therefore be removed when python is updated to 3.12
	cat <<- POSTINST_EOF > ./postinst
	#!$CLANDRO_PREFIX/bin/bash

	if [[ -f "$CLANDRO_PREFIX/bin/pip" && \
	 ! (("$CLANDRO_PACKAGE_FORMAT" = "debian" && -f $CLANDRO_PREFIX/var/lib/dpkg/info/python-pip.list) || \
	    ("$CLANDRO_PACKAGE_FORMAT" = "pacman" && \$(ls $CLANDRO_PREFIX/var/lib/pacman/local/python-pip-* 2>/dev/null))) ]]; then
		echo "Removing pip..."
		rm -f $CLANDRO_PREFIX/bin/pip $CLANDRO_PREFIX/bin/pip3* $CLANDRO_PREFIX/bin/easy_install $CLANDRO_PREFIX/bin/easy_install-3*
		rm -Rf $CLANDRO_PREFIX/lib/python${_MAJOR_VERSION}/site-packages/pip
		rm -Rf ${CLANDRO_PREFIX}/lib/python${_MAJOR_VERSION}/site-packages/pip-*.dist-info
	fi

	if [ ! -f "$CLANDRO_PREFIX/bin/pip" ]; then
		echo
		echo "== Note: pip is now separate from python =="
		echo "To install, enter the following command:"
		echo "   pkg install python-pip"
		echo
	fi

	exit 0
	POSTINST_EOF

	chmod 0755 postinst

	if [ "$CLANDRO_PACKAGE_FORMAT" = "pacman" ]; then
		echo "post_install" > postupg
	fi
}
