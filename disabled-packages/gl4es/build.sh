CLANDRO_PKG_HOMEPAGE=https://ptitseb.github.io/gl4es/
CLANDRO_PKG_DESCRIPTION="OpenGL driver for GLES devices"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
_COMMIT=22af242aa2b268aa851652dfa4e0f4adc3b0c416
_COMMIT_DATE=20230404
_COMMIT_TIME=213926
CLANDRO_PKG_VERSION="1.1.4.20230404.213926g22af242a"
CLANDRO_PKG_SRCURL=git+https://github.com/ptitSeb/gl4es
CLANDRO_PKG_GIT_BRANCH=master
CLANDRO_PKG_DEPENDS="libx11"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DTERMUX=ON
-DCMAKE_SYSTEM_NAME=Linux
"

# this should only be used until release new version
clandro_pkg_auto_update() {
	local latest_commit=$(curl -s https://api.github.com/repos/ptitSeb/gl4es/commits | jq .[].sha | head -1 | sed -e 's|\"||g')
	if [[ -z "${latest_commit}" ]]; then
		echo "WARN: Unable to get latest commit from upstream. Try again later." >&2
		return 0
	fi

	if [[ "${latest_commit}" == "${_COMMIT}" ]]; then
		echo "INFO: No update needed. Already at version '${CLANDRO_PKG_VERSION}'."
		return 0
	fi

	local latest_commit_date_tz=$(curl -s "https://api.github.com/repos/ptitSeb/gl4es/commits/${latest_commit}" | jq .commit.committer.date | sed -e 's|\"||g')
	if [[ -z "${latest_commit_date_tz}" ]]; then
		clandro_error_exit "Unable to get latest commit date info"
	fi

	local latest_commit_date=$(echo "${latest_commit_date_tz}" | sed -e 's|\(.*\)T\(.*\)Z|\1|' -e 's|\-||g')
	local latest_commit_time=$(echo "${latest_commit_date_tz}" | sed -e 's|\(.*\)T\(.*\)Z|\2|' -e 's|\:||g')

	# https://github.com/termux/termux-packages/issues/11827
	# really fix it by including longer date time info into versioning
	# always check this in case upstream change the version format
	local latest_version="1.1.4.${latest_commit_date}.${latest_commit_time}g${latest_commit:0:8}"

	local current_date_epoch=$(date "+%s")
	local _COMMIT_DATE_epoch=$(date -d "${_COMMIT_DATE}" "+%s")
	local current_date_diff=$(((current_date_epoch-_COMMIT_DATE_epoch)/(60*60*24)))
	if [[ "${current_date_diff}" -lt 7 ]]; then
		echo "INFO: Queuing updates after 7 days since last push, currently its ${current_date_diff}"
		return 0
	fi

	if ! dpkg --compare-versions "${latest_version}" gt "${CLANDRO_PKG_VERSION}"; then
		clandro_error_exit "Resulting latest version is not counted as update to the current version (${latest_version} < ${CLANDRO_PKG_VERSION})"
	fi

	# unlikely to happen
	if [[ "${latest_commit_date}" -lt "${_COMMIT_DATE}" ]]; then
		clandro_error_exit "Upstream is older than current package version. Please report to upstream."
	elif [[ "${latest_commit_date}" -eq "${_COMMIT_DATE}" ]] && [[ "${latest_commit_time}" -lt "${_COMMIT_TIME}" ]]; then
		clandro_error_exit "Upstream is older than current package version. Please report to upstream."
	fi

	sed -i "${CLANDRO_PKG_BUILDER_DIR}/build.sh" \
		-e "s|^_COMMIT=.*|_COMMIT=${latest_commit}|" \
		-e "s|^_COMMIT_DATE=.*|_COMMIT_DATE=${latest_commit_date}|" \
		-e "s|^_COMMIT_TIME=.*|_COMMIT_TIME=${latest_commit_time}|"

	# maybe save a few ms as we already done version check
	clandro_pkg_upgrade_version "${latest_version}" --skip-version-check
}

clandro_step_post_get_source() {
	git fetch --unshallow
	git checkout "${_COMMIT}"
}

clandro_step_pre_configure() {
	# benchmark result as follows:
	# -O2 -flto > -O3 -flto > -O2 > -Os > -Os -flto > -O3 > -Oz > -Oz -flto
	export CFLAGS="${CFLAGS/-Oz/-O2} -flto"
}

clandro_step_post_make_install() {
	rm -fr "${CLANDRO_PREFIX}/lib/gl4es/libGL.so"
	ln -fs "libGL.so.1" "${CLANDRO_PREFIX}/lib/gl4es/libGL.so"
}
