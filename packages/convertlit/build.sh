# Dependency for ebook-tools
CLANDRO_PKG_HOMEPAGE='http://www.convertlit.com/'
CLANDRO_PKG_DESCRIPTION='An extractor/converter for .LIT eBooks'
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.8"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=http://www.convertlit.com/clit${CLANDRO_PKG_VERSION/./}src.zip
CLANDRO_PKG_SHA256=d70a85f5b945104340d56f48ec17bcf544e3bb3c35b1b3d58d230be699e557ba
CLANDRO_PKG_BUILD_DEPENDS="libtommath-static"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_get_source() {
	clandro_download "$CLANDRO_PKG_SRCURL" "$CLANDRO_PKG_CACHEDIR/${CLANDRO_PKG_SRCURL##*/}" "$CLANDRO_PKG_SHA256"
	unzip "$CLANDRO_PKG_CACHEDIR/${CLANDRO_PKG_SRCURL##*/}" -d $CLANDRO_PKG_SRCDIR
}

clandro_step_configure() {
	# Link to correct libtommath and use system LDFLAGS
	sed -e 's|../libtommath-0.30/libtommath.a|'$CLANDRO_PREFIX'/lib/libtommath.a ${LDFLAGS}|' -i clit${CLANDRO_PKG_VERSION/./}/Makefile
	# Use system CFLAGS
	sed -e 's|CFLAGS=-O3 -Wall|CFLAGS+=|' -i lib/Makefile
	sed -e 's|CFLAGS=-funsigned-char -Wall -O2|CFLAGS+=|' -i clit${CLANDRO_PKG_VERSION/./}/Makefile
	sed -e 's|gcc -o|${CC} -o|' -i clit${CLANDRO_PKG_VERSION/./}/Makefile
}

clandro_step_make() {
	export CFLAGS+=" -Wno-implicit-function-declaration"
	make -C lib
	make -C clit${CLANDRO_PKG_VERSION/./}
}

clandro_step_make_install() {
	install -Dm755 "clit${CLANDRO_PKG_VERSION/./}/clit" -t "$CLANDRO_PREFIX/bin"
}
