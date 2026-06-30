CLANDRO_PKG_HOMEPAGE=https://www.lua.org/
CLANDRO_PKG_DESCRIPTION="Shared library for the Lua interpreter (v5.4.x)"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=5.4.8
CLANDRO_PKG_REVISION=6
CLANDRO_PKG_SRCURL=https://www.lua.org/ftp/lua-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=4f18ddae154e793e46eeab727c59ef1c0c0c2b744e7b94219710d76f530629ae
CLANDRO_PKG_EXTRA_MAKE_ARGS=linux-readline
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_BREAKS="liblua-dev, liblua54"
CLANDRO_PKG_REPLACES="liblua-dev, liblua54"
CLANDRO_PKG_BUILD_DEPENDS="readline"

clandro_step_configure() {
	sed -e "s/%VER%/${CLANDRO_PKG_VERSION%.*}/g;s/%REL%/${CLANDRO_PKG_VERSION}/g" \
		-e "s|@CLANDRO_PREFIX@|$CLANDRO_PREFIX|" \
		"$CLANDRO_PKG_BUILDER_DIR"/lua.pc.in > lua.pc
}

clandro_step_pre_configure() {
	OLDAR="$AR"
	AR+=" rcu"
	CFLAGS+=" -fPIC -DLUA_COMPAT_5_3"
	export MYLDFLAGS=$LDFLAGS
}

clandro_step_make_install() {
	make \
		TO_BIN="lua5.4 luac5.4" \
		TO_LIB="liblua5.4.so liblua5.4.so.5.4 liblua5.4.so.${CLANDRO_PKG_VERSION} liblua5.4.a" \
		INSTALL_DATA="cp -d" \
		INSTALL_TOP="$CLANDRO_PREFIX" \
		INSTALL_INC="$CLANDRO_PREFIX/include/lua5.4" \
		INSTALL_MAN="$CLANDRO_PREFIX/share/man/man1" \
		install
	install -Dm600 lua.pc "$CLANDRO_PREFIX"/lib/pkgconfig/lua54.pc
	ln -sf lua54.pc "$CLANDRO_PREFIX"/lib/pkgconfig/lua5.4.pc
	ln -sf lua54.pc "$CLANDRO_PREFIX"/lib/pkgconfig/lua-5.4.pc
}

clandro_step_post_make_install() {
	cd "$CLANDRO_PREFIX"/share/man/man1
	mv -f lua.1 lua5.4.1
	mv -f luac.1 luac5.4.1
	export AR="$OLDAR"
}
