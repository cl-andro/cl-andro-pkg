CLANDRO_PKG_HOMEPAGE=https://racket-lang.org
CLANDRO_PKG_DESCRIPTION="Full-spectrum programming language going beyond Lisp and Scheme"
CLANDRO_PKG_LICENSE="GPL-3.0, LGPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="9.1"
CLANDRO_PKG_SRCURL=https://www.cs.utah.edu/plt/installers/${CLANDRO_PKG_VERSION}/racket-minimal-${CLANDRO_PKG_VERSION}-src-builtpkgs.tgz
CLANDRO_PKG_SHA256=b5046925519b38d5e021e3003a0bea5a8db660ee1271138bc5b4f40329059789
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libffi, libiconv"
CLANDRO_PKG_NO_DEVELSPLIT=true
CLANDRO_PKG_HOSTBUILD=true

CLANDRO_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS="
--enable-bc
--enable-bconly
"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--enable-bc
--enable-bconly
--enable-racket=$CLANDRO_PKG_HOSTBUILD_DIR/bc/racketcgc
--enable-libs
--disable-shared
--disable-gracket
--enable-libffi"

clandro_step_host_build() {
	"$CLANDRO_PKG_SRCDIR"/src/configure \
		$CLANDRO_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS
	make -j "$CLANDRO_PKG_MAKE_PROCESSES"
}

clandro_step_pre_configure() {
	CPPFLAGS+=" -I$CLANDRO_PKG_SRCDIR/src/bc/include -I$CLANDRO_PKG_BUILDDIR/bc"
	LDFLAGS+=" -liconv -llog"
	export CLANDRO_PKG_SRCDIR="$CLANDRO_PKG_SRCDIR/src"
}

# See: https://github.com/termux/termux-packages/issues/25761
clandro_step_configure() {
	"$CLANDRO_PKG_SRCDIR"/configure \
		--prefix="$CLANDRO_PREFIX" \
		--host=$CLANDRO_HOST_PLATFORM \
		$CLANDRO_PKG_EXTRA_CONFIGURE_ARGS
}
