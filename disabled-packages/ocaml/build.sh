CLANDRO_PKG_HOMEPAGE=https://ocaml.org
CLANDRO_PKG_DESCRIPTION="Programming language supporting functional, imperative and object-oriented styles"
CLANDRO_PKG_LICENSE="custom"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=4.02.3
CLANDRO_PKG_SRCURL=https://caml.inria.fr/pub/distrib/ocaml-${CLANDRO_PKG_VERSION:0:4}/ocaml-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=83c6697e135b599a196fd7936eaf8a53dd6b8f3155a796d18407b56f91df9ce3
CLANDRO_PKG_DEPENDS="pcre, openssl, libuuid"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_configure() {
	./configure -prefix $CLANDRO_PREFIX -mandir $CLANDRO_PREFIX/share/man/man1 -cc "$CC $CFLAGS $CPPFLAGS $LDFLAGS" \
		-host $CLANDRO_HOST_PLATFORM
}
