CLANDRO_PKG_HOMEPAGE=https://fossil.instinctive.eu/libsoldout/index
CLANDRO_PKG_DESCRIPTION="Flexible C library and tools for markdown"
CLANDRO_PKG_LICENSE="ISC"
CLANDRO_PKG_MAINTAINER="@flosnvjx"
CLANDRO_PKG_VERSION="1.4"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL="https://fossil.instinctive.eu/libsoldout-$CLANDRO_PKG_VERSION.tar.bz2"
CLANDRO_PKG_SHA256=92a8cf53f27a6eaa489473c37f6a3c32181ca5b75afea952fd15f4d168a4ffac
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_MAKE_ARGS="-f GNUmakefile"

clandro_step_make_install() {
	install -dm700 "$CLANDRO_PREFIX"/{lib,bin,include/$CLANDRO_PKG_NAME,share/{doc/$CLANDRO_PKG_NAME,man/man{1,3}}}
	install -pm600 -t "$CLANDRO_PREFIX"/share/doc/"$CLANDRO_PKG_NAME" README CHANGES
	install -pm600 -t "$CLANDRO_PREFIX/share/man/man3" *.3
	install -pm600 -t "$CLANDRO_PREFIX/share/man/man1" $(ls *.1 | grep -v '\.so')
	install -pm600 -t "$CLANDRO_PREFIX/include/$CLANDRO_PKG_NAME" *.h
	install -pm700 -t "$CLANDRO_PREFIX/lib" libsoldout.{a,so,so.*}
	install -pm700 -t "$CLANDRO_PREFIX/bin" mkd2{html,latex,man}
}
