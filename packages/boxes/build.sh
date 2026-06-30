CLANDRO_PKG_HOMEPAGE=https://boxes.thomasjensen.com/
CLANDRO_PKG_DESCRIPTION="A command line filter program which draws ASCII art boxes around your input text"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.3.1"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/ascii-boxes/boxes/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=0834e54c0d5293950412729cabf16ada3076a804eacba8f1aacc5381dfe3a96a
CLANDRO_PKG_DEPENDS="libunistring, ncurses, pcre2"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_CONFFILES="
share/boxes/boxes-config
"

clandro_step_make() {
	make -j $CLANDRO_PKG_MAKE_PROCESSES \
		CC="$CC" \
		CFLAGS_ADDTL="$CFLAGS $CPPFLAGS" \
		LDFLAGS_ADDTL="$LDFLAGS"
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin out/boxes
	install -Dm600 -t $CLANDRO_PREFIX/share/man/man1 doc/boxes.1
	install -Dm600 -t $CLANDRO_PREFIX/share/boxes boxes-config
}

# Do not use /archive/ but /archive/refs/tags/ as SRCURL
# https://github.com/ascii-boxes/boxes/archive/v2.2.1.tar.gz
# the given path has multiple possibilities: #<Git::Ref:0x00007f3805df9d98>, #<Git::Ref:0x00007f3805df94d8>
