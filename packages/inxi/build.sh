CLANDRO_PKG_HOMEPAGE=https://smxi.org/site/about.htm#inxi
CLANDRO_PKG_DESCRIPTION="Full featured CLI system information tool"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.3.40-1"
CLANDRO_PKG_SRCURL=https://codeberg.org/smxi/inxi/archive/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=b3f307f06c3b969bd65151d39729b97a767af42fddd3d9bab971135c0e7cd873
# NOTE: auto-update first checks whether the latest version matches this regex and then
# replaces the last `.` with '-'. Thus, it shouldn't update to wrong version.
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+(-|\.)\d+"
# Sometimes repology returns ds.ds.ds.ds instead of ds.ds.ds-ds, fix that:
CLANDRO_PKG_UPDATE_VERSION_SED_REGEXP="s/\.([0-9]+)$/-\1/"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="perl"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_PLATFORM_INDEPENDENT=true

clandro_step_make_install() {
	install -Dm700 -t "$CLANDRO_PREFIX/bin/" inxi
	install -Dm600 -t "$CLANDRO_PREFIX/share/man/man1/" inxi.1
}
