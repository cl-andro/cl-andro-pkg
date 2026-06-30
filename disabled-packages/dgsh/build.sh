CLANDRO_PKG_HOMEPAGE=https://www.spinellis.gr/sw/dgsh/
CLANDRO_PKG_DESCRIPTION="The directed graph shell"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.0.0
CLANDRO_PKG_SRCURL=https://github.com/dspinellis/dgsh/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=22a7f2794e1287a46b03ce38c27a1d9349d1c66535c30e065c8783626555c76c
CLANDRO_PKG_BUILD_DEPENDS="check"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	CLANDRO_PKG_SRCDIR=$CLANDRO_PKG_SRCDIR/core-tools
	CLANDRO_PKG_BUILDDIR=$CLANDRO_PKG_SRCDIR
	cd $CLANDRO_PKG_BUILDDIR

	sed -i -e 's/#.*$//g' src/dgsh-elf.s
	cp $CLANDRO_PKG_BUILDER_DIR/s_cpow.c src/

	touch ../.config
	mkdir -p m4
	autoreconf -fi
}
