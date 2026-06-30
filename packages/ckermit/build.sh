CLANDRO_PKG_HOMEPAGE=https://www.kermitproject.org/ckermit.html
CLANDRO_PKG_DESCRIPTION="A combined network and serial communication software package"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_LICENSE_FILE="COPYING.TXT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=9.0.302
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=https://www.kermitproject.org/ftp/kermit/archives/cku${CLANDRO_PKG_VERSION##*.}.tar.gz
CLANDRO_PKG_SHA256=0d5f2cd12bdab9401b4c836854ebbf241675051875557783c332a6a40dac0711
CLANDRO_PKG_DEPENDS="libcrypt"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_MAKE_ARGS="-e linuxa"

clandro_extract_src_archive() {
	local file="$CLANDRO_PKG_CACHEDIR/$(basename "${CLANDRO_PKG_SRCURL}")"
	mkdir -p "$CLANDRO_PKG_SRCDIR"
	tar xf "$file" -C "$CLANDRO_PKG_SRCDIR" --strip-components=0
}

clandro_step_pre_configure() {
	CFLAGS+=" -fPIC -Wno-error=implicit-int"
	export KFLAGS="-DNOGETUSERSHELL -UNOTIMEH -DTIMEH -DUSE_FILE_R"
	LDFLAGS+=" -lcrypt"
	export LNKFLAGS="$LDFLAGS"
}

clandro_step_make_install() {
	mkdir -p $CLANDRO_PREFIX/bin
	mkdir -p $CLANDRO_PREFIX/share/man
	make prefix=$CLANDRO_PREFIX manroot=$CLANDRO_PREFIX/share install
	install -Dm600 -t $CLANDRO_PREFIX/share/doc/ckermit/ *.txt
}
