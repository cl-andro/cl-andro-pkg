CLANDRO_PKG_HOMEPAGE=https://dettus.net/dMagnetic
CLANDRO_PKG_DESCRIPTION="Interpreter for classic text adventure games and interactive fiction"
CLANDRO_PKG_LICENSE="BSD 2-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.37
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://dettus.net/dMagnetic/dMagnetic_${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=ad812bb515bc972e23930d643d5abeaed971d550768b1b3f371bd0f72c3c2e89
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_GROUPS="games"

clandro_step_host_build() {
	cd $CLANDRO_PKG_BUILDDIR
	make -j $CLANDRO_PKG_MAKE_PROCESSES dMagnetic
	mv dMagnetic $CLANDRO_PKG_HOSTBUILD_DIR/
	make clean
}

clandro_step_post_configure() {
	# find our host-built dMagnetic
	export PATH=$CLANDRO_PKG_HOSTBUILD_DIR:$PATH
}

clandro_step_post_make_install() {
	sed "s%@CLANDRO_PREFIX@%$CLANDRO_PREFIX%g" \
		$CLANDRO_PKG_BUILDER_DIR/magnetic-scrolls.in \
		> $CLANDRO_PREFIX/bin/magnetic-scrolls
	chmod 700 $CLANDRO_PREFIX/bin/magnetic-scrolls
}
