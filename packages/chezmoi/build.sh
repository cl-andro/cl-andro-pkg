CLANDRO_PKG_HOMEPAGE=https://chezmoi.io
CLANDRO_PKG_DESCRIPTION="Manage your dotfiles across multiple machines"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="Henrik Grimler @Grimler91"
CLANDRO_PKG_VERSION="2.70.3"
CLANDRO_PKG_SRCURL=https://github.com/twpayne/chezmoi/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=04780df69be596b714ac0ea5f9c65e7739adc847613d5a91ba23fd5a020f5103
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make() {
	clandro_setup_golang

	cd "$CLANDRO_PKG_SRCDIR"

	mkdir -p "${CLANDRO_PKG_BUILDDIR}/src/github.com/twpayne"
	cp -a "${CLANDRO_PKG_SRCDIR}" "${CLANDRO_PKG_BUILDDIR}/src/github.com/twpayne/chezmoi"
	cd "${CLANDRO_PKG_BUILDDIR}/src/github.com/twpayne/chezmoi"

	go get -d -v
	go build -tags noupgrade,noembeddocs \
		-ldflags "-X github.com/twpayne/chezmoi/cmd.DocsDir=$CLANDRO_PREFIX/share/doc/chezmoi -X main.version=${CLANDRO_PKG_VERSION}" .
}

clandro_step_make_install() {
	install -Dm700 ${CLANDRO_PKG_BUILDDIR}/src/github.com/twpayne/chezmoi/chezmoi $CLANDRO_PREFIX/bin/chezmoi

	mkdir -p $CLANDRO_PREFIX/share/bash-completion/completions \
		$CLANDRO_PREFIX/share/fish/completions \
		$CLANDRO_PREFIX/share/zsh/site-functions \
		$CLANDRO_PREFIX/share/doc/chezmoi

	install -Dm600 ${CLANDRO_PKG_BUILDDIR}/src/github.com/twpayne/chezmoi/completions/chezmoi-completion.bash \
		$CLANDRO_PREFIX/share/bash-completion/completions/chezmoi
	install -Dm600 ${CLANDRO_PKG_BUILDDIR}/src/github.com/twpayne/chezmoi/completions/chezmoi.fish \
		$CLANDRO_PREFIX/share/fish/vendor_completions.d/chezmoi.fish
	install -Dm600 ${CLANDRO_PKG_BUILDDIR}/src/github.com/twpayne/chezmoi/completions/chezmoi.zsh \
		$CLANDRO_PREFIX/share/zsh/site-functions/_chezmoi
}
