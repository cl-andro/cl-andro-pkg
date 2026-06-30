CLANDRO_PKG_HOMEPAGE=https://oplist.org/
CLANDRO_PKG_DESCRIPTION="A file list program that supports multiple storage"
CLANDRO_PKG_LICENSE="AGPL-V3"
CLANDRO_PKG_MAINTAINER="2096779623 <admin@utermux.dev>"
CLANDRO_PKG_VERSION="4.2.1"
_OPENLIST_WEB_VERSION="4.2.1"
CLANDRO_PKG_SRCURL=(
	https://github.com/OpenListTeam/OpenList/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
	https://github.com/OpenListTeam/OpenList-Frontend/releases/download/v${_OPENLIST_WEB_VERSION}/openlist-frontend-dist-v${_OPENLIST_WEB_VERSION}.tar.gz
)
CLANDRO_PKG_SHA256=(
	95d4a30f9669837a4c92daf88f74d223eca773e3445c270681c67e2b3dc3ac31
	e63cf21666f9c0ef41e46e5dfe05055c81e1531a668e577ced39f296952f5bd3
)
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_CONFLICTS="alist"
CLANDRO_PKG_REPLACES="alist"
CLANDRO_PKG_PROVIDES="alist"
CLANDRO_PKG_UPDATE_TAG_TYPE="latest-release-tag"

