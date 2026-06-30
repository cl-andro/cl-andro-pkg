CLANDRO_PKG_HOMEPAGE="https://sourceforge.net/projects/tinyxml/"
CLANDRO_PKG_DESCRIPTION="A simple, small, C++ XML parser"
CLANDRO_PKG_LICENSE="ZLIB"
CLANDRO_PKG_LICENSE_FILE="readme.txt"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.6.2"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL="http://downloads.sourceforge.net/tinyxml/tinyxml_${CLANDRO_PKG_VERSION//./_}.tar.gz"
CLANDRO_PKG_SHA256=15bdfdcec58a7da30adc87ac2b078e4417dbe5392f3afb719f9ba6d062645593
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_DEPENDS="libc++"

clandro_step_make_install() {
	install -m 0755 libtinyxml.so \
		"$CLANDRO_PREFIX/lib/"
	install -m 0644 tinyxml.h tinystr.h \
		"$CLANDRO_PREFIX/include/"
}
