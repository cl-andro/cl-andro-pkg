CLANDRO_PKG_HOMEPAGE=https://www.haproxy.org/
CLANDRO_PKG_DESCRIPTION="The Reliable, High Performance TCP/HTTP Load Balancer"
CLANDRO_PKG_LICENSE="GPL-2.0, LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.3.9"
CLANDRO_PKG_SRCURL=https://www.haproxy.org/download/${CLANDRO_PKG_VERSION%.*}/src/haproxy-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=f31e8e68db077cc0956f4ed3ff7a1ec637aa5e348c6d1c5cd2163e7afeb1b9e6
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="lua53, openssl, pcre2, zlib"
CLANDRO_PKG_BUILD_IN_SRC=true

CLANDRO_PKG_CONFFILES="etc/haproxy/haproxy.cfg"

clandro_step_pre_configure() {
	CFLAGS+=" -fwrapv"
}

clandro_step_make() {
	CC="$CC -Wl,-rpath=$CLANDRO_PREFIX/lib -Wl,--enable-new-dtags"

	make \
		V=1 \
		CPU=generic \
		TARGET=generic \
		USE_GETADDRINFO=1 \
		USE_LUA=1 \
		LUA_INC="$CLANDRO_PREFIX/include/lua5.3" \
		LUA_LIB="$CLANDRO_PREFIX/lib" \
		LUA_LIB_NAME=lua5.3 \
		USE_OPENSSL=1 \
		USE_PCRE2=1 \
		PCRE2_CONFIG="$CLANDRO_PREFIX/bin/pcre2-config" \
		USE_ZLIB=1 \
		ADDINC="$CPPFLAGS" \
		CFLAGS="$CFLAGS" \
		LDFLAGS="$LDFLAGS"
}

clandro_step_post_make_install() {
	mkdir -p "$CLANDRO_PREFIX"/etc/haproxy
	sed -e "s|@CLANDRO_PREFIX@|${CLANDRO_PREFIX}|g" \
		"$CLANDRO_PKG_BUILDER_DIR"/haproxy.cfg.in \
		> "$CLANDRO_PREFIX"/etc/haproxy/haproxy.cfg

	mkdir -p "$CLANDRO_PREFIX"/share/haproxy/examples/errorfiles
	install -m600 examples/*.cfg "$CLANDRO_PREFIX"/share/haproxy/examples/
	install -m600 examples/errorfiles/*.http \
		"$CLANDRO_PREFIX"/share/haproxy/examples/errorfiles/
}
