CLANDRO_PKG_HOMEPAGE=https://i3wm.org/i3status/
CLANDRO_PKG_DESCRIPTION="Generates status bar to use with i3bar"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.15"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://i3wm.org/i3status/i3status-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=6c67f52cae4f139df764ad1cc736562be0f97750791bc212b53f34c06eaf2205
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libandroid-glob, libconfuse, libnl, pulseaudio, yajl"
CLANDRO_PKG_CONFFILES="etc/i3status.conf"

clandro_step_pre_configure() {
	LDFLAGS+=" -landroid-glob"
}
