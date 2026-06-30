CLANDRO_PKG_HOMEPAGE=https://php.net
CLANDRO_PKG_DESCRIPTION="Server-side, HTML-embedded scripting language"
CLANDRO_PKG_LICENSE="PHP-3.0"
CLANDRO_PKG_MAINTAINER=""
CLANDRO_PKG_VERSION=7.4.33
CLANDRO_PKG_SRCURL=https://github.com/php/php-src/archive/php-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=dfbb2111160589054768a37086bda650a0041c89878449d078684d70d6a0e411
# Build native php for phar to build (see pear-Makefile.frag.patch):
CLANDRO_PKG_HOSTBUILD=true
# Build the native php without xml support as we only need phar:
CLANDRO_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS="--disable-libxml --disable-dom --disable-simplexml --disable-xml --disable-xmlreader --disable-xmlwriter --without-pear --disable-sqlite3 --without-libxml --without-sqlite3 --without-pdo-sqlite"
CLANDRO_PKG_DEPENDS="libc++, freetype, libandroid-glob, libandroid-support, libbz2, libcrypt, libcurl, libgd, libgmp, libiconv, liblzma, libsqlite, libxml2, libxslt, libzip, oniguruma, openssl-1.1, pcre2, readline, zlib, libicu, libffi, tidy"
CLANDRO_PKG_CONFLICTS="php, php-mysql, php-dev"
CLANDRO_PKG_RM_AFTER_INSTALL="php/php/fpm"
CLANDRO_PKG_SERVICE_SCRIPT=("php-fpm" 'mkdir -p ~/.php\nif [ -f "$HOME/.php/php-fpm.conf" ]; then CONFIG="$HOME/.php/php-fpm.conf"; else CONFIG="$PREFIX/etc/php-fpm.conf"; fi\nexec php-fpm -F -y $CONFIG -c ~/.php/php.ini 2>&1')

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_func_res_nsearch=no
--enable-bcmath
--enable-calendar
--enable-exif
--enable-mbstring
--enable-opcache
--enable-pcntl
--enable-sockets
--mandir=$CLANDRO_PREFIX/share/man
--with-bz2=$CLANDRO_PREFIX
--with-curl=$CLANDRO_PREFIX
--with-openssl=$CLANDRO_PREFIX
--with-readline=$CLANDRO_PREFIX
--with-iconv-dir=$CLANDRO_PREFIX
--with-zlib
--with-pgsql=shared,$CLANDRO_PREFIX
--with-pdo-pgsql=shared,$CLANDRO_PREFIX
--with-mysqli=mysqlnd
--with-pdo-mysql=mysqlnd
--with-mysql-sock=$CLANDRO_PREFIX/tmp/mysqld.sock
--with-apxs2=$CLANDRO_PKG_TMPDIR/apxs-wrapper.sh
--with-iconv=$CLANDRO_PREFIX
--enable-fpm
--enable-gd
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
	(cd "$CLANDRO_PKG_SRCDIR" && ./buildconf --force)
	"$CLANDRO_PKG_SRCDIR/configure" ${CLANDRO_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS}
	make -j "$CLANDRO_PKG_MAKE_PROCESSES"
}

clandro_step_pre_configure() {
	CPPFLAGS+=" -DGD_FLIP_VERTICAL=1"
	CPPFLAGS+=" -DGD_FLIP_HORINZONTAL=2"
	CPPFLAGS+=" -DGD_FLIP_BOTH=3"
	CPPFLAGS+=" -DU_DEFINE_FALSE_AND_TRUE=1"

	LDFLAGS+=" -landroid-glob -llog"

	export PATH=$PATH:$CLANDRO_PKG_HOSTBUILD_DIR/sapi/cli/
	export NATIVE_PHP_EXECUTABLE=$CLANDRO_PKG_HOSTBUILD_DIR/sapi/cli/php
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

	CFLAGS="-I$CLANDRO_PREFIX/include/openssl-1.1 $CFLAGS"
	CPPFLAGS="-I$CLANDRO_PREFIX/include/openssl-1.1 $CPPFLAGS"
	CXXFLAGS="-I$CLANDRO_PREFIX/include/openssl-1.1 $CXXFLAGS"
	LDFLAGS="-L$CLANDRO_PREFIX/lib/openssl-1.1 -Wl,-rpath=$CLANDRO_PREFIX/lib/openssl-1.1 $LDFLAGS"

	local wrapper_bin=$CLANDRO_PKG_BUILDDIR/_wrapper/bin
	local _cc=$(basename $CC)
	rm -rf $wrapper_bin
	mkdir -p $wrapper_bin
	cat <<-EOF > $wrapper_bin/$_cc
		#!$(command -v sh)
		exec $(command -v $_cc) -L$CLANDRO_PREFIX/lib/openssl-1.1 \
			-Wno-unused-command-line-argument "\$@"
	EOF
	chmod 0700 $wrapper_bin/$_cc
	export PATH=$wrapper_bin:$PATH
}

clandro_step_post_configure() {
	# Avoid src/ext/gd/gd.c trying to include <X11/xpm.h>:
	sed -i 's/#define HAVE_GD_XPM 1//' $CLANDRO_PKG_BUILDDIR/main/php_config.h
	# Avoid src/ext/standard/dns.c trying to use struct __res_state:
	sed -i 's/#define HAVE_RES_NSEARCH 1//' $CLANDRO_PKG_BUILDDIR/main/php_config.h
}

clandro_step_post_make_install() {
	mkdir -p $CLANDRO_PREFIX/etc/php-fpm.d
	cp sapi/fpm/php-fpm.conf $CLANDRO_PREFIX/etc/
	cp sapi/fpm/www.conf $CLANDRO_PREFIX/etc/php-fpm.d/

	sed -i 's/SED=.*/SED=sed/' $CLANDRO_PREFIX/bin/phpize
}

clandro_step_create_debscripts() {
	cat <<-EOF > ./postinst
		#!$CLANDRO_PREFIX/bin/sh
		echo
		echo "********"
		echo "PHP 7.4 reaches its end of life on 28 Nov 2022 and is no longer supported afterwards."
		echo "Please consider migrating to a newer version of PHP."
		echo "********"
		echo
	EOF
}
