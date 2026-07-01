CLANDRO_PKG_HOMEPAGE=https://github.com/gopasspw/gopass
CLANDRO_PKG_DESCRIPTION="The slightly more awesome standard unix password manager for teams"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="Joshua Kahn <tom@termux.dev> & @clandro"
CLANDRO_PKG_VERSION="1.16.1"
CLANDRO_PKG_SRCURL=https://github.com/gopasspw/gopass/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=33451a782b66266c59560a5ec7f4e34c104c501a36b445fc574fad71e3b3d884
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="git, gnupg"
CLANDRO_PKG_SUGGESTS="clandro-api, openssh"

clandro_step_make() {
	clandro_setup_golang
	# The commit introducing this is 2 years old, no idea why its only causing build failures now
	# https://github.com/gopasspw/gopass/commit/ffaa9e372999a4c5db82f0a281fc67758d107ac0
	# needed as of 1.15.13 for all architectures except AArch64
	sed -i 's|CGO_ENABLED=0|CGO_ENABLED=1|g' "$CLANDRO_PKG_SRCDIR/Makefile"
	export GOPATH=$CLANDRO_PKG_BUILDDIR

	mkdir -p ./src
	mkdir -p ./src/github.com/gopasspw
	ln -sf "$CLANDRO_PKG_SRCDIR" ./src/github.com/gopasspw/gopass

	rm -f ./src/github.com/gopasspw/gopass/gopass
	make -C ./src/github.com/gopasspw/gopass build CLIPHELPERS="-X github.com/gopasspw/gopass/pkg/clipboard.Helpers=clandro-api'"
	install -Dm700 \
		./src/github.com/gopasspw/gopass/gopass \
		"$CLANDRO_PREFIX"/bin/gopass
}

clandro_step_post_make_install() {
	cd "$CLANDRO_PKG_SRCDIR"
	install -Dm600 gopass.1 -t "$CLANDRO_PREFIX/share/man/man1"
	install -Dm600 bash.completion "$CLANDRO_PREFIX/share/bash-completion/completions/gopass"
	install -Dm600 zsh.completion "$CLANDRO_PREFIX/share/zsh/site-functions/_gopass"
	install -Dm600 fish.completion "$CLANDRO_PREFIX/share/fish/vendor_completions.d/gopass.fish"
	install -Dm600 {README,CHANGELOG,ARCHITECTURE}.md -t "$CLANDRO_PREFIX/share/doc/$CLANDRO_PKG_NAME"
	cd ./docs
	rm -f logo*.*
	cp --parents -r * -t "$CLANDRO_PREFIX/share/doc/$CLANDRO_PKG_NAME"
}
