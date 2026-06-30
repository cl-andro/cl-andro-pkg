CLANDRO_PKG_HOMEPAGE=https://github.com/hetznercloud/cli
CLANDRO_PKG_DESCRIPTION="Hetzner Cloud command line client"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.64.1"
CLANDRO_PKG_SRCURL=https://github.com/hetznercloud/cli/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=70bc7d62f4d07b408afa2eb84b0e1e5854a7f32f9defb4899f2e9a24b6846078
CLANDRO_PKG_DEPENDS="resolv-conf"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	clandro_setup_golang

	go mod init || :
	go mod tidy
}

clandro_step_make() {
	# Below are taken from github.com/hetznercloud/cli@v1.30.1/.goreleaser.yml
	local LD_FLAGS="-s -w -X 'github.com/hetznercloud/cli/internal/version.Version=v${CLANDRO_PKG_VERSION}'"
	export GOFLAGS="-buildmode=pie -trimpath -mod=readonly -modcacherw"
	go build -ldflags "${LD_FLAGS}" -o hcloud  cmd/hcloud/main.go
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin hcloud

	install -Dm644 /dev/null "$CLANDRO_PREFIX"/share/bash-completion/completions/hcloud
	install -Dm644 /dev/null "$CLANDRO_PREFIX"/share/zsh/site-functions/_hcloud
	install -Dm644 /dev/null "$CLANDRO_PREFIX"/share/fish/vendor_completions.d/hcloud.fish
}

clandro_step_create_debscripts() {
	cat <<-EOF >./postinst
		#!${CLANDRO_PREFIX}/bin/sh
		hcloud completion bash > ${CLANDRO_PREFIX}/share/bash-completion/completions/hcloud
		hcloud completion zsh > ${CLANDRO_PREFIX}/share/zsh/site-functions/_hcloud
		hcloud completion fish > ${CLANDRO_PREFIX}/share/fish/vendor_completions.d/hcloud.fish
	EOF
}
