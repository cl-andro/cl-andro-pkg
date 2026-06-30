CLANDRO_PKG_HOMEPAGE=https://redis.io/
CLANDRO_PKG_DESCRIPTION="In-memory data structure store used as a database, cache and message broker"
CLANDRO_PKG_LICENSE="AGPL-V3"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1:8.6.1"
CLANDRO_PKG_SRCURL=https://download.redis.io/releases/redis-${CLANDRO_PKG_VERSION:2}.tar.gz
CLANDRO_PKG_SHA256=6873fc933eeb7018aa329e868beac7228695f50c0d46f236a4ff1a6d7f7bb5b6
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libandroid-execinfo, libandroid-glob"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_CONFFILES="etc/redis.conf"
CLANDRO_PKG_BREAKS="valkey"
CLANDRO_PKG_CONFLICTS="valkey"
CLANDRO_PKG_REPLACES="valkey"

clandro_step_pre_configure() {
	export PREFIX=$CLANDRO_PREFIX
	export USE_JEMALLOC=no

	CPPFLAGS+=" -DHAVE_BACKTRACE"
	CFLAGS+=" $CPPFLAGS"
	LDFLAGS+=" -landroid-execinfo -landroid-glob"
}

clandro_step_post_make_install() {
	install -Dm600 $CLANDRO_PKG_SRCDIR/redis.conf $CLANDRO_PREFIX/etc/redis.conf
}
