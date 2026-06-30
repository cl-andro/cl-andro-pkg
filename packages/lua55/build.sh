CLANDRO_PKG_HOMEPAGE=https://www.lua.org/
CLANDRO_PKG_DESCRIPTION="Shared library for the Lua interpreter (v5.5.x)"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=5.5.0
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://www.lua.org/ftp/lua-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=57ccc32bbbd005cab75bcc52444052535af691789dba2b9016d5c50640d68b3d
CLANDRO_PKG_EXTRA_MAKE_ARGS=linux
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_BREAKS="liblua-dev, liblua55"
CLANDRO_PKG_REPLACES="liblua-dev, liblua55"
CLANDRO_PKG_BUILD_DEPENDS="readline"

clandro_step_configure() {
	sed -e "s/%VER%/${CLANDRO_PKG_VERSION%.*}/g;s/%REL%/${CLANDRO_PKG_VERSION}/g" \
		-e "s|@CLANDRO_PREFIX@|$CLANDRO_PREFIX|" \
		"$CLANDRO_PKG_BUILDER_DIR"/lua.pc.in > lua.pc
}

clandro_step_pre_configure() {
	OLDAR="$AR"
	AR+=" rcu"
	CFLAGS+=" -fPIC"
	export MYLDFLAGS=$LDFLAGS
}

clandro_step_make_install() {
	make \
		TO_BIN="lua5.5 luac5.5" \
		TO_LIB="liblua5.5.so liblua5.5.so.5.5 liblua5.5.so.${CLANDRO_PKG_VERSION} liblua5.5.a" \
		INSTALL_DATA="cp -d" \
		INSTALL_TOP="$CLANDRO_PREFIX" \
		INSTALL_INC="$CLANDRO_PREFIX/include/lua5.5" \
		INSTALL_MAN="$CLANDRO_PREFIX/share/man/man1" \
		install
	install -Dm600 lua.pc "$CLANDRO_PREFIX"/lib/pkgconfig/lua55.pc
	ln -sf lua55.pc "$CLANDRO_PREFIX"/lib/pkgconfig/lua5.5.pc
	ln -sf lua55.pc "$CLANDRO_PREFIX"/lib/pkgconfig/lua-5.5.pc
}

clandro_step_post_make_install() {
	cd "$CLANDRO_PREFIX"/share/man/man1
	mv -f lua.1 lua5.5.1
	mv -f luac.1 luac5.5.1
	export AR="$OLDAR"
}
