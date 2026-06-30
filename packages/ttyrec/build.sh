CLANDRO_PKG_HOMEPAGE=http://0xcc.net/ttyrec/
CLANDRO_PKG_DESCRIPTION="Terminal recorder and player"
CLANDRO_PKG_LICENSE="BSD"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.0.8
CLANDRO_PKG_REVISION=8
CLANDRO_PKG_SRCURL=http://0xcc.net/ttyrec/ttyrec-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=ef5e9bf276b65bb831f9c2554cd8784bd5b4ee65353808f82b7e2aef851587ec
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	CFLAGS+=" -Dset_progname=setprogname $LDFLAGS"
}

clandro_step_make_install() {
	cp ttyrec ttyplay ttytime $CLANDRO_PREFIX/bin
	mkdir -p $CLANDRO_PREFIX/share/man/man1
	cp ttyrec.1 ttyplay.1 ttytime.1 $CLANDRO_PREFIX/share/man/man1
}
