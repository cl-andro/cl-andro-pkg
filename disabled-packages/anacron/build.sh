CLANDRO_PKG_HOMEPAGE=https://anacron.sourceforge.net/
CLANDRO_PKG_DESCRIPTION="A periodic command scheduler"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.3
CLANDRO_PKG_SRCURL=https://downloads.sourceforge.net/anacron/anacron-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=5ceee6f22cd089bdaf1c0841200dbe5726babaf9e2c432bb17c1fc95da5ca99f
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_MAKE_ARGS="PREFIX=$CLANDRO_PREFIX"

clandro_step_post_get_source() {
	cp $CLANDRO_PKG_BUILDER_DIR/obstack.h ./
}

clandro_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$CLANDRO_PREFIX/bin/sh
	mkdir -p $CLANDRO_PREFIX/var/spool/anacron
	EOF
}
