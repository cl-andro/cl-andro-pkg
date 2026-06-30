CLANDRO_PKG_HOMEPAGE=https://gitea.com/gitea/tea
CLANDRO_PKG_DESCRIPTION="The official CLI for Gitea"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.14.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://gitea.com/gitea/tea/archive/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=f509de217ac0e57491ffdab2750516e8c505780881529ee703b9d0c86cc652a3
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_HOSTBUILD=true

clandro_step_host_build() {
	clandro_setup_golang

	cd "$CLANDRO_PKG_SRCDIR"
	go mod vendor
	go build -o tea
	mv tea "$CLANDRO_PKG_HOSTBUILD_DIR"/tea
}

clandro_step_make() {
	clandro_setup_golang

	go mod vendor

	local SDK_VER=$(go list -f '{{.Version}}' -m code.gitea.io/sdk/gitea)
	go build \
		-ldflags "-X 'code.gitea.io/tea/modules/version.Version=${CLANDRO_PKG_VERSION}' -X 'code.gitea.io/tea/modules/version.SDK=${SDK_VER}'" \
		-o tea
}

clandro_step_make_install() {
	install -Dm700 -t "$CLANDRO_PREFIX"/bin ./tea

	mkdir -p "$CLANDRO_PREFIX"/share/bash-completion/completions
	"$CLANDRO_PKG_HOSTBUILD_DIR"/tea completion bash > \
		"$CLANDRO_PREFIX"/share/bash-completion/completions/tea

	mkdir -p "$CLANDRO_PREFIX"/share/zsh/site-functions
	"$CLANDRO_PKG_HOSTBUILD_DIR"/tea completion zsh > \
		"$CLANDRO_PREFIX"/share/zsh/site-functions/_tea

	mkdir -p "$CLANDRO_PREFIX"/share/fish/vendor_completions.d
	"$CLANDRO_PKG_HOSTBUILD_DIR"/tea completion fish > \
		"$CLANDRO_PREFIX"/share/fish/vendor_completions.d/tea.fish

	mkdir -p "$CLANDRO_PREFIX"/share/man/man8
	"$CLANDRO_PKG_HOSTBUILD_DIR"/tea man --out "$CLANDRO_PREFIX"/share/man/man8/tea.8
}
