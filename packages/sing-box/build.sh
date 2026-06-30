CLANDRO_PKG_HOMEPAGE=https://sing-box.sagernet.org
CLANDRO_PKG_DESCRIPTION="The universal proxy platform"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="kay9925@outlook.com"
CLANDRO_PKG_VERSION="1.13.11"
CLANDRO_PKG_SRCURL="https://github.com/SagerNet/sing-box/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=5e35f2cc0ad14d3beb1956157fe3f4b3a36787dd115f247c72f2d550d353853b
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make() {
	clandro_setup_golang

	local tags="with_gvisor,with_quic,with_wireguard,with_utls,with_clash_api"
	local ldflags="\
	-w -s \
	-X 'github.com/sagernet/sing-box/constant.Version=${CLANDRO_PKG_VERSION}' \
	"

	export CGO_ENABLED=1

	go build \
		-trimpath \
		-tags "${tags}" \
		-ldflags="${ldflags}" \
		-o "${CLANDRO_PKG_NAME}" \
		./cmd/sing-box

}

clandro_step_make_install() {
	install -Dm700 ./${CLANDRO_PKG_NAME} ${CLANDRO_PREFIX}/bin

	install -Dm644 /dev/null "${CLANDRO_PREFIX}/share/bash-completion/completions/sing-box.bash"
	install -Dm644 /dev/null "${CLANDRO_PREFIX}/share/fish/vendor_completions.d/sing-box.fish"
	install -Dm644 /dev/null "${CLANDRO_PREFIX}/share/zsh/site-functions/_sing-box"

}

clandro_step_create_debscripts() {
	cat <<- EOF > ./postinst
		#!${CLANDRO_PREFIX}/bin/sh
		sing-box completion bash > ${CLANDRO_PREFIX}/share/bash-completion/completions/sing-box.bash
		sing-box completion fish > ${CLANDRO_PREFIX}/share/fish/vendor_completions.d/sing-box.fish
		sing-box completion zsh > ${CLANDRO_PREFIX}/share/zsh/site-functions/_sing-box
	EOF
}
