CLANDRO_PKG_HOMEPAGE=https://openil.sourceforge.net/
CLANDRO_PKG_DESCRIPTION="A cross-platform image library utilizing a simple syntax"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.8.0
CLANDRO_PKG_REVISION=7
CLANDRO_PKG_SRCURL=https://github.com/DentonW/DevIL/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=52129f247b26fcb5554643c9e6bbee75c4b9717735fdbf3c6ebff08cee38ad37
CLANDRO_PKG_DEPENDS="libc++, libjasper, libjpeg-turbo, libpng, libtiff, littlecms"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_POLICY_VERSION_MINIMUM=3.5
"

clandro_step_pre_configure() {
	CXXFLAGS+=" -Wno-error=register"
	CLANDRO_PKG_SRCDIR+="/DevIL"
}
