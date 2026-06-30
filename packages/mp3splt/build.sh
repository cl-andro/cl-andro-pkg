CLANDRO_PKG_HOMEPAGE=https://mp3splt.sourceforge.net
CLANDRO_PKG_DESCRIPTION="Utility to split mp3, ogg vorbis and FLAC files without decoding"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.6.2
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=http://prdownloads.sourceforge.net/mp3splt/mp3splt-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=3ec32b10ddd8bb11af987b8cd1c76382c48d265d0ffda53041d9aceb1f103baa
CLANDRO_PKG_DEPENDS="libmp3splt"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--mandir=$CLANDRO_PREFIX/share/man"

clandro_step_post_configure() {
	cd $CLANDRO_PKG_SRCDIR/src
	sed -i -e 's/BEOS/ANDROID/g' freedb.c
	touch langinfo.h
}
