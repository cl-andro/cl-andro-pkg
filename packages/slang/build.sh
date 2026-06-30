CLANDRO_PKG_HOMEPAGE=https://www.jedsoft.org/slang/
CLANDRO_PKG_DESCRIPTION="S-Lang is a powerful interpreted language"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.3.3
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://www.jedsoft.org/releases/slang/slang-$CLANDRO_PKG_VERSION.tar.bz2
CLANDRO_PKG_SHA256=f9145054ae131973c61208ea82486d5dd10e3c5cdad23b7c4a0617743c8f5a18
CLANDRO_PKG_DEPENDS="libiconv, libpng, pcre, oniguruma, zlib"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_CONFFILES="etc/slsh.rc"

# Supports only make -j1
CLANDRO_PKG_MAKE_PROCESSES=1

clandro_step_pre_configure() {
	# Fix: version script assignment of 'SLANG2' to symbol 'SLang_Rline_Quit' failed: symbol not defined
	LDFLAGS+=" -Wl,-undefined-version"
}
