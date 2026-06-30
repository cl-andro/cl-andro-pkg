CLANDRO_PKG_HOMEPAGE=https://www.bitlbee.org/
CLANDRO_PKG_DESCRIPTION="An IRC to other chat networks gateway"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=3.6-1
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://github.com/bitlbee/bitlbee/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=81c6357fe08a8941221472e3790e2b351e3a8a41f9af0cf35395fdadbc8ac6cb
CLANDRO_PKG_DEPENDS="ca-certificates, glib, libgcrypt, libgnutls"

clandro_step_pre_configure() {
	LDFLAGS+=" -lgcrypt"
}

clandro_step_configure_autotools() {
	sh "$CLANDRO_PKG_SRCDIR/configure" \
		--prefix=$CLANDRO_PREFIX \
		$CLANDRO_PKG_EXTRA_CONFIGURE_ARGS
}

clandro_step_post_make_install() {
	make install-etc install-dev
}

clandro_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$CLANDRO_PREFIX/bin/sh
	mkdir -p $CLANDRO_PREFIX/var/lib/bitlbee
	EOF
}
