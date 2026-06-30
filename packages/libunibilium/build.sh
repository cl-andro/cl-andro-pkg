CLANDRO_PKG_HOMEPAGE=https://github.com/neovim/unibilium
CLANDRO_PKG_DESCRIPTION="Terminfo parsing library"
CLANDRO_PKG_LICENSE="LGPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.1.2"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL="https://github.com/neovim/unibilium/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=370ecb07fbbc20d91d1b350c55f1c806b06bf86797e164081ccc977fc9b3af7a
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BREAKS="libunibilium-dev"
CLANDRO_PKG_REPLACES="libunibilium-dev"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=4

	local a
	for a in LT_CURRENT LT_AGE; do
		local _${a}=$(sed -En 's/^'"${a}"'=([0-9]+).*/\1/p' Makefile.in)
	done
	local v=$(( _LT_CURRENT - _LT_AGE ))
	if [ ! "${_LT_CURRENT}" ] || [ "${v}" != "${_SOVERSION}" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}

clandro_step_pre_configure() {
	rm -f CMakeLists.txt
}

clandro_step_make() {
	return
}

clandro_step_make_install() {
	CFLAGS+=" -DTERMINFO_DIRS=\"$CLANDRO_PREFIX/share/terminfo/\""
	$CC $CFLAGS -c -fPIC unibilium.c -o unibilium.o
	$CC $CFLAGS -c -fPIC uninames.c -o uninames.o
	$CC $CFLAGS -c -fPIC uniutil.c -o uniutil.o
	$CC -shared -fPIC $LDFLAGS -o $CLANDRO_PREFIX/lib/libunibilium.so unibilium.o uninames.o uniutil.o
	cp unibilium.h $CLANDRO_PREFIX/include/

	mkdir -p "$CLANDRO_PREFIX/lib/pkgconfig"
	sed "s|@VERSION@|$CLANDRO_PKG_VERSION|" unibilium.pc.in | \
		sed "s|@INCDIR@|$CLANDRO_PREFIX/include|" | \
		sed "s|@LIBDIR@|$CLANDRO_PREFIX/lib|" > \
		"$CLANDRO_PREFIX/lib/pkgconfig/unibilium.pc"
}
