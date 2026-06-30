CLANDRO_PKG_HOMEPAGE=https://sarnold.github.io/cccc/
CLANDRO_PKG_DESCRIPTION="Source code counter and metrics tool for C++, C, and Java"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=3.2.0
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/sarnold/cccc/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=c03b29d45f1acb6f669b6d6d193dcdf5603f8c2758f0fb4bc1eeacef92ecb78a
CLANDRO_PKG_DEPENDS="libc++"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_MAKE_ARGS="cccc"
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_MAKE_PROCESSES=1

clandro_step_host_build() {
	find $CLANDRO_PKG_SRCDIR -mindepth 1 -maxdepth 1 -exec cp -a \{\} ./ \;

	export CC="gcc -m${CLANDRO_ARCH_BITS}"
	export CCC="g++ -m${CLANDRO_ARCH_BITS}"

	sh build_posixgcc.sh
}

clandro_step_pre_configure() {
	export CCC="$CXX"
	CFLAGS+=" $CPPFLAGS"
	CLANDRO_PKG_EXTRA_MAKE_ARGS+="
		ANTLR=$CLANDRO_PKG_HOSTBUILD_DIR/pccts/bin/antlr
		DLG=$CLANDRO_PKG_HOSTBUILD_DIR/pccts/bin/dlg
		"
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin cccc/cccc
}