clandro_pkg_auto_update() {
	local latest_tag
	latest_tag="$(clandro_github_api_get_tag "${CLANDRO_PKG_SRCURL[0]}" "${CLANDRO_PKG_UPDATE_TAG_TYPE}")"
	latest_tag="${latest_tag#v}"
	(( ${#latest_tag} )) || {
		printf '%s\n' \
		'WARN: Auto update failure!' \
		"latest_tag=${latest_tag}"
	return
	} >&2

	if [[ "${latest_tag}" == "${CLANDRO_PKG_VERSION}" ]]; then
		echo "INFO: No update needed. Already at version '${CLANDRO_PKG_VERSION}'."
		return
	fi

	if [[ "${BUILD_PACKAGES}" == "false" ]]; then
		echo "INFO: package needs to be updated to ${latest_tag}."
		return
	fi

	local tmpdir
	tmpdir="$(mktemp -d)"
	curl -sLo "${tmpdir}/openlist-linux-amd64.tar.gz" "https://github.com/OpenListTeam/OpenList/releases/download/v${latest_tag}/openlist-linux-amd64.tar.gz"
	tar -C "${tmpdir}" -xf "${tmpdir}/openlist-linux-amd64.tar.gz"
	chmod +x "${tmpdir}/openlist"
	local latest_web_version
	latest_web_version="$("${tmpdir}"/openlist version | grep "WebVersion:" | cut -d ' ' -f 2 | sed 's/^v//')"

	curl -sLo "${tmpdir}/src" "https://github.com/OpenListTeam/OpenList/archive/refs/tags/v${latest_tag}.tar.gz"
	curl -sLo "${tmpdir}/web" "https://github.com/OpenListTeam/OpenList-Frontend/releases/download/v${latest_web_version}/openlist-frontend-dist-v${latest_web_version}.tar.gz"
	local -a sha=(
		"$(sha256sum "${tmpdir}/src" | cut -d ' ' -f 1)"
		"$(sha256sum "${tmpdir}/web" | cut -d ' ' -f 1)"
	)

	sed \
		-e "s|^_OPENLIST_WEB_VERSION=.*|_OPENLIST_WEB_VERSION=\"${latest_web_version}\"|" \
		-e "s|^\t${CLANDRO_PKG_SHA256[0]}.*|\t${sha[0]}|" \
		-e "s|^\t${CLANDRO_PKG_SHA256[1]}.*|\t${sha[1]}|" \
		-i "${CLANDRO_PKG_BUILDER_DIR}/build.sh"

	rm -fr "${tmpdir}"

	printf '%s %s\n' 'OPENLIST_VERSION     :' "${latest_tag}"
	printf '%s %s\n' 'OPENLIST_CHECKSUM    :' "${sha[0]}"
	printf '%s %s\n' 'OPENLIST_WEB_VERSION :' "${latest_web_version}"
	printf '%s %s\n' 'OPENLIST_WEB_CHECKSUM:' "${sha[1]}"
	clandro_pkg_upgrade_version "${latest_tag}"
}


clandro_step_get_source() {
	mkdir -p "$CLANDRO_PKG_SRCDIR"

	# Download and extract backend source code
	clandro_download \
		"${CLANDRO_PKG_SRCURL[0]}" \
		"$CLANDRO_PKG_CACHEDIR"/"openlist-backend-src-v${CLANDRO_PKG_VERSION}.tar.gz" \
		"${CLANDRO_PKG_SHA256[0]}"
	tar xf \
		"$CLANDRO_PKG_CACHEDIR"/"openlist-backend-src-v${CLANDRO_PKG_VERSION}.tar.gz" \
		-C "$CLANDRO_PKG_SRCDIR" --strip-components=1

	# Download and extract frontend dist files
	mkdir -p "$CLANDRO_PKG_SRCDIR"/public/dist
	clandro_download \
		"${CLANDRO_PKG_SRCURL[1]}" \
		"$CLANDRO_PKG_CACHEDIR"/"openlist-frontend-dist-v${_OPENLIST_WEB_VERSION}.tar.gz" \
		"${CLANDRO_PKG_SHA256[1]}"
	tar xf \
		"$CLANDRO_PKG_CACHEDIR"/"openlist-frontend-dist-v${_OPENLIST_WEB_VERSION}.tar.gz" \
		-C "$CLANDRO_PKG_SRCDIR"/public/dist
}

clandro_step_make() {
	clandro_setup_golang

	local ldflags
	local _builtAt=$(date +'%F %T %z')
	local _goVersion=$(go version | sed 's/go version //')
	local _gitAuthor="The OpenList Projects Contributors <noreply@openlist.team>"
	local _gitCommit=$(git ls-remote https://github.com/OpenListTeam/OpenList refs/tags/v$CLANDRO_PKG_VERSION | head -c 7)
	export CGO_ENABLED=1

	ldflags="\
	-w -s \
	-X 'github.com/OpenListTeam/OpenList/internal/conf.BuiltAt=$_builtAt' \
	-X 'github.com/OpenListTeam/OpenList/internal/conf.GoVersion=$_goVersion' \
	-X 'github.com/OpenListTeam/OpenList/internal/conf.GitAuthor=$_gitAuthor' \
	-X 'github.com/OpenListTeam/OpenList/internal/conf.GitCommit=$_gitCommit' \
	-X 'github.com/OpenListTeam/OpenList/internal/conf.Version=$CLANDRO_PKG_VERSION' \
	-X 'github.com/OpenListTeam/OpenList/internal/conf.WebVersion=$_OPENLIST_WEB_VERSION' \
	"
	go build -o "${CLANDRO_PKG_NAME}" -ldflags="$ldflags" -tags=jsoniter
}

clandro_step_make_install() {
	install -Dm700 ./"${CLANDRO_PKG_NAME}" "${CLANDRO_PREFIX}"/bin

	# Provide a symlink from openliat to alist
	ln -sfr "$CLANDRO_PREFIX"/bin/openlist "$CLANDRO_PREFIX"/bin/alist

	install -Dm644 /dev/null "${CLANDRO_PREFIX}/share/bash-completion/completions/openlist.bash"
	install -Dm644 /dev/null "${CLANDRO_PREFIX}/share/zsh/site-functions/_openlist"
	install -Dm644 /dev/null "${CLANDRO_PREFIX}/share/fish/vendor_completions.d/openlist.fish"
}

clandro_step_create_debscripts() {
	cat <<- EOF > ./postinst
		#!${CLANDRO_PREFIX}/bin/sh
		echo
		echo "********"
		echo "Starting from version 4.0, Alist has been replaced by OpenList. To ensure"
		echo "compatibility, a symbolic link from openlist to alist currently exists."
		echo "It may be removed in the future. Please migrate to OpenList accordingly."
		echo "********"
		echo

		openlist completion bash > ${CLANDRO_PREFIX}/share/bash-completion/completions/openlist.bash
		openlist completion zsh > ${CLANDRO_PREFIX}/share/zsh/site-functions/_openlist
		openlist completion fish > ${CLANDRO_PREFIX}/share/fish/vendor_completions.d/openlist.fish
	EOF
}
