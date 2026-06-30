CLANDRO_PKG_HOMEPAGE=https://docs.iyear.me/tdl/
CLANDRO_PKG_DESCRIPTION="Telegram downloader/tools written in Golang"
CLANDRO_PKG_LICENSE="AGPL-V3"
CLANDRO_PKG_LICENSE_FILE="LICENSE"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.20.2"
CLANDRO_PKG_SRCURL=https://github.com/iyear/tdl/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=61b518929c05f5eb36386bb5d01fc85ff1c1956223592a52feda47f15faaa5fc
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make() {
	clandro_setup_golang
	read commit_hash commit_date <<<"$(
		curl -s "https://api.github.com/repos/iyear/tdl/commits/v${CLANDRO_PKG_VERSION}" \
			| jq -r '[.sha, .commit.committer.date] | "\(.[0][0:7]) \(.[1])"'
	)"
	local _ldflags="-s -w -X github.com/iyear/tdl/pkg/consts.Version=${CLANDRO_PKG_VERSION}"
	_ldflags+=" -X github.com/iyear/tdl/pkg/consts.Commit=${commit_hash}"
	_ldflags+=" -X github.com/iyear/tdl/pkg/consts.CommitDate=${commit_date}"
	go build --ldflags="$_ldflags"
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin tdl

	install -Dm644 /dev/null "$CLANDRO_PREFIX"/share/bash-completion/completions/tdl
	install -Dm644 /dev/null "$CLANDRO_PREFIX"/share/zsh/site-functions/_tdl
	install -Dm644 /dev/null "$CLANDRO_PREFIX"/share/fish/vendor_completions.d/tdl.fish
}

clandro_step_create_debscripts() {
	cat <<-EOF >./postinst
		#!${CLANDRO_PREFIX}/bin/sh
		tdl completion bash > "${CLANDRO_PREFIX}/share/bash-completion/completions/tdl"
		tdl completion zsh > "${CLANDRO_PREFIX}/share/zsh/site-functions/_tdl"
		tdl completion fish > "${CLANDRO_PREFIX}/share/fish/vendor_completions.d/tdl.fish"
	EOF
}
