CLANDRO_PKG_HOMEPAGE=https://github.com/kkdai/youtube
CLANDRO_PKG_DESCRIPTION="Download youtube video in Golang"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="Krishna kanhaiya @kcubeterm"
CLANDRO_PKG_VERSION="2.10.6"
CLANDRO_PKG_SRCURL=https://github.com/kkdai/youtube/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=c334c04c07c3576e911d78b65b068b574e81e33e385f63a86b4862022391240d
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make() {
	clandro_setup_golang

	cd "$CLANDRO_PKG_SRCDIR"
	export GOPATH="${CLANDRO_PKG_BUILDDIR}"
	mkdir -p "${GOPATH}/src/github.com/kkdai/"
	cp -a "${CLANDRO_PKG_SRCDIR}" "${GOPATH}/src/github.com/kkdai/youtube"
	cd "${GOPATH}/src/github.com/kkdai/youtube/"
	go get -d -v
	cd cmd/youtubedr
	go build .
}

clandro_step_make_install() {
	install -Dm700 -t "$CLANDRO_PREFIX"/bin "$GOPATH"/src/github.com/kkdai/youtube/cmd/youtubedr/youtubedr

	install -Dm644 /dev/null "$CLANDRO_PREFIX"/share/bash-completion/completions/youtubedr
	install -Dm644 /dev/null "$CLANDRO_PREFIX"/share/zsh/site-functions/_youtubedr
	install -Dm644 /dev/null "$CLANDRO_PREFIX"/share/fish/vendor_completions.d/youtubedr.fish
}

clandro_step_create_debscripts() {
	cat <<-EOF >./postinst
		#!${CLANDRO_PREFIX}/bin/sh
		youtubedr completion bash > ${CLANDRO_PREFIX}/share/bash-completion/completions/youtubedr
		youtubedr completion zsh > ${CLANDRO_PREFIX}/share/zsh/site-functions/_youtubedr
		youtubedr completion fish > ${CLANDRO_PREFIX}/share/fish/vendor_completions.d/youtubedr.fish
	EOF
}
