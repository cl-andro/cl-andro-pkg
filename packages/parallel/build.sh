CLANDRO_PKG_HOMEPAGE=https://www.gnu.org/software/parallel/
CLANDRO_PKG_DESCRIPTION="GNU Parallel is a shell tool for executing jobs in parallel using one or more machines"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="20260422"
CLANDRO_PKG_SRCURL=https://mirrors.kernel.org/gnu/parallel/parallel-${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=5d1d7999da33dd20f71b8b429d18f22e80aa869729194c58d46e1211be6cca32
CLANDRO_PKG_DEPENDS="perl"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_pkg_auto_update() {
	local e=0
	local api_url="https://mirrors.kernel.org/gnu/parallel"
	local api_url_r=$(curl -s "${api_url}/")
	local r1=$(echo "${api_url_r}" | sed -nE 's|<.*>parallel-(.*).tar.bz2<.*>.*|\1|p')
	local latest_version=$(echo "${r1}" | sed -nE 's|([0-9]+)|\1|p' | tail -n1)
	if [[ "${latest_version}" == "${CLANDRO_PKG_VERSION}" ]]; then
		echo "INFO: No update needed. Already at version '${CLANDRO_PKG_VERSION}'."
		return
	fi
	[[ -z "${api_url_r}" ]] && e=1
	[[ -z "${r1}" ]] && e=1
	[[ -z "${latest_version}" ]] && e=1

	if [[ "${e}" != 0 ]]; then
		cat <<- EOL >&2
		WARN: Auto update failure!
		api_url_r=${api_url_r}
		r1=${r1}
		latest_version=${latest_version}
		EOL
		return
	fi

	local latest_tbz="${api_url}/parallel-latest.tar.bz2"
	local tmpdir=$(mktemp -d)
	curl -so "${tmpdir}/parallel-latest.tar.bz2" "${latest_tbz}"
	tar -xf "${tmpdir}/parallel-latest.tar.bz2" -C "${tmpdir}"
	if [[ ! -d "${tmpdir}/parallel-${latest_version}" ]]; then
		clandro_error_exit "
		ERROR: Latest archive does not contain latest version
		$(ls -l "${tmpdir}")
		"
	fi

	rm -fr "${tmpdir}"

	clandro_pkg_upgrade_version "${latest_version}"
}

clandro_step_post_make_install() {
	install -Dm644 /dev/null "${CLANDRO_PREFIX}"/share/bash-completion/completions/parallel

	mkdir -p "${CLANDRO_PREFIX}"/share/zsh/site-functions
	cat <<- EOF > "${CLANDRO_PREFIX}"/share/zsh/site-functions/_parallel
	#compdef parallel
	(( $+functions[_comp_parallel] )) ||
	eval "\$(parallel --shell-completion auto)" &&
	comp_parallel
	EOF
}

clandro_step_create_debscripts() {
	cat <<- EOF > postinst
	#!${CLANDRO_PREFIX}/bin/sh
	parallel --shell-completion bash > ${CLANDRO_PREFIX}/share/bash-completion/completions/parallel
	EOF
}
