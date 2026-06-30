CLANDRO_PKG_HOMEPAGE=https://mate-desktop.org/
CLANDRO_PKG_DESCRIPTION="Common MATE utilities for viewing disk usage, logs and fonts, taking screenshots, managing dictionaries and searching files"
CLANDRO_PKG_LICENSE="GPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.28.1"
CLANDRO_PKG_SRCURL="https://github.com/mate-desktop/mate-utils/releases/download/v$CLANDRO_PKG_VERSION/mate-utils-$CLANDRO_PKG_VERSION.tar.xz"
CLANDRO_PKG_SHA256=0dbfbee7a966ddf114e62c6d49ea8f35c1d4bf14d275a1369c324e36ff84ab9a
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="mate-desktop, gettext, libcanberra, libgtop, libsm, libxml2"
CLANDRO_PKG_SUGGESTS="mate-panel"
CLANDRO_PKG_BUILD_DEPENDS="autoconf-archive, glib, inkscape, mate-common, mate-panel, python"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--sysconfdir=$CLANDRO_PREFIX/etc
--disable-maintainer-flags
--disable-disk-image-mounter
"
CLANDRO_PKG_CONFFILES="
etc/mate-system-log.conf
"

clandro_step_post_make_install() {
	# populate a custom configuration file in syslog.conf-like format
	# with log file locations that are likely to exist in Termux
	mkdir -p "$CLANDRO_PREFIX/etc"
	if [[ "$CLANDRO_PACKAGE_FORMAT" == "debian" ]]; then
		cat <<- EOF > "$CLANDRO_PREFIX/etc/mate-system-log.conf"
			$CLANDRO_PREFIX/var/log/apt/history.log
			$CLANDRO_PREFIX/var/log/apt/term.log
			$CLANDRO_PREFIX/var/log/aptitude
			$CLANDRO_PREFIX/var/log/alternatives.log
			$CLANDRO_PREFIX/var/log/oma/history
			$CLANDRO_PREFIX/var/log/dpkg.log
		EOF
	fi

	if [[ "$CLANDRO_PACKAGE_FORMAT" == "pacman" ]]; then
		cat <<- EOF > "$CLANDRO_PREFIX/etc/mate-system-log.conf"
			$CLANDRO_PREFIX/var/log/pacman.log
		EOF
	fi
}
