# shellcheck shell=bash
# Default algorithm to use for packages hosted on gitlab instances.
clandro_gitlab_auto_update() {
	local latest_tag
	latest_tag="$(clandro_gitlab_api_get_tag)"

	if [[ -z "${latest_tag}" ]]; then
		clandro_error_exit "Unable to get tag from ${CLANDRO_PKG_SRCURL}"
	fi
	clandro_pkg_upgrade_version "${latest_tag}"
}
