CLANDRO_PKG_HOMEPAGE=https://www.lua.org/
CLANDRO_PKG_DESCRIPTION="Shared library for the Lua interpreter (v5.3.x)"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=5.3.6
CLANDRO_PKG_REVISION=6
CLANDRO_PKG_SRCURL=https://www.lua.org/ftp/lua-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=fc5fd69bb8736323f026672b1b7235da613d7177e72558893a0bdcd320466d60
CLANDRO_PKG_EXTRA_MAKE_ARGS=linux
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_BREAKS="liblua-dev, liblua53"
CLANDRO_PKG_REPLACES="liblua-dev, liblua53"
CLANDRO_PKG_BUILD_DEPENDS="readline"

clandro_step_configure() {
	sed -e "s/%VER%/${CLANDRO_PKG_VERSION%.*}/g;s/%REL%/${CLANDRO_PKG_VERSION}/g" \
		-e "s|@CLANDRO_PREFIX@|$CLANDRO_PREFIX|" \
		"$CLANDRO_PKG_BUILDER_DIR"/lua.pc.in > lua.pc
}

clandro_step_pre_configure() {
	OLDAR="$AR"
	AR+=" rcu"
	CFLAGS+=" -fPIC -DLUA_COMPAT_5_2 -DLUA_COMPAT_UNPACK"
	export MYLDFLAGS=$LDFLAGS
}

clandro_step_make_install() {
	make \
		TO_BIN="lua5.3 luac5.3" \
		TO_LIB="liblua5.3.so liblua5.3.so.5.3 liblua5.3.so.${CLANDRO_PKG_VERSION} liblua5.3.a" \
		INSTALL_DATA="cp -d" \
		INSTALL_TOP="$CLANDRO_PREFIX" \
		INSTALL_INC="$CLANDRO_PREFIX/include/lua5.3" \
		INSTALL_MAN="$CLANDRO_PREFIX/share/man/man1" \
		install
	install -Dm600 lua.pc "$CLANDRO_PREFIX"/lib/pkgconfig/lua53.pc
	ln -sf lua53.pc "$CLANDRO_PREFIX"/lib/pkgconfig/lua5.3.pc
	ln -sf lua53.pc "$CLANDRO_PREFIX"/lib/pkgconfig/lua-5.3.pc
}

clandro_step_post_make_install() {
	cd "$CLANDRO_PREFIX"/share/man/man1
	mv -f lua.1 lua5.3.1
	mv -f luac.1 luac5.3.1
	export AR="$OLDAR"
}
