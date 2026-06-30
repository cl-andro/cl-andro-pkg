CLANDRO_PKG_HOMEPAGE=https://dev.yorhel.nl/ncdu
CLANDRO_PKG_DESCRIPTION="Disk usage analyzer"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="Joshua Kahn <tom@termux.dev> & @clandro"
CLANDRO_PKG_VERSION="1.22"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://dev.yorhel.nl/download/ncdu-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=0ad6c096dc04d5120581104760c01b8f4e97d4191d6c9ef79654fa3c691a176b
CLANDRO_PKG_DEPENDS="libandroid-support, ncurses"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--with-shell=${CLANDRO_PREFIX}/bin/sh
"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP='1\.\d+(\.\d+)?'

clandro_pkg_auto_update() {
	local latest_release
	latest_release="$(git ls-remote --tags https://code.blicky.net/yorhel/ncdu.git \
	| grep -oP "refs/tags/v\K${CLANDRO_PKG_UPDATE_VERSION_REGEXP}$" \
	| sort -V \
	| tail -n1)"

	if [[ "${latest_release}" == "${CLANDRO_PKG_VERSION}" ]]; then
		echo "INFO: No update needed. Already at version '${CLANDRO_PKG_VERSION}'."
		return
	fi

	clandro_pkg_upgrade_version "${latest_release}"
}
