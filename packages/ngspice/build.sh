CLANDRO_PKG_HOMEPAGE=https://ngspice.sourceforge.net/
CLANDRO_PKG_DESCRIPTION="A mixed-level/mixed-signal circuit simulator"
CLANDRO_PKG_LICENSE="BSD 3-Clause, LGPL-2.1"
CLANDRO_PKG_LICENSE_FILE="COPYING"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="46"
CLANDRO_PKG_SRCURL=https://github.com/imr/ngspice/archive/refs/tags/ngspice-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=8dded3ba456f0ff806cf8538c9133d26d3816db963e8aeffd949518584fef237
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--enable-cider
--enable-openmp
--enable-xspice
--with-x=no
--with-readline=yes
"
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS="
--enable-cider
--enable-xspice
--with-x=no
"
CLANDRO_PKG_DEPENDS="fftw, libc++, ncurses, readline"
CLANDRO_PKG_GROUPS="science"

clandro_step_host_build() {
	autoreconf -fi $CLANDRO_PKG_SRCDIR
	$CLANDRO_PKG_SRCDIR/configure $CLANDRO_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS

	# compiles ngspice codemodel preprocessor
	cd src/xspice/cmpp && make -j $CLANDRO_PKG_MAKE_PROCESSES
}

clandro_step_pre_configure() {
	LDFLAGS+=" -fopenmp -static-openmp"

	# ERROR: ./lib/ngspice/ivlng.vpi contains undefined symbols: pow
	LDFLAGS+=" -lm"

	autoreconf -fi
}

clandro_step_post_configure() {
	cp -ru $CLANDRO_PKG_HOSTBUILD_DIR/src/xspice/cmpp \
		src/xspice
	cd src/xspice/cmpp && cp cmpp build/cmpp

	# prevents building again on copied precompiled cmpp.
	touch -d "next hour" *
}
