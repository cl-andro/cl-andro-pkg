CLANDRO_PKG_HOMEPAGE=https://www.colm.net/open-source/ragel/
CLANDRO_PKG_DESCRIPTION="Compiles finite state machines from regular languages into executable C, C++, Objective-C, or D code"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=7.0.4
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://www.colm.net/files/ragel/ragel-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=84b1493efe967e85070c69e78b04dc55edc5c5718f9d6b77929762cb2abed278
CLANDRO_PKG_DEPENDS="colm, libc++"
CLANDRO_PKG_BUILD_DEPENDS="colm-static"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--with-colm=$CLANDRO_PREFIX
--disable-manual
"

clandro_step_host_build() {
	local COLM_BUILD_SH=$CLANDRO_SCRIPTDIR/packages/colm/build.sh
	local COLM_SRCURL=$(. $COLM_BUILD_SH; echo $CLANDRO_PKG_SRCURL)
	local COLM_SHA256=$(. $COLM_BUILD_SH; echo $CLANDRO_PKG_SHA256)
	local COLM_TARFILE=$CLANDRO_PKG_CACHEDIR/$(basename $COLM_SRCURL)
	clandro_download $COLM_SRCURL $COLM_TARFILE $COLM_SHA256
	tar xf $COLM_TARFILE --strip-components=1
	rm -f src/config.h src/defs.h
	ln -sf . src/colm
	sed -i '/^SUBDIRS =/s/ test//' Makefile.in
	./configure
	make -j $CLANDRO_PKG_MAKE_PROCESSES
}

clandro_step_pre_configure() {
	local colm_bin_dir=$CLANDRO_PKG_HOSTBUILD_DIR/src
	echo "Applying configure.diff"
	sed "s|@COLM_BIN_DIR@|${colm_bin_dir}|g" \
		$CLANDRO_PKG_BUILDER_DIR/configure.diff | patch --silent -p1
	local libgcc=$($CC -print-libgcc-file-name)
	export LIBS="-L$(dirname ${libgcc}) -l:$(basename ${libgcc})"
}
