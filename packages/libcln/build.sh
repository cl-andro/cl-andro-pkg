CLANDRO_PKG_HOMEPAGE=https://www.ginac.de/CLN/
CLANDRO_PKG_DESCRIPTION="CLN is a library for efficient computations with all kinds of numbers in arbitrary precision"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.3.7
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://www.ginac.de/CLN/cln-${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=7c7ed8474958337e4df5bb57ea5176ad0365004cbb98b621765bc4606a10d86b
CLANDRO_PKG_DEPENDS="libc++, libgmp"
CLANDRO_PKG_BREAKS="libcln-dev"
CLANDRO_PKG_REPLACES="libcln-dev"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	if [ $CLANDRO_ARCH = arm ]; then
		# See the following section in INSTALL:
		# "(*) On these platforms, problems with the assembler routines have been
		# reported. It may be best to add "-DNO_ASM" to CPPFLAGS before configuring."
		CPPFLAGS+=" -DNO_ASM"
		CXXFLAGS+=" -fintegrated-as"
	fi

	sed -i -e 's%tests/Makefile %%' configure.ac
	sed -i -e 's%examples/Makefile %%' configure.ac
	sed -i -e 's%benchmarks/Makefile %%' configure.ac

	autoreconf

	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}

clandro_step_post_configure() {
	cd $CLANDRO_PKG_SRCDIR
	sed -i -e 's% tests%%' Makefile
	sed -i -e 's% examples%%' Makefile
	sed -i -e 's% benchmarks%%' Makefile

	sed -i -e '/^#error /d' \
		-e 's/^\(#define int_bitsize\) .*$/\1 32/' \
		-e 's/^\(#define long_bitsize\) .*$/\1 '$CLANDRO_ARCH_BITS'/' \
		-e 's/^\(#define long_long_bitsize\) .*$/\1 64/' \
		include/cln/intparam.h
}
