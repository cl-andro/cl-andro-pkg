CLANDRO_PKG_HOMEPAGE=https://id3lib.sourceforge.net/
CLANDRO_PKG_DESCRIPTION="A software library for manipulating ID3v1/v1.1 and ID3v2 tags"
CLANDRO_PKG_LICENSE="LGPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=3.8.3
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_SRCURL=https://downloads.sourceforge.net/id3lib/id3lib-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=2749cc3c0cd7280b299518b1ddf5a5bcfe2d1100614519b68702230e26c7d079
CLANDRO_PKG_DEPENDS="libc++, libiconv, zlib"

clandro_step_pre_configure() {
	for f in examples/demo_*.cpp; do
		sed -i -e 's/^int main( unsigned int /int main( int /g' $f
	done

	_ID3LIB_MAJOR=$(awk -F= '/^ID3LIB_MAJOR_/ { print $2 }' configure.in)
	_ID3LIB_MINOR=$(awk -F= '/^ID3LIB_MINOR_/ { print $2 }' configure.in)

	aclocal
	automake --add-missing
	autoreconf -fi

	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}

clandro_step_post_make_install() {
	_LIBID3_SO=libid3-${_ID3LIB_MAJOR}.${_ID3LIB_MINOR}.so
	if [ ! -e $CLANDRO_PREFIX/lib/$_LIBID3_SO ]; then
		echo "ERROR: $_LIBID3_SO not found."
		return 1
	fi
	ln -sf $_LIBID3_SO $CLANDRO_PREFIX/lib/libid3.so
}
