CLANDRO_PKG_HOMEPAGE=http://www.mbayer.de/html2text/
CLANDRO_PKG_DESCRIPTION="Utility that converts HTML documents into plain text"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1:2.4.0"
CLANDRO_PKG_SRCURL=https://gitlab.com/grobian/html2text/-/archive/v${CLANDRO_PKG_VERSION:2}/html2text-v${CLANDRO_PKG_VERSION:2}.tar.gz
CLANDRO_PKG_SHA256=8c8689b1bc33677168b5f530865b0935f73ab5ec2341cf81122c452047f1b464
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++, libiconv"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	CXX="$CXX $CXXFLAGS $CPPFLAGS $LDFLAGS"
	mkdir -p $CLANDRO_PREFIX/share/man/man1
	aclocal
	autoconf
	automake --force-missing --add-missing
}
