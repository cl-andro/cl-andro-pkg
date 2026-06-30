CLANDRO_PKG_HOMEPAGE=https://ta-lib.org/
CLANDRO_PKG_DESCRIPTION="Technical analysis library with indicators like ADX"
CLANDRO_PKG_LICENSE="BSD"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.5.0
CLANDRO_PKG_SRCURL=https://github.com/TA-Lib/ta-lib/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=43e3761cf6bc4a5ab6c675268a09a72ea074643c6e06defe5e4b4e51eae1ea50
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_BREAKS="talib"
CLANDRO_PKG_REPLACES="talib"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	LDFLAGS+=" -lm"
	autoreconf -fi
}
