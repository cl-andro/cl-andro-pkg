CLANDRO_PKG_HOMEPAGE=https://www.postgresql.org
CLANDRO_PKG_DESCRIPTION="Object-relational SQL database"
CLANDRO_PKG_LICENSE="PostgreSQL"
CLANDRO_PKG_LICENSE_FILE="COPYRIGHT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="18.2"
CLANDRO_PKG_SRCURL=https://ftp.postgresql.org/pub/source/v$CLANDRO_PKG_VERSION/postgresql-$CLANDRO_PKG_VERSION.tar.bz2
CLANDRO_PKG_SHA256=5245bd1b79700d55b8e0575be0325ef61e7bbef627e6a616e4cf36ad4687be36
CLANDRO_PKG_DEPENDS="libandroid-execinfo, libandroid-shmem, libicu, libuuid, libxml2, openssl, readline, zlib"
# - pgac_cv_prog_cc_LDFLAGS_EX_BE__Wl___export_dynamic: Needed to fix PostgreSQL 16 that
#   causes initdb failure: cannot locate symbol
# - pgac_cv_prog_cc_LDFLAGS__Wl___as_needed: Inform that the linker supports as-needed. It's
#   not stricly necessary but avoids unnecessary linking of binaries.
# - USE_UNNAMED_POSIX_SEMAPHORES: Avoid using System V semaphores which are disabled on Android.
# - ZIC=...: The zic tool is used to build the time zone database bundled with postgresql.
#   We specify a binary built in clandro_step_host_build which has been patched to use symlinks
#   over hard links (which are not supported as of Android 6.0+).
#   There exists a --with-system-tzdata configure flag, but that does not work here as Android
#   uses a custom combined tzdata file.
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--with-icu
--with-libxml
--with-openssl
--with-uuid=e2fs
USE_UNNAMED_POSIX_SEMAPHORES=1
ZIC=${CLANDRO_PKG_HOSTBUILD_DIR}/src/timezone/zic
pgac_cv_prog_cc_LDFLAGS_EX_BE__Wl___export_dynamic=yes
pgac_cv_prog_cc_LDFLAGS__Wl___as_needed=yes
"
CLANDRO_PKG_RM_AFTER_INSTALL="
bin/ecpg
lib/libecpg*
share/man/man1/ecpg.1
"
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_BREAKS="postgresql-contrib (<= 10.3-1), postgresql-dev"
CLANDRO_PKG_REPLACES="postgresql-contrib (<= 10.3-1), postgresql-dev"
CLANDRO_PKG_SERVICE_SCRIPT=("postgres" "mkdir -p ~/.postgres\nif [ -f \"~/.postgres/postgresql.conf\" ]; then DATADIR=\"~/.postgres\"; else DATADIR=\"$CLANDRO_PREFIX/var/lib/postgresql\"; fi\nexec postgres -D \$DATADIR 2>&1")

clandro_step_host_build() {
	# Build a native zic binary which we have patched to
	# use symlinks instead of hard links.
	$CLANDRO_PKG_SRCDIR/configure --without-readline
	make -j "${CLANDRO_PKG_MAKE_PROCESSES}"
}

clandro_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $CLANDRO_PREFIX.
	if $CLANDRO_ON_DEVICE_BUILD; then
		clandro_error_exit "Package '$CLANDRO_PKG_NAME' is not safe for on-device builds."
	fi
}

clandro_step_post_make_install() {
	# Man pages are not installed by default:
	make -C doc/src/sgml install-man

	for contrib in \
		btree_gin \
		btree_gist \
		citext \
		dblink \
		fuzzystrmatch \
		hstore \
		pageinspect \
		pg_freespacemap \
		pg_stat_statements \
		pg_trgm \
		pgcrypto \
		pgrowlocks \
		postgres_fdw \
		tablefunc \
		unaccent \
		uuid-ossp \
		; do
		(make -C contrib/${contrib} -s -j ${CLANDRO_PKG_MAKE_PROCESSES} install)
	done
}
