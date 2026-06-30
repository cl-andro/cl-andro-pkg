# shellcheck shell=bash
_termux_should_cleanup() {
	local space_available big_package="$1"
	[[ "${big_package}" == "true" ]] && return 0 # true

	if [[ -d "/var/lib/docker" ]]; then
		# Get available space in bytes
		space_available="$(df "/var/lib/docker" | awk 'NR==2 { print $4 * 1024 }')"

		if (( space_available <= CLANDRO_CLEANUP_BUILT_PACKAGES_THRESHOLD )); then
			return 0 # true
		fi
	fi

	return 1 # false
}

clandro_pkg_upgrade_version() {
	if (( $# < 1 )); then
		clandro_error_exit <<-EndUsage
			Usage: ${FUNCNAME[0]} LATEST_VERSION [--skip-version-check]
			Also reports the fully parsed LATEST_VERSION on file descriptor 3
		EndUsage
	fi

	local LATEST_VERSION SKIP_VERSION_CHECK EPOCH
	LATEST_VERSION="$(sort -rV <<< "$1")" # Ensure its sorted in descending version order.
	SKIP_VERSION_CHECK="${2:-}"
	EPOCH="${CLANDRO_PKG_VERSION%%:*}" # If there is no epoch, this will be the full version.
	# Check if it isn't the full version and add ':'.
	if [[ "${EPOCH}" != "${CLANDRO_PKG_VERSION}" ]]; then
		EPOCH="${EPOCH}:"
	else
		EPOCH=""
	fi

	# If needed, filter version numbers using grep regexp.
	if [[ -n "${CLANDRO_PKG_UPDATE_VERSION_REGEXP:-}" ]]; then
		# Extract version numbers.
		local ORIGINAL_LATEST_VERSION="${LATEST_VERSION}"
		LATEST_VERSION="$(grep --max-count=1 -oP "${CLANDRO_PKG_UPDATE_VERSION_REGEXP}" <<< "${LATEST_VERSION}" || :)"
		if [[ -z "${LATEST_VERSION:-}" ]]; then
			clandro_error_exit <<-EndOfError
				ERROR: Failed to filter version numbers for '${CLANDRO_PKG_NAME}'.
				Ensure that '${CLANDRO_PKG_UPDATE_VERSION_REGEXP}' works correctly to match '${ORIGINAL_LATEST_VERSION}'.
			EndOfError
		fi
		unset ORIGINAL_LATEST_VERSION
	fi

	# If needed, filter version numbers using sed regexp.
	if [[ -n "${CLANDRO_PKG_UPDATE_VERSION_SED_REGEXP:-}" ]]; then
		# Extract version numbers.
		local ORIGINAL_LATEST_VERSION="${LATEST_VERSION}"
		LATEST_VERSION="$(sed -E "${CLANDRO_PKG_UPDATE_VERSION_SED_REGEXP}" <<< "${LATEST_VERSION}" || :)"
		if [[ -z "${LATEST_VERSION:-}" ]]; then
			clandro_error_exit <<-EndOfError
				ERROR: Failed to filter version numbers for '${CLANDRO_PKG_NAME}'.
				Ensure that '${CLANDRO_PKG_UPDATE_VERSION_SED_REGEXP}' works correctly to match '${ORIGINAL_LATEST_VERSION}'.
			EndOfError
		fi
		unset ORIGINAL_LATEST_VERSION
	fi

	# Remove any leading non-digits as that would not be a valid version.
	# shellcheck disable=SC2001 # This is something parameter expansion can't handle well, so we use sed.
	LATEST_VERSION="$(sed -e "s/^[^0-9]*//" <<< "$LATEST_VERSION")"

	# Translate "_" into ".": some packages use underscores to separate
	# version numbers, but we require them to be separated by dots.
	LATEST_VERSION="${LATEST_VERSION//_/.}"

	# Translate "-suffix" into "~suffix": "X.Y.Z-suffix" is considered later
	# than X.Y.Z. for it to be considered earlier use "X.Y.Z~suffix".
	for suffix in "rc" "alpha" "beta"; do
		LATEST_VERSION="$(sed -E "s/[-.]?(${suffix}[0-9]*)/~\1/ig" <<< "$LATEST_VERSION")"
	done

	# If FD 3 is open, use it for reporting the fully parsed $LATEST_VERSION
	# If it's not open use the brace group to be able to
	# discard the `3: Bad file descriptor` error silently.
	{ echo "$LATEST_VERSION" >&3; } 2> /dev/null

	if [[ "${SKIP_VERSION_CHECK}" != "--skip-version-check" ]]; then
		if ! clandro_pkg_is_update_needed \
			"${CLANDRO_PKG_VERSION#*:}" "${LATEST_VERSION}"; then
			echo "INFO: No update needed. Already at version '${LATEST_VERSION}'."
			return 0
		fi
	fi

	if [[ -n "${CLANDRO_PKG_UPGRADE_VERSION_DRY_RUN:-}" ]]; then
		return 1
	fi

	if [[ "${BUILD_PACKAGES}" == "false" ]]; then
		echo "INFO: package needs to be updated to ${LATEST_VERSION}."
		return
	fi

	echo "INFO: package being updated to ${LATEST_VERSION}."

	sed \
		-e "s/^\(CLANDRO_PKG_VERSION=\)\(.*\)\$/\1\"${EPOCH}${LATEST_VERSION}\"/g" \
		-e "/CLANDRO_PKG_REVISION=/d" \
		-i "${CLANDRO_PKG_BUILDER_DIR}/build.sh"

	# Update checksum
	if [[ "${CLANDRO_PKG_SHA256[*]}" != "SKIP_CHECKSUM" && "${CLANDRO_PKG_SRCURL:0:4}" != "git+" ]]; then
		echo n | "${CLANDRO_SCRIPTDIR}/scripts/bin/update-checksum" "${CLANDRO_PKG_NAME}" || {
			git checkout -- "${CLANDRO_SCRIPTDIR}"
			git pull --rebase --autostash
			clandro_error_exit "failed to update checksum."
		}
	fi

	echo "INFO: Trying to build package."

	for repo_path in $(jq --raw-output 'del(.pkg_format) | keys | .[]' "${CLANDRO_SCRIPTDIR}/repo.json"); do
		_buildsh_path="${CLANDRO_SCRIPTDIR}/${repo_path}/${CLANDRO_PKG_NAME}/build.sh"
		repo="$(jq --raw-output ".\"${repo_path}\".name" "${CLANDRO_SCRIPTDIR}/repo.json")"
		repo="${repo#"clandro-"}"

		if [[ -f "${_buildsh_path}" ]]; then
			echo "INFO: Package ${CLANDRO_PKG_NAME} exists in ${repo} repo."
			unset _buildsh_path repo_path
			break
		fi
	done

	# check cleanup conditions
	local big_package=false
	while IFS= read -r p; do
		if [[ "${p}" == "${CLANDRO_PKG_NAME}" ]]; then
			big_package=true
			break
		fi
	done < "${CLANDRO_SCRIPTDIR}/scripts/big-pkgs.list"

	_termux_should_cleanup "${big_package}" && "${CLANDRO_SCRIPTDIR}/scripts/run-docker.sh" ./clean.sh

	if ! "${CLANDRO_SCRIPTDIR}/scripts/run-docker.sh" -d ./build-package.sh -C -a "${CLANDRO_ARCH}" -i "${CLANDRO_PKG_NAME}"; then
		_termux_should_cleanup "${big_package}" && "${CLANDRO_SCRIPTDIR}/scripts/run-docker.sh" ./clean.sh
		git checkout -- "${CLANDRO_SCRIPTDIR}"
		clandro_error_exit "failed to build."
	fi

	_termux_should_cleanup "${big_package}" && "${CLANDRO_SCRIPTDIR}/scripts/run-docker.sh" ./clean.sh

	if [[ "${GIT_COMMIT_PACKAGES}" == "true" ]]; then
		echo "INFO: Committing package."
		stderr="$(
			git add \
				"${CLANDRO_PKG_BUILDER_DIR}" \
				"${CLANDRO_SCRIPTDIR}/scripts/build/setup/" \
				2>&1 >/dev/null
			git commit \
				-m "bump(${repo}/${CLANDRO_PKG_NAME}): ${LATEST_VERSION}" \
				-m "This commit has been automatically submitted by Github Actions." \
				2>&1 >/dev/null
		)" || {
			git reset HEAD --hard
			clandro_error_exit <<-EndOfError
			ERROR: git commit failed. See below for details.
			${stderr}
			EndOfError
		}
	fi

	if [[ "${GIT_PUSH_PACKAGES}" == "true" ]]; then
		echo "INFO: Pushing package."
		stderr="$(
			# Fetch and pull before attempting to push to avoid a situation
			# where a long running auto update fails because a later faster
			# autoupdate got committed first and now the git history is out of date.
			git fetch 2>&1 >/dev/null
			git pull --rebase --autostash 2>&1 >/dev/null
			git push 2>&1 >/dev/null
		)" || {
			clandro_error_exit <<-EndOfError
			ERROR: git push failed. See below for details.
			${stderr}
			EndOfError
		}
	fi
}
