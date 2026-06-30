CLANDRO_PKG_HOMEPAGE=https://dev.yorhel.nl/ncdu
CLANDRO_PKG_DESCRIPTION="Disk usage analyzer"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_LICENSE_FILE="LICENSES/MIT.txt"
CLANDRO_PKG_MAINTAINER="Joshua Kahn <tom@termux.dev> & @clandro"
CLANDRO_PKG_VERSION="2.9.2"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://dev.yorhel.nl/download/ncdu-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=e91135281cb66569f2ca4c0bac277246991e7e52524c0ca8cba3de5c8e81cec9
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP='2\.\d+(\.\d+)?'
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_ZIG_VERSION="0.15.2"

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

clandro_step_post_get_source() {
	# TODO drop all this once figure out how zig can work with bionic libc
	local -a deps=( 'ncurses' 'zstd' )
	for dep in "${deps[@]}"; do
		local DEP_SRCURL='' DEP_SHA256=''
		read -r DEP_SRCURL DEP_SHA256 < <(
			# This gets shellcheck to shut up about the non-constant source
			# shellcheck source=/dev/null
			source "${CLANDRO_SCRIPTDIR}/packages/${dep}/build.sh"

			# ${var@a} outputs the declaration attributes of a varaible e.g. 'a' for arrays
			if [[ "${CLANDRO_PKG_SRCURL@a}" == 'a' ]]; then
				echo "${CLANDRO_PKG_SRCURL[0]}" "${CLANDRO_PKG_SHA256[0]}"
			else
				echo "${CLANDRO_PKG_SRCURL}" "${CLANDRO_PKG_SHA256}"
			fi
		)

		rm -rf "${dep}"-* "${dep}"
		clandro_download "${DEP_SRCURL}" "${CLANDRO_PKG_CACHEDIR}/${dep}.tar.gz" "${DEP_SHA256}"
		tar -xf "${CLANDRO_PKG_CACHEDIR}/${dep}.tar.gz"
		mv -v "${dep}"-* "${dep}"

		echo "INFO: Applying patches from $dep"
		local p
		for p in "${CLANDRO_SCRIPTDIR}/packages/$dep/"*.patch; do
			patch -p1 -i "${p}" -d "${dep}"
		done
	done

	local f
	f=$(sed -nE "s|.*SPDX-FileCopyrightText.*: (.*)|\1|p" ChangeLog)
	sed \
		-e "s|<year> <copyright holders>|${f}|" \
		-i LICENSES/MIT.txt
}

clandro_step_pre_configure() {
	clandro_setup_zig
	unset CFLAGS LDFLAGS
}

clandro_step_make() {
	make -j "${CLANDRO_PKG_MAKE_PROCESSES}" "static-${ZIG_TARGET_NAME}.tar.gz"
}

clandro_step_make_install() {
	# allow ncdu2 to co-exist with ncdu
	tar -xf "static-${ZIG_TARGET_NAME}.tar.gz"
	mv -v ncdu ncdu2
	mv -v ncdu.1 ncdu2.1
	install -Dm755 -t "${CLANDRO_PREFIX}/bin" ncdu2
	install -Dm644 -t "${CLANDRO_PREFIX}/share/man/man1" ncdu2.1
}
