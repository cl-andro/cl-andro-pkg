CLANDRO_PKG_HOMEPAGE=https://boinc.berkeley.edu/
CLANDRO_PKG_DESCRIPTION="Open-source software for volunteer computing"
CLANDRO_PKG_LICENSE="LGPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
_MAJOR_VERSION=8
_MINOR_VERSION=2
CLANDRO_PKG_VERSION="8.2.9"
CLANDRO_PKG_SRCURL=https://github.com/BOINC/boinc/archive/refs/tags/client_release/${_MAJOR_VERSION}.${_MINOR_VERSION}/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=cd85fe244bd61da04393d462374c8bec2949aeab771c0d9773d695093cca036b
CLANDRO_PKG_DEPENDS="libandroid-execinfo, libandroid-shmem, libc++, libcurl, openssl, zlib"
CLANDRO_PKG_NO_STATICSPLIT=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-manager
--disable-server
"

# etc/boinc-client.conf is not for Android, extra hooks needed to work
CLANDRO_PKG_RM_AFTER_INSTALL="
etc/boinc-client.conf
"

clandro_pkg_auto_update() {
	local api_url="https://api.github.com/repos/BOINC/boinc/git/refs/tags"
	local latest_refs_tags=$(curl -s "${api_url}" | jq .[].ref | sed -ne "s|.*client_release.*/\(.*\)\"|\1|p")
	if [[ -z "${latest_refs_tags}" ]]; then
		echo "WARN: Unable to get latest refs tags from upstream. Try again later." >&2
		return
	fi

	local latest_version=$(echo "${latest_refs_tags}" | sort -V | tail -n1)
	if [[ "${latest_version}" == "${CLANDRO_PKG_VERSION}" ]]; then
		echo "INFO: No update needed. Already at version '${CLANDRO_PKG_VERSION}'."
		return
	fi

	if ! dpkg --compare-versions "${latest_version}" gt "${CLANDRO_PKG_VERSION}"; then
		clandro_error_exit "
		ERROR: Resulting latest version is not counted as an update!
		Latest version =  ${latest_version}
		Current version = ${CLANDRO_PKG_VERSION}
		"
	fi

	local major_version=$(echo "${latest_version}" | sed -E "s|([0-9]+).([0-9]+).([0-9]+)|\1|")
	local minor_version=$(echo "${latest_version}" | sed -E "s|([0-9]+).([0-9]+).([0-9]+)|\2|")
	sed \
		-e "s|^_MAJOR_VERSION=.*|_MAJOR_VERSION=${major_version}|" \
		-e "s|^_MINOR_VERSION=.*|_MINOR_VERSION=${minor_version}|" \
		-i "${CLANDRO_PKG_BUILDER_DIR}/build.sh"

	clandro_pkg_upgrade_version "${latest_version}" --skip-version-check
}

clandro_step_pre_configure() {
	export CFLAGS+=" -fPIC"
	export CXXFLAGS+=" -fPIC"
	export LDFLAGS+=" -landroid-execinfo -landroid-shmem $(${CC} -print-libgcc-file-name)"
	./_autosetup
}

clandro_step_post_make_install() {
	install -Dm644 "${CLANDRO_PKG_SRCDIR}/client/scripts/boinc.bash" "${CLANDRO_PREFIX}/share/bash-completion/completions/boinc"
}
