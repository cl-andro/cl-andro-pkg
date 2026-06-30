CLANDRO_PKG_HOMEPAGE=https://www.w3.org/Tools/HTML-XML-utils/
CLANDRO_PKG_DESCRIPTION="A number of simple utilities for manipulating HTML and XML files"
CLANDRO_PKG_LICENSE="custom"
CLANDRO_PKG_LICENSE_FILE="COPYING"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="8.7"
CLANDRO_PKG_SRCURL=https://www.w3.org/Tools/HTML-XML-utils/html-xml-utils-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=888a31631a7a70308bb2f333e077d0416f4bb78317f8697ffb4a95187f677301
CLANDRO_PKG_DEPENDS="libcurl, libiconv, libidn2"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	autoreconf -fi

	CPPFLAGS+=" -D__USE_BSD"
}
