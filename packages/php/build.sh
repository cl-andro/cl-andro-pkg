CLANDRO_PKG_HOMEPAGE=https://php.net
CLANDRO_PKG_DESCRIPTION="Server-side, HTML-embedded scripting language"
CLANDRO_PKG_LICENSE="PHP-3.01"
CLANDRO_PKG_LICENSE_FILE=LICENSE
CLANDRO_PKG_MAINTAINER="@clandro"
# Please revbump php-* extensions along with "minor" bump (e.g. 8.1.x to 8.2.0)
CLANDRO_PKG_VERSION="8.5.1"
CLANDRO_PKG_SRCURL=https://github.com/php/php-src/archive/refs/tags/php-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=846f7c5bdb8c2ebb313c4ec25d92339bcbaf733743c9f6a7646e9a5134b90a8e
CLANDRO_PKG_AUTO_UPDATE=false
# Build native php for phar to build (see pear-Makefile.frag.patch):
CLANDRO_PKG_HOSTBUILD=true
# Build the native php without xml support as we only need phar:
CLANDRO_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS="--disable-libxml --disable-dom --disable-simplexml --disable-xml --disable-xmlreader --disable-xmlwriter --without-pear --disable-sqlite3 --without-libxml --without-sqlite3 --without-pdo-sqlite"
CLANDRO_PKG_DEPENDS="capstone, libandroid-glob, libandroid-support, libbz2, libc++, libcurl, libffi, libgmp, libiconv, libicu, libresolv-wrapper, libsqlite, libxml2, libxslt, libzip, oniguruma, openssl, pcre2, readline, tidy, zlib"
CLANDRO_PKG_BUILD_DEPENDS="postgresql"
CLANDRO_PKG_CONFLICTS="php-mysql, php-dev"
CLANDRO_PKG_REPLACES="php-mysql, php-dev"
CLANDRO_PKG_RM_AFTER_INSTALL="php/php/fpm"
CLANDRO_PKG_SERVICE_SCRIPT=("php-fpm" "mkdir -p $CLANDRO_ANDROID_HOME/.php\nif [ -f \"$CLANDRO_ANDROID_HOME/.php/php-fpm.conf\" ]; then CONFIG=\"$CLANDRO_ANDROID_HOME/.php/php-fpm.conf\"; else CONFIG=\"$CLANDRO_PREFIX/etc/php-fpm.conf\"; fi\nexec php-fpm -F -y \$CONFIG -c ~/.php/php.ini 2>&1")

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_func_res_nsearch=no
ac_cv_phpdbg_userfaultfd_writefault=no
php_cv_lib_gd_gdImageCreateFromPng=yes
php_cv_lib_gd_gdImageCreateFromAvif=yes
php_cv_lib_gd_gdImageCreateFromWebp=yes
php_cv_lib_gd_gdImageCreateFromJpeg=yes
php_cv_lib_gd_gdImageCreateFromBmp=yes
php_cv_lib_gd_gdImageCreateFromTga=yes
--enable-bcmath
--enable-calendar
--enable-exif
--enable-mbstring
--with-capstone
--enable-pcntl
--enable-sockets
--mandir=$CLANDRO_PREFIX/share/man
--with-bz2=$CLANDRO_PREFIX
--with-config-file-path=$CLANDRO_PREFIX/etc/$CLANDRO_PKG_NAME
--with-config-file-scan-dir=$CLANDRO_PREFIX/etc/$CLANDRO_PKG_NAME/conf.d
--with-curl=$CLANDRO_PREFIX
--with-ldap=shared,$CLANDRO_PREFIX
--with-ldap-sasl
--with-openssl=$CLANDRO_PREFIX
--with-readline=$CLANDRO_PREFIX
--with-sodium=shared,$CLANDRO_PREFIX
--with-zlib
--with-pgsql=shared,$CLANDRO_PREFIX
--with-pdo-pgsql=shared,$CLANDRO_PREFIX
--with-mysqli=mysqlnd
--with-pdo-mysql=mysqlnd
--with-mysql-sock=$CLANDRO_PREFIX/tmp/mysqld.sock
--with-apxs2=$CLANDRO_PKG_TMPDIR/apxs-wrapper.sh
--with-iconv=$CLANDRO_PREFIX
--enable-fpm
--enable-gd=shared,$CLANDRO_PREFIX
--with-external-gd
--with-external-pcre
--with-zip
--with-xsl
--with-gmp
--with-ffi
--with-tidy=$CLANDRO_PREFIX
--enable-intl
--sbindir=$CLANDRO_PREFIX/bin
"

clandro_step_host_build() {
	# PatchELF packaged in Ubuntu is too old.
	local PATCHELF_BUILD_SH=$CLANDRO_SCRIPTDIR/packages/patchelf/build.sh
	local PATCHELF_SRCURL=$(bash -c ". $PATCHELF_BUILD_SH; echo \$CLANDRO_PKG_SRCURL")
	local PATCHELF_SHA256=$(bash -c ". $PATCHELF_BUILD_SH; echo \$CLANDRO_PKG_SHA256")
	local PATCHELF_TARFILE=$CLANDRO_PKG_CACHEDIR/$(basename $PATCHELF_SRCURL)
	clandro_download $PATCHELF_SRCURL $PATCHELF_TARFILE $PATCHELF_SHA256
	local PATCHELF_SRCDIR=$CLANDRO_PKG_HOSTBUILD_DIR/_patchelf
	mkdir -p $PATCHELF_SRCDIR
	tar xf $PATCHELF_TARFILE -C $PATCHELF_SRCDIR --strip-components=1
	pushd $PATCHELF_SRCDIR
	./bootstrap.sh
	./configure
	make -j $CLANDRO_PKG_MAKE_PROCESSES
	popd

	(cd "$CLANDRO_PKG_SRCDIR" && ./buildconf --force)
	"$CLANDRO_PKG_SRCDIR/configure" ${CLANDRO_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS}
	make -j "$CLANDRO_PKG_MAKE_PROCESSES"
}

