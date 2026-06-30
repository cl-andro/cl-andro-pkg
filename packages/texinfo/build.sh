CLANDRO_PKG_HOMEPAGE=https://www.gnu.org/software/texinfo/
CLANDRO_PKG_DESCRIPTION="Documentation system for on-line information and printed output"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="7.3"
_DEBIAN_REVISION="-1"
CLANDRO_PKG_SRCURL=(
	https://mirrors.kernel.org/gnu/texinfo/texinfo-${CLANDRO_PKG_VERSION}.tar.xz
	https://salsa.debian.org/tex-team/texinfo/-/archive/debian/${CLANDRO_PKG_VERSION}${_DEBIAN_REVISION}/texinfo-debian-${CLANDRO_PKG_VERSION}${_DEBIAN_REVISION}.tar.gz
)
CLANDRO_PKG_SHA256=(
	51f74eb0f51cfa9873b85264dfdd5d46e8957ec95b88f0fb762f63d9e164c72e
	9d2eab3f012d06452f16253ae050b90bce9c1bac165703b84382a703253218bc
)
CLANDRO_PKG_AUTO_UPDATE=true
# gawk is used by texindex:
CLANDRO_PKG_DEPENDS="gawk, libiconv, ncurses, perl"
CLANDRO_PKG_RECOMMENDS="update-info-dir"
CLANDRO_PKG_GROUPS="base-devel"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-perl-xs
texinfo_cv_sys_iconv_converts_euc_cn=no
"

clandro_pkg_auto_update() {
	local latest_version=$(clandro_repology_api_get_latest_version "${CLANDRO_PKG_NAME}")
	if [[ "${latest_version}" == "null" ]]; then
		latest_version="${CLANDRO_PKG_VERSION}"
	fi
	if [[ "${latest_version}" == "${CLANDRO_PKG_VERSION}" ]]; then
		echo "INFO: No update needed. Already at version '${CLANDRO_PKG_VERSION}'."
		return
	fi

	local api_url=https://deb.debian.org/debian/pool/main/t/texinfo/
	local api_url_r=$(curl -sL "${api_url}")
	local api_url_r1=$(echo "${api_url_r}" | grep "texinfo_${latest_version}")
	local debian_revision=$(echo "${api_url_r1}" | sed -nE "s/.*>texinfo_${latest_version}(.*).debian.tar.xz<.*/\1/p")
	if [[ -z "${debian_revision}" ]]; then
		cat <<- EOL >&2
		WARN: Auto update failure!
		latest_version=${latest_version}
		api_url_r1=${api_url_r1}
		debian_revision=${debian_revision}
		EOL
		return
	fi
	local tmpdir=$(mktemp -d)
	curl -sLC- \
		"$(dirname "${CLANDRO_PKG_SRCURL[0]}")/texinfo-${latest_version}.tar.xz" \
		-o "${tmpdir}/texinfo-${latest_version}.tar.xz"
	curl -sLC- \
		"https://salsa.debian.org/tex-team/texinfo/-/archive/debian/${latest_version}${debian_revision}/texinfo-debian-${latest_version}${debian_revision}.tar.gz" \
		-o "${tmpdir}/texinfo-debian-${latest_version}${debian_revision}.tar.gz"
	local texinfo_txz_sha256=$(sha256sum "${tmpdir}/texinfo-${latest_version}.tar.xz" | sed -e "s| .*$||")
	local texinfo_debian_txz_sha256=$(sha256sum "${tmpdir}/texinfo-debian-${latest_version}${debian_revision}.tar.gz" | sed -e "s| .*$||")
	if [[ -z "${texinfo_txz_sha256}" || -z "${texinfo_debian_txz_sha256}" ]]; then
		cat <<- EOL >&2
		WARN: Auto update failure!
		texinfo_txz_sha256=${texinfo_txz_sha256}
		texinfo_debian_txz_sha256=${texinfo_debian_txz_sha256}
		EOL
		return
	fi

	if [[ "${BUILD_PACKAGES}" == "false" ]]; then
		echo "INFO: package needs to be updated to ${latest_version}."
		return
	fi

	sed \
		-e "s|^_DEBIAN_REVISION=.*|_DEBIAN_REVISION=\"${debian_revision}\"|" \
		-e "s|^\t${CLANDRO_PKG_SHA256[0]}.*|\t${texinfo_txz_sha256}|" \
		-e "s|^\t${CLANDRO_PKG_SHA256[1]}.*|\t${texinfo_debian_txz_sha256}|" \
		-i "${CLANDRO_PKG_BUILDER_DIR}/build.sh"

	rm -fr "${tmpdir}"

	clandro_pkg_upgrade_version "${latest_version}"
}

clandro_step_post_get_source() {
	mv "${CLANDRO_PKG_SRCDIR}/texinfo-debian-${CLANDRO_PKG_VERSION}${_DEBIAN_REVISION}/debian" \
		"${CLANDRO_PKG_SRCDIR}/"
}

clandro_step_post_make_install() {
	pushd "${CLANDRO_PKG_SRCDIR}/debian"
	install -Dm755 -t $CLANDRO_PREFIX/bin update-info-dir
	install -Dm644 -t $CLANDRO_PREFIX/share/man/man8 update-info-dir.8
	popd
}
