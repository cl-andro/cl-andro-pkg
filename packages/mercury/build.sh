CLANDRO_PKG_HOMEPAGE=https://www.mercurylang.org/
CLANDRO_PKG_DESCRIPTION="A logic/functional programming language"
CLANDRO_PKG_LICENSE="GPL-2.0, LGPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="22.01.8"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://dl.mercurylang.org/release/mercury-srcdist-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=a097e8cc8eca0152ed9527c1caf73e5c9c83f6ada1d313a25b80fe79072fbad8
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libandroid-sysv-semaphore-static"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-csharp-grade
--disable-java-grade
--disable-debug-grades
--disable-par-grades
--disable-prof-grades
--disable-trail-grades
mercury_cv_sigaction_field=sa_sigaction
mercury_cv_sigcontext_struct_2arg=no
mercury_cv_sigcontext_struct_3arg=no
mercury_cv_pc_access=no
mercury_cv_siginfo_t=yes
mercury_cv_is_bigender=no
mercury_cv_is_littleender=yes
mercury_cv_can_do_pending_io=yes
mercury_cv_gcc_labels=yes
mercury_cv_asm_labels=yes
mercury_cv_gcc_model_fast=no
mercury_cv_gcc_model_reg=no
mercury_cv_cannot_use_structure_assignment=no
"
CLANDRO_PKG_EXTRA_MAKE_ARGS="THREAD_LIBS="

clandro_step_host_build() {
	find $CLANDRO_PKG_SRCDIR -mindepth 1 -maxdepth 1 -exec cp -a \{\} ./ \;
	./configure \
		CC="gcc -m${CLANDRO_ARCH_BITS}" CXX="g++ -m${CLANDRO_ARCH_BITS}" \
		$CLANDRO_PKG_EXTRA_CONFIGURE_ARGS
	make -j $CLANDRO_PKG_MAKE_PROCESSES
}

clandro_step_pre_configure() {
	_BUILD_UTIL=$CLANDRO_PKG_HOSTBUILD_DIR/util
	_BUILD_COMPILER=$CLANDRO_PKG_HOSTBUILD_DIR/compiler
	export MERCURY_MKINIT=$_BUILD_UTIL/mkinit
	export MERCURY_DEMANGLER=$_BUILD_UTIL/mdemangle
	export MERCURY_COMPILER=$_BUILD_COMPILER/mercury_compile
	export MERCURY_ALL_LOCAL_C_INCL_DIRS=-I$CLANDRO_PREFIX/include

	mkdir -p _bin
	ln -sf $MERCURY_MKINIT _bin/
	PATH=$CLANDRO_PKG_BUILDDIR/_bin:$PATH

	find "$CLANDRO_PKG_SRCDIR" -name '*.c' -o -name '*.m' | \
		xargs -n 1 sed -i \
		-e 's:"/tmp:"'$CLANDRO_PREFIX'/tmp:g' \
		-e 's:"/var/tmp:"'$CLANDRO_PREFIX'/tmp:g'
}

clandro_step_post_configure() {
	sed -i -e 's:^\(LINKER_POST_FLAGS=.*\)"$:\1 '"$CLANDRO_PREFIX"'/lib/libandroid-sysv-semaphore.a":g' \
		$CLANDRO_PKG_SRCDIR/scripts/ml

	sed -i -e 's,\([^A-Za-z0-9_]PATH=\)\.\.,\1'$_BUILD_UTIL':..,g' \
		$CLANDRO_PKG_SRCDIR/Mmakefile
}
