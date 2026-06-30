CLANDRO_PKG_HOMEPAGE=https://www.navidrome.org/
CLANDRO_PKG_DESCRIPTION="Modern Music Server and Streamer compatible with Subsonic/Airsonic"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="2096779623 <admin@utermux.dev>"
CLANDRO_PKG_VERSION="0.61.2"
CLANDRO_PKG_SRCURL="https://github.com/navidrome/navidrome/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=8f5e7f6f6757ccf7d6c14b0525f414790d95467506b3115813207084ef8517a1
CLANDRO_PKG_DEPENDS="taglib, ffmpeg"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_CONFFILES="etc/navidrome/navidrome.toml"

clandro_step_make() {
	rm -f Makefile

	clandro_setup_golang
	clandro_setup_nodejs

	local GIT_SHA
	GIT_SHA="$(git ls-remote https://github.com/navidrome/navidrome "refs/tags/v$CLANDRO_PKG_VERSION" | head -c 7)"
	export GIT_TAG="v$CLANDRO_PKG_VERSION"

	# Build frontend
	pushd "$CLANDRO_PKG_SRCDIR/ui"
	npm ci && npm run build
	popd

	# Build backend
	cd "$CLANDRO_PKG_SRCDIR"
	export CGO_ENABLED=1 CGO_CFLAGS_ALLOW="--define-prefix"
	go build -v -ldflags="
	-X github.com/navidrome/navidrome/consts.gitSha=$GIT_SHA \
	-X github.com/navidrome/navidrome/consts.gitTag=$GIT_TAG-SNAPSHOT" \
	-tags=netgo,sqlite_fts5 \
	-o navidrome
}

clandro_step_make_install() {
	install -Dm755 -t "${CLANDRO_PREFIX}"/bin "${CLANDRO_PKG_SRCDIR}/navidrome"

	install -Dm644 /dev/null "${CLANDRO_PREFIX}/share/bash-completion/completions/navidrome.bash"
	install -Dm644 /dev/null "${CLANDRO_PREFIX}/share/zsh/site-functions/_navidrome"
	install -Dm644 /dev/null "${CLANDRO_PREFIX}/share/fish/vendor_completions.d/navidrome.fish"

	install -Dm644 -t "${CLANDRO_PREFIX}/etc/navidrome" release/linux/navidrome.toml

	install -Dm644 /dev/null "${CLANDRO_PREFIX}/opt/navidrome/music/.placeholder"
}

clandro_step_create_debscripts() {
	cat <<- EOF > ./postinst
		#!${CLANDRO_PREFIX}/bin/sh
		navidrome completion bash -n > ${CLANDRO_PREFIX}/share/bash-completion/completions/navidrome.bash
		navidrome completion zsh -n > ${CLANDRO_PREFIX}/share/zsh/site-functions/_navidrome
		navidrome completion fish -n > ${CLANDRO_PREFIX}/share/fish/vendor_completions.d/navidrome.fish
	EOF
}
