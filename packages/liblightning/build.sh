CLANDRO_PKG_HOMEPAGE=https://www.gnu.org/software/lightning/
CLANDRO_PKG_DESCRIPTION="A library to aid in making portable programs that compile assembly code at run time"
CLANDRO_PKG_LICENSE="GPL-3.0, LGPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.2.3"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://mirrors.kernel.org/gnu/lightning/lightning-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=c045c7a33a00affbfeb11066fa502c03992e474a62ba95977aad06dbc14c6829
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="zlib"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_func_ffsl=yes
"
