CLANDRO_PKG_HOMEPAGE=https://github.com/sqlcipher/sqlcipher
CLANDRO_PKG_DESCRIPTION="SQLCipher is an SQLite extension that provides 256 bit AES encryption of database files"
CLANDRO_PKG_LICENSE="BSD"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.15.0"
CLANDRO_PKG_SRCURL="https://github.com/sqlcipher/sqlcipher/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=21f5dfb2558a2a87740bb060ba75aadfec2e6119e08a87c3546c54751395a28d
CLANDRO_PKG_DEPENDS="libedit, openssl"
CLANDRO_PKG_BUILD_DEPENDS="tcl"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
# will overwrite libsqlite during installation
CLANDRO_PKG_ON_DEVICE_BUILD_NOT_SUPPORTED=true
# --enable-editline --disable-readline
# prevents
# error: 'regparm' is not valid on this platform
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--with-tempstore=yes
--enable-editline
--disable-readline
--enable-fts3
--enable-fts4
--enable-fts5
--enable-rtree
--enable-session
--with-tcl=${CLANDRO__PREFIX__LIB_DIR}
TCLLIBDIR=${CLANDRO__PREFIX__LIB_DIR}/tcl8.6/sqlite
"

clandro_step_pre_configure() {
	# CPPFLAGS and LDFLAGS as directed by README.md
	CPPFLAGS+=" -DSQLCIPHER_OMIT_LOG_DEVICE"
	CPPFLAGS+=" -DSQLITE_HAS_CODEC"
	CPPFLAGS+=" -DSQLITE_EXTRA_INIT=sqlcipher_extra_init"
	CPPFLAGS+=" -DSQLITE_EXTRA_SHUTDOWN=sqlcipher_extra_shutdown"
	LDFLAGS+=" -lcrypto"
}

# See: https://github.com/termux/termux-packages/issues/23268#issuecomment-2685308408
# (some packages do not accept '--rpath' or '--rpath-hack' configure arguments)
# Error: Unknown option --rpath-hack
clandro_step_configure() {
	"$CLANDRO_PKG_SRCDIR"/configure \
		--prefix="$CLANDRO_PREFIX" \
		--libexecdir="$CLANDRO_PREFIX/libexec" \
		--libdir="$CLANDRO__PREFIX__LIB_DIR" \
		--includedir="$CLANDRO__PREFIX__INCLUDE_DIR" \
		--sbindir="$CLANDRO_PREFIX/bin" \
		--disable-static \
		$CLANDRO_PKG_EXTRA_CONFIGURE_ARGS
}

clandro_step_post_massage() {
	# Rename files from sqlite3 to sqlcipher to prevent file collisons
	# based on the precedent being set by LigurOS, NixOS
	# https://gitlab.com/liguros/liguros-repo/-/blob/2406209f428ab349fc33209834caf1a7a0477fda/dev-db/sqlcipher/sqlcipher-4.12.0.ebuild#L70
	local sql_version="$(cat "$CLANDRO_PKG_SRCDIR"/VERSION)"
	mv bin/{sqlite3,sqlcipher}
	mv include/{sqlite3,sqlcipher}.h
	mv include/{sqlite3ext,sqlcipherext}.h
	mv lib/lib{sqlite3,sqlcipher}.so
	mv lib/lib{sqlite3,sqlcipher}.so.0
	mv lib/lib{sqlite3,sqlcipher}.so."$sql_version"
	mv lib/pkgconfig/{sqlite3,sqlcipher}.pc
	mv share/man/man1/{sqlite3,sqlcipher}.1.gz
	sed -i s/-lsqlite3/-lsqlcipher/ lib/pkgconfig/sqlcipher.pc
}
