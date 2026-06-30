CLANDRO_PKG_HOMEPAGE=https://python.org/
CLANDRO_PKG_DESCRIPTION="Python 3 programming language intended to enable clear programs"
# License: PSF-2.0
CLANDRO_PKG_LICENSE="custom"
CLANDRO_PKG_LICENSE_FILE="LICENSE"
CLANDRO_PKG_MAINTAINER="Yaksh Bariya <thunder-coding@termux.dev> & @clandro"
CLANDRO_PKG_VERSION="3.13.13"
CLANDRO_PKG_REVISION=1
_DEBPYTHON_COMMIT=f358ab52bf2932ad55b1a72a29c9762169e6ac47
CLANDRO_PKG_SRCURL=(
	https://www.python.org/ftp/python/${CLANDRO_PKG_VERSION}/Python-${CLANDRO_PKG_VERSION}.tar.xz
	https://salsa.debian.org/cpython-team/python3-defaults/-/archive/${_DEBPYTHON_COMMIT}/python3-defaults-${_DEBPYTHON_COMMIT}.tar.gz
)
CLANDRO_PKG_SHA256=(
	2ab91ff401783ccca64f75d10c882e957bdfd60e2bf5a72f8421793729b78a71
	3b7a76c144d39f5c4a2c7789fd4beb3266980c2e667ad36167e1e7a357c684b0
)
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_DEPENDS="gdbm, libandroid-posix-semaphore, libandroid-support, libbz2, libcrypt, libexpat, libffi, liblzma, libsqlite, ncurses, ncurses-ui-libs, openssl, readline, zlib"
CLANDRO_PKG_BUILD_DEPENDS="tk"
CLANDRO_PKG_RECOMMENDS="python-ensurepip-wheels, python-pip"
CLANDRO_PKG_SUGGESTS="python-tkinter"
CLANDRO_PKG_BREAKS="python2 (<= 2.7.15), python-dev"
CLANDRO_PKG_REPLACES="python-dev"
# Let "python3" will be alias to this package.
CLANDRO_PKG_PROVIDES="python3"

_MAJOR_VERSION="${CLANDRO_PKG_VERSION%.*}"

# Set ac_cv_func_wcsftime=no to avoid errors such as "character U+ca0025 is not in range [U+0000; U+10ffff]"
# when executing e.g. "from time import time, strftime, localtime; print(strftime(str('%Y-%m-%d %H:%M'), localtime()))"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_file__dev_ptmx=yes ac_cv_file__dev_ptc=no ac_cv_func_wcsftime=no"
# Avoid trying to include <sys/timeb.h> which does not exist on android-21:
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_func_ftime=no"
# Avoid trying to use AT_EACCESS which is not defined:
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_func_faccessat=no"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" --build=$CLANDRO_BUILD_TUPLE --with-system-ffi --with-system-expat --without-ensurepip"
# Hard links do not work on Android 6:
# https://github.com/termux/termux-packages/issues/29
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_func_link=no"
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
# Assume tzset() works
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_working_tzset=yes"
# prevents 'configure: error: Cross compiling requires --with-build-python' (even during on-device build)
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" --with-build-python=python$_MAJOR_VERSION"
# https://github.com/termux/termux-packages/issues/16879
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_header_sys_xattr_h=no"
# https://github.com/termux/termux-packages/issues/28684 (termux has inline getgrent stub in grp.h header patch)
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_func_getgrent=yes"

