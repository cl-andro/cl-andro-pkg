# shellcheck shell=bash
clandro_pkg_auto_update() {
	if [[ -n "${__CACHED_TAG:-}" ]]; then
		clandro_pkg_upgrade_version "${__CACHED_TAG}"
		return $?
	fi

	# Example:
	# https://github.com/vim/vim/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
	#            _="https:"
	#            _=""
	# project_host="github.com"
	#            _="vim/vim/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
	local project_host
	IFS='/' read -r _ _ project_host _ <<< "${CLANDRO_PKG_SRCURL}"

	# gitlab.gnome.org started responding to API requests originating from
	# GitHub Actions with HTTP 403 errors in January 2026.
	# Example command failing in GitHub Actions:
	# curl https://gitlab.gnome.org/api/v4/projects/GNOME%2Fvte/releases/permalink/latest
	# See: https://github.com/termux/termux-packages/issues/28242
	if [[ -z "${CLANDRO_PKG_UPDATE_METHOD}" ]]; then
		if [[ "${project_host}" == "github.com" ]]; then
			CLANDRO_PKG_UPDATE_METHOD="github"
		elif [[ "$CLANDRO_PKG_SRCURL" == *"/-/archive/"* && "$CLANDRO_PKG_SRCURL" != *"gitlab.gnome.org"* ]]; then
			CLANDRO_PKG_UPDATE_METHOD="gitlab"
		else
			CLANDRO_PKG_UPDATE_METHOD="repology"
		fi
	fi

	case "${CLANDRO_PKG_UPDATE_METHOD}" in
		github)
			if [[ "${project_host}" != "${CLANDRO_PKG_UPDATE_METHOD}.com" ]]; then
				clandro_error_exit <<-EndOfError
					source url's hostname is not ${CLANDRO_PKG_UPDATE_METHOD}.com, but has been
					configured to use ${CLANDRO_PKG_UPDATE_METHOD}'s method.
				EndOfError
			fi
			clandro_github_auto_update
		;;
		gitlab)
			clandro_gitlab_auto_update
		;;
		repology)
			clandro_repology_auto_update
		;;
		*)
			clandro_error_exit <<-EndOfError
				wrong value '${CLANDRO_PKG_UPDATE_METHOD}' for CLANDRO_PKG_UPDATE_METHOD.
				Can be 'github', 'gitlab' or 'repology'
			EndOfError
		;;
	esac
}
