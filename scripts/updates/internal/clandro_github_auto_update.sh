# shellcheck shell=bash
# Default algorithm to use for packages hosted on github.com
clandro_github_auto_update() {
	local latest_tag
	latest_tag="$(clandro_github_api_get_tag)"

	if [[ -z "${latest_tag}" ]]; then
		clandro_error_exit "Unable to get tag from ${CLANDRO_PKG_SRCURL}"
	fi
	clandro_pkg_upgrade_version "${latest_tag}"
}
