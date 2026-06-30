CLANDRO_PKG_HOMEPAGE=https://classic.yarnpkg.com/lang/en/
CLANDRO_PKG_DESCRIPTION="Fast, reliable, and secure dependency management"
CLANDRO_PKG_LICENSE="BSD 2-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.22.22"
CLANDRO_PKG_SRCURL=https://yarnpkg.com/downloads/${CLANDRO_PKG_VERSION}/yarn-v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=88268464199d1611fcf73ce9c0a6c4d44c7d5363682720d8506f6508addf36a0
CLANDRO_PKG_DEPENDS="nodejs | nodejs-lts"
CLANDRO_PKG_ANTI_BUILD_DEPENDS="nodejs, nodejs-lts"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_pkg_auto_update() {
	local api_url="https://api.github.com/repos/yarnpkg/yarn/git/refs/tags"
	local latest_refs_tags=$(curl -s "${api_url}" | jq .[].ref | sed -ne "s|.*v\(.*\)\"|\1|p")
	if [[ -z "${latest_refs_tags}" ]]; then
		echo "WARN: Unable to get latest refs tags from upstream. Try again later." >&2
		return
	fi
	local latest_version=$(echo "${latest_refs_tags}" | sort -V | tail -n1)

	clandro_pkg_upgrade_version "${latest_version}"
}

clandro_step_make_install() {
	cp -r . ${CLANDRO_PREFIX}/share/yarn/
	ln -fs ../share/yarn/bin/yarn ${CLANDRO_PREFIX}/bin/yarn
	ln -fs ../share/yarn/bin/yarn ${CLANDRO_PREFIX}/bin/yarnpkg
}

# Termux will not package yarn-berry
# https://github.com/termux/termux-packages/issues/19407
# https://github.com/yarnpkg/berry/discussions/5629#discussioncomment-6593555
