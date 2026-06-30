CLANDRO_PKG_HOMEPAGE=https://www.sqlite.org
CLANDRO_PKG_DESCRIPTION="Library implementing a self-contained and transactional SQL database engine"
CLANDRO_PKG_LICENSE="Public Domain"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.53.1"
_SQLITE_YEAR=2026
CLANDRO_PKG_SRCURL=https://www.sqlite.org/${_SQLITE_YEAR}/sqlite-src-$(sed 's/\./''/; s/\./0/' <<< "$CLANDRO_PKG_VERSION")00.zip
CLANDRO_PKG_SHA256=1b2b5755d9064c4d5d1b0bf5307b48b089963e291c40cc7351318aa1b61c460e
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="zlib"
CLANDRO_PKG_BUILD_DEPENDS="tcl"
CLANDRO_PKG_BREAKS="libsqlite-dev"
CLANDRO_PKG_REPLACES="libsqlite-dev"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--enable-fts3
--enable-fts4
--enable-fts5
--enable-readline
--enable-rtree
--enable-session
--with-tcl=$CLANDRO_PREFIX/lib
--with-tclsh=$(command -v tclsh)
"

clandro_step_pre_configure() {
	CPPFLAGS+=" -Werror"
	CPPFLAGS+=" -DSQLITE_ENABLE_DBSTAT_VTAB=1"
	CPPFLAGS+=" -DSQLITE_ENABLE_COLUMN_METADATA=1"
	CPPFLAGS+=" -DSQLITE_ENABLE_UPDATE_DELETE_LIMIT=1"
	CPPFLAGS+=" -DSQLITE_ENABLE_UNLOCK_NOTIFY=1"
	CPPFLAGS+=" -DSQLITE_ENABLE_FTS3_PARENTHESIS"
	CPPFLAGS+=" -DSQLITE_ENABLE_RBU"
	CPPFLAGS+=" -DSQLITE_ENABLE_GEOPOLY"
	LDFLAGS+=" -lm"
	export TCL_CONFIG_SH="$CLANDRO_PREFIX/lib/tclConfig.sh"
	export TCLLIBDIR="$CLANDRO_PREFIX/lib"
}

# See: https://github.com/termux/termux-packages/issues/23268#issuecomment-2685308408
clandro_step_configure() {
	"$CLANDRO_PKG_SRCDIR"/configure \
		--prefix="$CLANDRO_PREFIX" \
		$CLANDRO_PKG_EXTRA_CONFIGURE_ARGS
}

clandro_step_make_install() {
	make install INSTALL.strip=/usr/bin/install
	mkdir -p "$CLANDRO_PKG_TMPDIR/libsqlite${CLANDRO_PKG_VERSION}"
	make tclextension-install DESTDIR="$CLANDRO_PKG_TMPDIR/libsqlite${CLANDRO_PKG_VERSION}" OPTS="-lm"

	# Move the TCL extension files into their proper place
	find "$CLANDRO_PKG_TMPDIR/libsqlite${CLANDRO_PKG_VERSION}" -name "libsqlite${CLANDRO_PKG_VERSION}.so" \
		-exec install -vDm700 "{}" "${CLANDRO_PREFIX}/lib/sqlite3/libtclsqlite3.so" \;
	find "$CLANDRO_PKG_TMPDIR/libsqlite${CLANDRO_PKG_VERSION}" -name pkgIndex.tcl \
		-exec install -vDm600 "{}" "${CLANDRO_PREFIX}/lib/sqlite3/pkgIndex.tcl" \;
}
