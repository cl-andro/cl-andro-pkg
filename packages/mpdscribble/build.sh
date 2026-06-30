CLANDRO_PKG_HOMEPAGE=https://www.musicpd.org/clients/mpdscribble/
CLANDRO_PKG_DESCRIPTION="A Music Player Daemon (MPD) client which submits information about tracks being played to a scrobbler"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="Henrik Grimler @Grimler91"
CLANDRO_PKG_VERSION="0.25"
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_SRCURL="https://github.com/MusicPlayerDaemon/mpdscribble/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=ce24145df6657f1d8070c88f6795f567f21ff9126b0740c088f40344fc496b1e
CLANDRO_PKG_DEPENDS="libc++, libcurl, libgcrypt, mpd, libmpdclient, glib"
CLANDRO_PKG_BUILD_DEPENDS="boost, boost-headers"
CLANDRO_PKG_CONFFILES="etc/mpdscribble.conf"
# mpdscribble already puts timestamps in the info printed to stdout so no need for svlogd -tt,
# therefore we override the mpdscribble/log run script
CLANDRO_PKG_SERVICE_SCRIPT=(
	"mpdscribble" "if [ -f \"$CLANDRO_ANDROID_HOME/.mpdscribble/mpdscribble.conf\" ]; then CONFIG=\"$CLANDRO_ANDROID_HOME/.mpdscribble/mpdscribble.conf\"; else CONFIG=\"$CLANDRO_PREFIX/etc/mpdscribble.conf\"; fi\nexec mpdscribble -D --log /proc/self/fd/1 --conf \$CONFIG"
	"mpdscribble/log" 'mkdir -p "$LOGDIR/sv/mpdscribble"\nexec svlogd "$LOGDIR/sv/mpdscribble"'
)
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"

clandro_step_pre_configure() {
	export BOOST_ROOT=$CLANDRO_PREFIX
}

clandro_step_post_make_install () {
	install $CLANDRO_PKG_SRCDIR/doc/mpdscribble.conf $CLANDRO_PREFIX/etc/
}

clandro_step_create_debscripts () {
	echo "#!$CLANDRO_PREFIX/bin/sh" > postinst
	echo "mkdir -p ~/.mpdscribble" >> postinst
	echo "exit 0" >> postinst
	chmod 0755 postinst
}
