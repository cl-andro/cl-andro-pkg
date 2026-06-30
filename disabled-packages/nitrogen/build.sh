CLANDRO_PKG_HOMEPAGE=http://projects.l3ib.org/nitrogen/
CLANDRO_PKG_DESCRIPTION="Background browser and setter for X windows"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.6.1
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://github.com/l3ib/nitrogen/releases/download/${CLANDRO_PKG_VERSION}/nitrogen-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=f40213707b7a3be87e556f65521cef8795bd91afda13dfac8f00c3550375837d
CLANDRO_PKG_DEPENDS="libc++, gtkmm2, gtk2"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	CFLAGS+=" -I${CLANDRO_PREFIX}/include"
	# Fix "error: no member named bind2nd in namespace std" (bind2nd was removed in c++17):
	CXXFLAGS+=" -std=c++14"
	autoreconf -fi
}
