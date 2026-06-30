CLANDRO_PKG_HOMEPAGE=https://sourceforge.net/projects/dict/
CLANDRO_PKG_DESCRIPTION="Provides many low-level data structures which are helpful for writing compilers"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.4.7"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://downloads.sourceforge.net/project/dict/libmaa/libmaa-${CLANDRO_PKG_VERSION}/libmaa-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=4e01a9ebc5d96bc9284b6706aa82bddc2a11047fa9bd02e94cf8753ec7dcb98e
CLANDRO_PKG_AUTO_UPDATE=false # This package requires mkcmake which is not accessible while building packages
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make() {
	cd ${CLANDRO_PKG_SRCDIR}/maa
	awk -f arggram2c < arggram.txt > arggram.c
	$CC -shared -o libmaa.so \
		xmalloc.c hash.c set.c stack.c list.c error.c memory.c string.c \
		debug.c flags.c maa.c prime.c bit.c timer.c arg.c pr.c sl.c \
		base64.c base26.c source.c parse-concrete.c text.c log.c \
		-DMAA_MAJOR=4 -DMAA_MINOR=0 -DMAA_TEENY=0 \
		-DHAVE_HEADER_SYS_RESOURCE_H=1 -DSIZEOF_LONG=__SIZEOF_LONG__ \
		$CFLAGS $LDFLAGS -fPIC
	cd -
}

clandro_step_make_install() {
	install -Dm0755 -t "$CLANDRO_PREFIX"/lib "${CLANDRO_PKG_SRCDIR}"/maa/libmaa.so
	install -Dm0644 -t "$CLANDRO_PREFIX"/include "${CLANDRO_PKG_SRCDIR}"/maa/maa.h
}
