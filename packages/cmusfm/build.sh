CLANDRO_PKG_HOMEPAGE=https://github.com/Arkq/cmusfm
CLANDRO_PKG_DESCRIPTION="Last.fm standalone scrobbler for the cmus music player"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.5.0
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/Arkq/cmusfm/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=17aae8fc805e79b367053ad170854edceee5f4c51a9880200d193db9862d8363
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_DEPENDS="libandroid-spawn, libcurl, openssl"

clandro_step_pre_configure() {
	LDFLAGS+=" -landroid-spawn"
	autoreconf --force --install
}
