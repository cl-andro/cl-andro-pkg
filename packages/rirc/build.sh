CLANDRO_PKG_HOMEPAGE=https://github.com/rcr/rirc
CLANDRO_PKG_DESCRIPTION="A terminal IRC client in C"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.1.7"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://github.com/rcr/rirc/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=b354d9859015809c4e5ef695c84110f96966351687cdb67b246a963e86d7602b
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_DEPENDS="ca-certificates, mbedtls"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_post_get_source() {
	# Avoid duplicate definition of `struct user` (defined in <sys/user.h>):
	find . -type f -name '*.[ch]' | xargs -n 1 \
		sed -i -E 's/(struct user)($|[^_])/\1_\2/g'
	sed -i 's:CC       = cc::g' $CLANDRO_PKG_SRCDIR/Makefile
	sed -i 's:CFLAGS   =:CFLAGS   +=:g' $CLANDRO_PKG_SRCDIR/Makefile
	sed -i 's:LDFLAGS  =:LDFLAGS  +=:g' $CLANDRO_PKG_SRCDIR/Makefile
	sed -i "s:\$(DESTDIR)\$(PREFIX):${CLANDRO_PREFIX}:" $CLANDRO_PKG_SRCDIR/Makefile
}

clandro_step_pre_configure() {
	CPPFLAGS+=" -DMBEDTLS_ALLOW_PRIVATE_ACCESS"
	CFLAGS+=" $CPPFLAGS"
	LDFLAGS+=" -lmbedtls -lmbedx509 -lmbedcrypto"
}

clandro_step_configure() {
	make config.h
}
