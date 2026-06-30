CLANDRO_PKG_HOMEPAGE=https://www.lua.org
CLANDRO_PKG_DESCRIPTION="Shared library for the Lua interpreter (v5.1.x)"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=5.1.5
CLANDRO_PKG_REVISION=7
CLANDRO_PKG_SRCURL=https://www.lua.org/ftp/lua-$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=2640fc56a795f29d28ef15e13c34a47e223960b0240e8cb0a82d9b0738695333
CLANDRO_PKG_BUILD_DEPENDS="readline"
CLANDRO_PKG_BREAKS="liblua51"
CLANDRO_PKG_REPLACES="liblua51"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	CFLAGS+=" -fPIC"
}

clandro_step_configure() {
	sed -e "s/%VER%/${CLANDRO_PKG_VERSION%.*}/g;s/%REL%/${CLANDRO_PKG_VERSION}/g" \
		-e "s|@CLANDRO_PREFIX@|$CLANDRO_PREFIX|" \
		"$CLANDRO_PKG_BUILDER_DIR"/lua.pc.in > lua.pc
}

clandro_step_make() {
	make -j "$CLANDRO_PKG_MAKE_PROCESSES" \
		MYCFLAGS="$CFLAGS" \
		MYLDFLAGS="$LDFLAGS" \
		CC="$CC" \
		CXX="$CXX" \
		linux
}

clandro_step_make_install() {
	make \
		TO_BIN="lua5.1 luac5.1" \
		TO_LIB="liblua5.1.so liblua5.1.so.5.1 liblua5.1.so.${CLANDRO_PKG_VERSION} liblua5.1.a" \
		INSTALL_DATA="cp -d" \
		INSTALL_TOP="$CLANDRO_PREFIX" \
		INSTALL_INC="$CLANDRO_PREFIX/include/lua5.1" \
		INSTALL_MAN="$CLANDRO_PREFIX/share/man/man1" \
		install
	install -Dm600 lua.pc "$CLANDRO_PREFIX"/lib/pkgconfig/lua51.pc
	ln -sf lua51.pc "$CLANDRO_PREFIX"/lib/pkgconfig/lua5.1.pc
	ln -sf lua51.pc "$CLANDRO_PREFIX"/lib/pkgconfig/lua-5.1.pc

	mv -f "$CLANDRO_PREFIX"/share/man/man1/lua.1 "$CLANDRO_PREFIX"/share/man/man1/lua5.1.1
	mv -f "$CLANDRO_PREFIX"/share/man/man1/luac.1 "$CLANDRO_PREFIX"/share/man/man1/luac5.1.1
}
