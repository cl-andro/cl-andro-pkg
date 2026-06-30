CLANDRO_PKG_HOMEPAGE=https://artalk.js.org/
CLANDRO_PKG_DESCRIPTION="A self-hosted comment system"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="Moraxyc <termux@qaq.li>"
CLANDRO_PKG_VERSION="2.9.1"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=(
	"https://github.com/ArtalkJS/Artalk/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
	"https://github.com/ArtalkJS/Artalk/releases/download/v${CLANDRO_PKG_VERSION}/artalk_ui.tar.gz"
)
CLANDRO_PKG_SHA256=(
	edb1f85fb84e103d9a6bfda25191b174df22b354c6d9d3dedb154c2fbbddc2ee
	724282e2512b295749b89fa91b2b26311f7a6bd2e4ac2627581e23e953cff0e6
)
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_post_get_source() {
	mv artalk_ui/* public
}

clandro_step_make() {
	clandro_setup_golang
	local _gitCommit ldflags

	export CGO_ENABLED=1
	_gitCommit=$(git ls-remote https://github.com/ArtalkJS/Artalk refs/tags/v$CLANDRO_PKG_VERSION | head -c 7)

	ldflags="\
	-w -s \
	-X github.com/ArtalkJS/Artalk/internal/config.Version=$CLANDRO_PKG_VERSION \
	-X github.com/ArtalkJS/Artalk/internal/config.CommitHash=$_gitCommit \
	"
	go build -o "${CLANDRO_PKG_NAME}" -ldflags="$ldflags"
}

clandro_step_make_install() {
	install -Dm755 ./"${CLANDRO_PKG_NAME}" "${CLANDRO_PREFIX}"/bin

	install -Dm644 /dev/null "${CLANDRO_PREFIX}/share/bash-completion/completions/artalk.bash"
	install -Dm644 /dev/null "${CLANDRO_PREFIX}/share/zsh/site-functions/_artalk"
	install -Dm644 /dev/null "${CLANDRO_PREFIX}/share/fish/vendor_completions.d/artalk.fish"

}

clandro_step_create_debscripts() {
	cat <<- EOF > ./postinst
		#!${CLANDRO_PREFIX}/bin/sh
		artalk completion bash > ${CLANDRO_PREFIX}/share/bash-completion/completions/artalk.bash
		artalk completion zsh > ${CLANDRO_PREFIX}/share/zsh/site-functions/_artalk
		artalk completion fish > ${CLANDRO_PREFIX}/share/fish/vendor_completions.d/artalk.fish
	EOF
}
