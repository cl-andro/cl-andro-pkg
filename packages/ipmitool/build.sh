CLANDRO_PKG_HOMEPAGE=https://github.com/ipmitool/ipmitool
CLANDRO_PKG_DESCRIPTION="Command-line interface to IPMI-enabled devices"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.8.19
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/ipmitool/ipmitool/archive/refs/tags/IPMITOOL_${CLANDRO_PKG_VERSION//./_}.tar.gz
CLANDRO_PKG_SHA256=48b010e7bcdf93e4e4b6e43c53c7f60aa6873d574cbd45a8d86fa7aaeebaff9c
CLANDRO_PKG_DEPENDS="openssl, readline"

clandro_step_pre_configure() {
	sh bootstrap
}

clandro_pkg_auto_update() {
	local latest_tag="$(clandro_github_api_get_tag "${CLANDRO_PKG_SRCURL}")"
	[[ -z "${latest_tag}" ]] && clandro_error_exit "Unable to get tag from ${CLANDRO_PKG_SRCURL}"
	clandro_pkg_upgrade_version "$(sed -n 's/^IPMITOOL_\([0-9]\+\)_\([0-9]\+\)_\([0-9]\+\)$/\1.\2.\3/p' <<< ${latest_tag})"
}
