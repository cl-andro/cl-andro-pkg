CLANDRO_PKG_HOMEPAGE=https://www.colm.net/open-source/colm/
CLANDRO_PKG_DESCRIPTION="COmputer Language Machinery"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.14.7
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://www.colm.net/files/colm/colm-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=6037b31c358dda6f580f7321f97a182144a8401c690b458fcae055c65501977d
CLANDRO_PKG_DEPENDS="libc++"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_HOSTBUILD=true

clandro_step_post_get_source() {
	rm -f src/config.h src/defs.h
	ln -sf . src/colm
}

clandro_step_host_build() {
	local srcdir=$CLANDRO_PKG_SRCDIR
	${srcdir}/configure
	local f
	for f in ${srcdir}/src/*.lm; do
		ln -sf ${f} src/$(basename ${f})
	done
	make -j $CLANDRO_PKG_MAKE_PROCESSES
}

clandro_step_pre_configure() {
	export PATH=$CLANDRO_PKG_HOSTBUILD_DIR/src:$PATH

	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}
