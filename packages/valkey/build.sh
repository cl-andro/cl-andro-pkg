CLANDRO_PKG_HOMEPAGE=https://valkey.io/
CLANDRO_PKG_DESCRIPTION="In-memory data structure store used as a database, cache and message broker"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="9.0.4"
CLANDRO_PKG_SRCURL="https://github.com/valkey-io/valkey/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=8d65e12cc9edb14d117b56fd33300e7b8cde2c087356de3f055d44689667670b
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libandroid-execinfo, libandroid-glob"
CLANDRO_PKG_CONFFILES="etc/valkey.conf"
CLANDRO_PKG_BREAKS="redis"
CLANDRO_PKG_CONFLICTS="redis"
CLANDRO_PKG_REPLACES="redis"
CLANDRO_PKG_PROVIDES="redis"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_POLICY_VERSION_MINIMUM=3.5
-DBUILD_MALLOC=libc
"

clandro_step_pre_configure() {
	CPPFLAGS+=" -DHAVE_BACKTRACE"
	CFLAGS+=" $CPPFLAGS"
	LDFLAGS+=" -landroid-execinfo -landroid-glob"

	( cd "$CLANDRO_PKG_SRCDIR/src" && ./mkreleasehdr.sh )
}

clandro_step_post_make_install() {
	install -Dm600 "$CLANDRO_PKG_SRCDIR/valkey.conf" "$CLANDRO_PREFIX/etc/valkey.conf"
}
