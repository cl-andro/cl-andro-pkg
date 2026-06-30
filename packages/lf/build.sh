CLANDRO_PKG_HOMEPAGE=https://github.com/gokcehan/lf
CLANDRO_PKG_DESCRIPTION="Terminal file manager"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="41"
CLANDRO_PKG_SRCURL=https://github.com/gokcehan/lf/archive/refs/tags/r${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=55c556d53b5541d5f8691f1309a0166a7a0d8e06cb051c3030c2cd7d8abc6789
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+"
CLANDRO_PKG_CONFFILES="etc/lf/lfrc"

clandro_step_make() {
	clandro_setup_golang
	export GOPATH="$CLANDRO_PKG_BUILDDIR"
	mkdir -p "$GOPATH/src/github.com/gokcehan"
	ln -sf "$CLANDRO_PKG_SRCDIR" "$GOPATH/src/github.com/gokcehan/lf"
	cd "$GOPATH/src/github.com/gokcehan/lf"
	go build -ldflags="-X main.gVersion=r$CLANDRO_PKG_VERSION" -trimpath
}

clandro_step_make_install() {
	cd "$GOPATH/src/github.com/gokcehan/lf"
	install -Dm755 -t "$CLANDRO_PREFIX/bin" lf
	install -Dm644 -T etc/lfrc.example "$CLANDRO_PREFIX/etc/lf/lfrc"
	install -Dm644 -t "$CLANDRO_PREFIX/share/applications" lf.desktop
	install -Dm644 -t "$CLANDRO_PREFIX/share/doc/lf" README.md
	install -Dm644 -t "$CLANDRO_PREFIX/share/man/man1" lf.1
	# bash integration
	install -Dm644 -t "$CLANDRO_PREFIX/etc/profile.d" etc/lfcd.sh
	# csh integration
	install -Dm644 -t "$CLANDRO_PREFIX/etc/profile.d" etc/lf.csh etc/lfcd.csh
	# fish integration
	install -Dm644 -t "$CLANDRO_PREFIX/share/fish/vendor_functions.d" etc/lfcd.fish
	install -Dm644 -t "$CLANDRO_PREFIX/share/fish/vendor_completions.d" etc/lf.fish
	# vim integration
	install -Dm644 -t "$CLANDRO_PREFIX/share/vim/vimfiles/plugin" etc/lf.vim
	# zsh integration
	install -Dm644 -T etc/lfcd.sh "$CLANDRO_PREFIX/share/zsh/site-functions/lfcd"
	install -Dm644 -T etc/lf.zsh "$CLANDRO_PREFIX/share/zsh/site-functions/_lf"
}
