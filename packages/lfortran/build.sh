CLANDRO_PKG_HOMEPAGE=https://lfortran.org/
CLANDRO_PKG_DESCRIPTION="A modern open-source interactive Fortran compiler"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.63.0"
CLANDRO_PKG_SRCURL=https://github.com/lfortran/lfortran/releases/download/v$CLANDRO_PKG_VERSION/lfortran-$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=e5ad61bc0571ec572dec542913858a9d9a6142ae5023ffc9517e1b0dc15da98c
CLANDRO_PKG_DEPENDS="clang, libandroid-complex-math, libc++, ncurses, zlib, zstd"
CLANDRO_PKG_BUILD_DEPENDS="libkokkos, libkokkos-static, libllvm-static"
CLANDRO_PKG_SUGGESTS="libkokkos"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_SHARED_LIBS=ON
-DCMAKE_INSTALL_LIBDIR=lib/lfortran
-DLLVM_DIR=$CLANDRO_PREFIX/lib/cmake/llvm
-DWITH_BFD=no
-DWITH_LIBUNWIND=no
-DWITH_KOKKOS=yes
-DWITH_LLVM=yes
-DWITH_LSP=yes
-DWITH_PREBUILT_FORTRAN=$CLANDRO_PKG_HOSTBUILD_DIR/src/bin/lfortran
-DWITH_RUNTIME_LIBRARY=yes
"
CLANDRO_PKG_HOSTBUILD=true

# ```
# [...]/src/lfortran/parser/parser_stype.h:97:1: error: static_assert failed
# due to requirement
# 'sizeof(LFortran::YYSTYPE) == sizeof(LFortran::Vec<LFortran::AST::ast_t *>)'
# static_assert(sizeof(YYSTYPE) == sizeof(Vec<AST::ast_t*>));
# ^             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ```
# Furthermore libkokkos does not support ILP32
CLANDRO_PKG_EXCLUDED_ARCHES="arm, i686"

clandro_step_host_build() {
	clandro_setup_cmake

	cmake $CLANDRO_PKG_SRCDIR
	make -j $CLANDRO_PKG_MAKE_PROCESSES
}

clandro_step_pre_configure() {
	LDFLAGS+=" -landroid-complex-math -lm"
}
