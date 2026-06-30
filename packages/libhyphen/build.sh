CLANDRO_PKG_HOMEPAGE=https://github.com/hunspell/hyphen
CLANDRO_PKG_DESCRIPTION="hyphenation library to use converted TeX hyphenation patterns"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.8.8
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://downloads.sourceforge.net/hunspell/hyphen-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=304636d4eccd81a14b6914d07b84c79ebb815288c76fe027b9ebff6ff24d5705

clandro_step_pre_configure() {
	autoreconf -fvi
}
