CLANDRO_PKG_HOMEPAGE=https://odin-lang.org/
CLANDRO_PKG_DESCRIPTION="The Odin programming language"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2022.04
CLANDRO_PKG_SRCURL=https://github.com/odin-lang/Odin/archive/refs/tags/dev-${CLANDRO_PKG_VERSION//./-}.tar.gz
CLANDRO_PKG_SHA256=42983d411902e837792f3cf4c60871da7be67a0b8c23d92a31ac6a069a8fc5c3
CLANDRO_PKG_DEPENDS="libiconv, libllvm"

# ```
# [...]/src/gb/gb.h:6754:2: error: "gb_rdtsc not supported"
# #error "gb_rdtsc not supported"
#  ^
# ```
CLANDRO_PKG_EXCLUDED_ARCHES="arm"

clandro_step_pre_configure() {
	if [ "$CLANDRO_PKG_API_LEVEL" -lt 28 ]; then
		CPPFLAGS+=" -Daligned_alloc=memalign"
	fi
	LDFLAGS+=" -lLLVM -liconv"
}

clandro_step_make() {
	for s in src/main.cpp src/libtommath.cpp; do
		$CXX $CPPFLAGS $CXXFLAGS -c $CLANDRO_PKG_SRCDIR/$s
	done
	$CXX $CXXFLAGS main.o libtommath.o -o odin $LDFLAGS
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin odin
}
