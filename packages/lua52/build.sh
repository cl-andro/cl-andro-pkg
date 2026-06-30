CLANDRO_PKG_HOMEPAGE=https://www.lua.org
CLANDRO_PKG_DESCRIPTION="Shared library for the Lua interpreter (v5.2.x)"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=5.2.4
CLANDRO_PKG_REVISION=15
CLANDRO_PKG_SRCURL=https://www.lua.org/ftp/lua-$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=b9e2e4aad6789b3b63a056d442f7b39f0ecfca3ae0f1fc0ae4e9614401b69f4b
CLANDRO_PKG_BREAKS="liblua52-dev, liblua52"
CLANDRO_PKG_REPLACES="liblua52-dev, liblua52"
CLANDRO_PKG_BUILD_DEPENDS="readline"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_configure() {
	sed -e "s/%VER%/${CLANDRO_PKG_VERSION%.*}/g;s/%REL%/${CLANDRO_PKG_VERSION}/g" \
		-e "s|@CLANDRO_PREFIX@|$CLANDRO_PREFIX|" \
		"$CLANDRO_PKG_BUILDER_DIR"/lua.pc.in > lua.pc
}

clandro_step_make() {
	make -j "$CLANDRO_PKG_MAKE_PROCESSES" \
		MYCFLAGS="$CFLAGS -fPIC" \
		MYLDFLAGS="$LDFLAGS" \
		CC="$CC" \
		CXX="$CXX" \
		linux
}

clandro_step_make_install() {
	make \
		TO_BIN="lua5.2 luac5.2" \
		TO_LIB="liblua5.2.so liblua5.2.so.5.2 liblua5.2.so.${CLANDRO_PKG_VERSION} liblua5.2.a" \
		INSTALL_DATA="cp -d" \
		INSTALL_TOP="$CLANDRO_PREFIX" \
		INSTALL_INC="$CLANDRO_PREFIX/include/lua5.2" \
		INSTALL_MAN="$CLANDRO_PREFIX/share/man/man1" \
		install
	install -Dm600 lua.pc "$CLANDRO_PREFIX"/lib/pkgconfig/lua52.pc
	ln -sf lua52.pc "$CLANDRO_PREFIX"/lib/pkgconfig/lua5.2.pc
	ln -sf lua52.pc "$CLANDRO_PREFIX"/lib/pkgconfig/lua-5.2.pc

	mv -f "$CLANDRO_PREFIX"/share/man/man1/lua.1 "$CLANDRO_PREFIX"/share/man/man1/lua5.2.1
	mv -f "$CLANDRO_PREFIX"/share/man/man1/luac.1 "$CLANDRO_PREFIX"/share/man/man1/luac5.2.1
}
