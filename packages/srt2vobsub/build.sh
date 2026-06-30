CLANDRO_PKG_HOMEPAGE=https://srt2vobsub.sourceforge.io/
CLANDRO_PKG_DESCRIPTION="A command-line tool that generates a pair of .idx/.sub subtitle files from a textual subtitles file"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.0"
CLANDRO_PKG_REVISION=8
CLANDRO_PKG_SRCURL="https://downloads.sourceforge.net/srt2vobsub/srt2vobsub-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=5f59319b300dc8629adf6debf94529f3f71ad8cc34bad5ead53a3cfc8d613c12
CLANDRO_PKG_DEPENDS="bdsup2sub, ffmpeg, fontconfig-utils, imagemagick, mediainfo, python, python-pip"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_PYTHON_TARGET_DEPS="chardet, srt, wand"

clandro_step_make_install() {
	install -Dm700 -T srt2vobsub.py $CLANDRO_PREFIX/bin/srt2vobsub
	install -Dm600 -t $CLANDRO_PREFIX/share/man/man1 srt2vobsub.1.gz
	install -Dm600 -t $CLANDRO_PREFIX/share/doc/$CLANDRO_PKG_NAME \
		README defaults.conf langcodes.txt srt2vobsub.html
}