clandro_step_pre_configure() {
	export PATH=$CLANDRO_PKG_HOSTBUILD_DIR/_patchelf/src:$PATH

	# warning: static library libclang_rt.builtins-aarch64-android.a is not portable
	local _libgcc_file="$($CC -print-libgcc-file-name)"
	local _libgcc_path="$(dirname $_libgcc_file)"
	local _libgcc_name="$(basename $_libgcc_file)"
	LDFLAGS+=" -lresolv_wrapper -landroid-glob -llog -L$_libgcc_path -l:$_libgcc_name -lm"

	export PATH=$PATH:$CLANDRO_PKG_HOSTBUILD_DIR/sapi/cli/
	export NATIVE_PHP_EXECUTABLE=$CLANDRO_PKG_HOSTBUILD_DIR/sapi/cli/php
	export NATIVE_MINILUA_EXECUTABLE=$CLANDRO_PKG_HOSTBUILD_DIR/ext/opcache/jit/ir/minilua
	if [ "$CLANDRO_ARCH" = "aarch64" ]; then
		CFLAGS+=" -march=armv8-a+crc"
		CXXFLAGS+=" -march=armv8-a+crc"
	fi
	# Regenerate configure again since we have patched config.m4 files.
	./buildconf --force

	export EXTENSION_DIR=$CLANDRO_PREFIX/lib/php

	# Use a wrapper since bin/apxs has the Termux shebang:
	echo "perl $CLANDRO_PREFIX/bin/apxs \$@" > $CLANDRO_PKG_TMPDIR/apxs-wrapper.sh
	chmod +x $CLANDRO_PKG_TMPDIR/apxs-wrapper.sh
	cat $CLANDRO_PKG_TMPDIR/apxs-wrapper.sh

	# Fix overlinking (unneeded DT_NEEDED entries) with libtool:
	local wrapper_bin=$CLANDRO_PKG_BUILDDIR/_wrapper/bin
	local _cc=$(basename $CC)
	rm -rf $wrapper_bin
	mkdir -p $wrapper_bin
	cat <<-EOF > $wrapper_bin/$_cc
		#!$(command -v sh)
		exec $(command -v $_cc) \
			--start-no-unused-arguments \
			-Wl,--as-needed \
			--end-no-unused-arguments \
			"\$@"
	EOF
	chmod 0700 $wrapper_bin/$_cc
	export PATH=$wrapper_bin:$PATH
}

clandro_step_post_configure() {
	# Avoid src/ext/gd/gd.c trying to include <X11/xpm.h>:
	sed -i 's/#define HAVE_GD_XPM 1//' $CLANDRO_PKG_BUILDDIR/main/php_config.h
	# Avoid src/ext/standard/dns.c trying to use struct __res_state:
	sed -i 's/#define HAVE_RES_NSEARCH 1//' $CLANDRO_PKG_BUILDDIR/main/php_config.h
	# fix error: call to undeclared function pthread_* (https://github.com/php/php-src/blob/php-8.4.1/sapi/phpdbg/phpdbg_watch.c#L314)
	sed -i 's/#define HAVE_USERFAULTFD_WRITEFAULT 1//' $CLANDRO_PKG_BUILDDIR/main/php_config.h
}

clandro_step_post_make_install() {
	mkdir -p $CLANDRO_PREFIX/etc/php-fpm.d
	cp sapi/fpm/php-fpm.conf $CLANDRO_PREFIX/etc/
	cp sapi/fpm/www.conf $CLANDRO_PREFIX/etc/php-fpm.d/

	docdir=$CLANDRO_PREFIX/share/doc/php
	mkdir -p $docdir
	for suffix in development production; do
		cp $CLANDRO_PKG_SRCDIR/php.ini-$suffix $docdir/
	done

	local extdir="$CLANDRO_PREFIX/etc/$CLANDRO_PKG_NAME/conf.d"
	mkdir -p "$extdir"
	for ext in gd ldap pgsql pdo_pgsql sodium; do
		echo "extension=$ext" > "$extdir/$ext.ini"
	done

	sed -i 's/SED=.*/SED=sed/' $CLANDRO_PREFIX/bin/phpize

	# Shared extensions for PHP/Apache
	mkdir -p $CLANDRO_PREFIX/lib/php-apache
	local f
	for f in ldap pdo_pgsql pgsql sodium; do
		local so=$CLANDRO_PREFIX/lib/php-apache/${f}.so
		rm -f ${so}
		cp -T $CLANDRO_PREFIX/lib/php/${f}.so ${so}
		patchelf --set-rpath $CLANDRO_PREFIX/libexec/apache2:$CLANDRO_PREFIX/lib \
			--add-needed libphp.so \
			${so}
	done
}
