CLANDRO_PKG_HOMEPAGE=https://transmissionbt.com/
CLANDRO_PKG_DESCRIPTION="Easy, lean and powerful BitTorrent client"
# with OpenSSL linking exception:
CLANDRO_PKG_LICENSE="GPL-2.0, GPL-3.0"
CLANDRO_PKG_LICENSE_FILE="COPYING, licenses/gpl-2.0.txt, licenses/gpl-3.0.txt"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.1.1"
CLANDRO_PKG_SRCURL=git+https://github.com/transmission/transmission
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="latest-release-tag"
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
CLANDRO_PKG_GIT_BRANCH=$CLANDRO_PKG_VERSION
CLANDRO_PKG_DEPENDS="libc++, libcurl, libevent, libpsl, miniupnpc, natpmpc, openssl"
CLANDRO_PKG_SUGGESTS="jackett"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DENABLE_GTK=OFF
-DENABLE_QT=OFF
-DENABLE_TESTS=OFF
-DENABLE_NLS=OFF
"
# transmission already puts timestamps in the info printed to stdout so no need for svlogd -tt,
# therefore we override the transmission/log run script
CLANDRO_PKG_SERVICE_SCRIPT=(
	"transmission" 'exec transmission-daemon -f 2>&1'
	"transmission/log" 'mkdir -p "$LOGDIR/sv/transmission"\nexec svlogd "$LOGDIR/sv/transmission"'
)

clandro_step_pre_configure() {
	LDFLAGS+=" -llog"
}
