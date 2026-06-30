CLANDRO_PKG_HOMEPAGE=https://mariadb.org
CLANDRO_PKG_DESCRIPTION="A drop-in replacement for mysql server"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2:12.2.2"
CLANDRO_PKG_SRCURL=https://archive.mariadb.org/mariadb-${CLANDRO_PKG_VERSION#*:}/source/mariadb-${CLANDRO_PKG_VERSION#*:}.tar.gz
CLANDRO_PKG_SHA256=fe82fe2e9af98dfcad8c0266a283ca349b78fd46989fff0d5e1ffca644b514bd
CLANDRO_PKG_DEPENDS="libandroid-support, libbz2, libc++, libcrypt, libedit, liblz4, libxml2, liblzma, ncurses, openssl, pcre2, zlib, zstd"
CLANDRO_PKG_BREAKS="mariadb-dev"
CLANDRO_PKG_CONFLICTS="mysql"
CLANDRO_PKG_REPLACES="mariadb-dev"
CLANDRO_PKG_SERVICE_SCRIPT=("mysqld" "exec mysqld --basedir=$CLANDRO_PREFIX --datadir=$CLANDRO_PREFIX/var/lib/mysql 2>&1")
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_CMAKE_BUILD="Unix Makefiles"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DBISON_EXECUTABLE=$(command -v bison)
-DGETCONF=$(command -v getconf)
-DBUILD_CONFIG=mysql_release
-DCAT_EXECUTABLE=$(command -v cat)
-DGIT_EXECUTABLE=$(command -v git)
-DHAVE_SYSTEM_LIBFMT_EXITCODE=0
-DGSSAPI_FOUND=NO
-DGRN_WITH_LZ4=yes
-DENABLED_LOCAL_INFILE=ON
-DHAVE_UCONTEXT_H=False
-DIMPORT_EXECUTABLES=$CLANDRO_PKG_HOSTBUILD_DIR/import_executables.cmake
-DINSTALL_LAYOUT=DEB
-DINSTALL_UNIX_ADDRDIR=$CLANDRO_PREFIX/var/run/mysqld.sock
-DINSTALL_SBINDIR=$CLANDRO_PREFIX/bin
-DMYSQL_DATADIR=$CLANDRO_PREFIX/var/lib/mysql
-DPLUGIN_AUTH_GSSAPI_CLIENT=OFF
-DPLUGIN_AUTH_GSSAPI=NO
-DPLUGIN_AUTH_PAM=NO
-DPLUGIN_CONNECT=NO
-DPLUGIN_DAEMON_EXAMPLE=NO
-DPLUGIN_EXAMPLE=NO
-DPLUGIN_GSSAPI=OFF
-DPLUGIN_ROCKSDB=NO
-DPLUGIN_TOKUDB=NO
-DPLUGIN_SERVER_AUDIT=NO
-DSTACK_DIRECTION=-1
-DTMPDIR=$CLANDRO_PREFIX/tmp
-DWITH_EXTRA_CHARSETS=complex
-DWITH_JEMALLOC=OFF
-DWITH_MARIABACKUP=OFF
-DWITH_PCRE=system
-DWITH_LZ4=system
-DWITH_READLINE=OFF
-DWITH_SSL=system
-DWITH_WSREP=False
-DWITH_ZLIB=system
-DWITH_INNODB_BZIP2=OFF
-DWITH_INNODB_LZ4=ON
-DWITH_INNODB_LZMA=ON
-DWITH_INNODB_LZO=OFF
-DWITH_INNODB_SNAPPY=OFF
-DWITH_UNIT_TESTS=OFF
-DSTAT_EMPTY_STRING_BUG_EXITCODE=0
-DLSTAT_FOLLOWS_SLASHED_SYMLINK_EXITCODE=0
-DMASK_LONGDOUBLE_EXITCODE=1
-DINSTALL_SYSCONFDIR=$CLANDRO_PREFIX/etc
"
CLANDRO_PKG_RM_AFTER_INSTALL="
bin/rcmysql
bin/mysqltest*
share/man/man1/mysql-test-run.pl.1
share/mariadb/mariadb-test
mysql-test
sql-bench
"

clandro_step_host_build() {
	clandro_setup_cmake
	sed -i 's/^\s*END[(][)]/ENDIF()/g' $CLANDRO_PKG_SRCDIR/libmariadb/cmake/ConnectorName.cmake
	cmake -G "Unix Makefiles" \
		$CLANDRO_PKG_SRCDIR \
		-DWITH_SSL=bundled \
		-DCMAKE_BUILD_TYPE=Release
	make -j $CLANDRO_PKG_MAKE_PROCESSES import_executables
}

clandro_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $CLANDRO_PREFIX.
	if $CLANDRO_ON_DEVICE_BUILD; then
		clandro_error_exit "Package '$CLANDRO_PKG_NAME' is not safe for on-device builds."
	fi

	CPPFLAGS+=" -Dushort=u_short"
	CXXFLAGS+=" -Wno-register"

	if [ $CLANDRO_ARCH_BITS = 32 ]; then
		CPPFLAGS+=" -D__off64_t_defined"
	fi

	sed -i 's/^\s*END[(][)]/ENDIF()/g' $CLANDRO_PKG_SRCDIR/libmariadb/cmake/ConnectorName.cmake

	export PATH=$CLANDRO_PKG_HOSTBUILD_DIR/strings:$PATH
}

clandro_step_post_massage() {
	mkdir -p $CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX/etc/my.cnf.d

	# move vendored groonga docs to resolve file conflict with groonga
	mv $CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX/share/{groonga{,-normalizer-mysql},doc/mariadb/}
}

clandro_step_create_debscripts() {
	echo "if [ ! -e "$CLANDRO_PREFIX/var/lib/mysql" ]; then" > postinst
	echo "  echo 'Initializing mysql data directory...'" >> postinst
	echo "  mkdir -p $CLANDRO_PREFIX/var/lib/mysql" >> postinst
	echo "  $CLANDRO_PREFIX/bin/mariadb-install-db --user=root --auth-root-authentication-method=normal --datadir=$CLANDRO_PREFIX/var/lib/mysql" >> postinst
	echo "fi" >> postinst
	echo "exit 0" >> postinst
	chmod 0755 postinst
}