CLANDRO_PKG_RM_AFTER_INSTALL="
lib/python${_MAJOR_VERSION}/test
lib/python${_MAJOR_VERSION}/*/test
lib/python${_MAJOR_VERSION}/*/tests
lib/python${_MAJOR_VERSION}/site-packages/*/
"

clandro_step_post_get_source() {
	patch="$CLANDRO_PKG_BUILDER_DIR/hardcode-android-api-level.diff"
	echo "Applying patch: $(basename "$patch")"
	test -f "$patch" && sed \
		-e "s%\@CLANDRO_PKG_API_LEVEL\@%${CLANDRO_PKG_API_LEVEL}%g" \
		"$patch" | patch --silent -p1


	mv "$CLANDRO_PKG_SRCDIR/python3-defaults-$_DEBPYTHON_COMMIT" "$CLANDRO_PKG_SRCDIR/debpython"
}

clandro_step_pre_configure() {
	clandro_setup_build_python
	# -O3 gains some additional performance on at least aarch64.
	CFLAGS="${CFLAGS/-Oz/-O3}"

	# Needed when building with clang, as setup.py only probes
	# gcc for include paths when finding headers for determining
	# if extension modules should be built (specifically, the
	# zlib extension module is not built without this):
	CPPFLAGS+=" -I$CLANDRO_STANDALONE_TOOLCHAIN/sysroot/usr/include"
	# Without this all symbols are removed from the built libpython3.so
	LDFLAGS="${LDFLAGS/-Wl,--as-needed/}"
	LDFLAGS+=" -L$CLANDRO_STANDALONE_TOOLCHAIN/sysroot/usr/lib"
	if [ $CLANDRO_ARCH = x86_64 ]; then LDFLAGS+=64; fi

	# these prevent errors like "call to undeclared function 'sem_clockwait'" during on-device build
	# on devices that have API levels newer than $CLANDRO_PKG_API_LEVEL
	if [[ "$CLANDRO_PKG_API_LEVEL" -lt 28 ]]; then
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_func_fexecve=no"
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_func_getlogin_r=no"
	fi

	if [[ "$CLANDRO_PKG_API_LEVEL" -lt 29 ]]; then
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_func_getloadavg=no"
	fi

	if [[ "$CLANDRO_PKG_API_LEVEL" -lt 30 ]]; then
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_func_sem_clockwait=no"
	fi

	if [[ "$CLANDRO_PKG_API_LEVEL" -lt 33 ]]; then
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_func_preadv2=no"
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_func_pwritev2=no"
	fi

	if [[ "$CLANDRO_PKG_API_LEVEL" -lt 34 ]]; then
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_func_close_range=no"
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_func_copy_file_range=no"
	fi

	# For multiprocessing libs
	export LDFLAGS+=" -landroid-posix-semaphore"

	export LIBCRYPT_LIBS="-lcrypt"

	sed -i -e "s|@CLANDRO_PYTHON_VERSION@|${_MAJOR_VERSION}|g" \
		-e "s|@CLANDRO_PKG_FULLVERSION@|$(test ${CLANDRO_PACKAGE_FORMAT} = pacman && echo ${CLANDRO_PKG_FULLVERSION_FOR_PACMAN} || echo ${CLANDRO_PKG_FULLVERSION})|g" \
		$(find "$CLANDRO_PKG_SRCDIR/debpython" -type f)
	autoreconf -fi
}

clandro_step_post_make_install() {
	(cd $CLANDRO_PREFIX/bin
	ln -sf idle${_MAJOR_VERSION} idle
	ln -sf python${_MAJOR_VERSION} python
	ln -sf python${_MAJOR_VERSION}-config python-config
	ln -sf pydoc${_MAJOR_VERSION} pydoc)
	(cd $CLANDRO_PREFIX/share/man/man1
	ln -sf python${_MAJOR_VERSION}.1 python.1)

	install -m 755 -d "$CLANDRO_PREFIX/lib/python$_MAJOR_VERSION/debpython"
	install -m 644 "$CLANDRO_PKG_SRCDIR/debpython/debpython/"* \
		"$CLANDRO_PREFIX/lib/python$_MAJOR_VERSION/debpython/"

	for prog in py3compile py3clean; do
		install -m 755 "$CLANDRO_PKG_SRCDIR/debpython/$prog" "$CLANDRO_PREFIX/bin/"
	done
}

clandro_step_post_massage() {
	# Verify that desired modules have been included:
	for module in _bz2 _curses _lzma _multiprocessing _sqlite3 _ssl _tkinter zlib; do
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

	if [[ -d $CLANDRO_PREFIX/lib/python3.11/site-packages || -d $CLANDRO_PREFIX/lib/python3.12/site-packages ]]; then
		echo
		echo "NOTE: The system python package has been updated to 3.13."
		echo "NOTE: Run 'pkg upgrade' to update system python packages."
		echo "NOTE: Packages installed using pip needs to be re-installed."
		echo
	fi

	exit 0
	POSTINST_EOF

	chmod 0755 postinst

	if [ "$CLANDRO_PACKAGE_FORMAT" = "pacman" ]; then
		echo "post_install" > postupg
	fi
}
