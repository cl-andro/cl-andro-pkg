CLANDRO_PKG_HOMEPAGE=https://github.com/svenstaro/miniserve
CLANDRO_PKG_DESCRIPTION="Tool to serve files and dirs over HTTP"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.35.0"
CLANDRO_PKG_SRCURL=https://github.com/svenstaro/miniserve/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=8ae108c161f2ed740f8c4b4dfd0a80805adcbaf7a05a6128f2b4d8f5093f5490
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	clandro_setup_rust

	rm -f Makefile
}

clandro_step_post_make_install() {
	# shell completions
	install -Dm644 /dev/null "$CLANDRO_PREFIX"/share/bash-completion/completions/miniserve
	install -Dm644 /dev/null "$CLANDRO_PREFIX"/share/zsh/site-functions/_miniserve
	install -Dm644 /dev/null "$CLANDRO_PREFIX"/share/fish/vendor_completions.d/miniserve.fish

	# manpage
	install -Dm644 /dev/null "$CLANDRO_PREFIX"/share/man/man1/miniserve.1
}

clandro_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$CLANDRO_PREFIX/bin/sh

	miniserve --print-completions bash \
		> "$CLANDRO_PREFIX"/share/bash-completion/completions/miniserve
	miniserve --print-completions zsh \
		> "$CLANDRO_PREFIX"/share/zsh/site-functions/_miniserve
	miniserve --print-completions fish \
		> "$CLANDRO_PREFIX"/share/fish/vendor_completions.d/miniserve.fish
	miniserve --print-manpage \
		> "$CLANDRO_PREFIX"/share/man/man1/miniserve.1

	# Warn user on default behaviour of miniserve.
	echo
	echo "WARNING: miniserve follows symlinks in selected directory by default. Consider aliasing it with '--no-symlinks' for safety."
	echo "See: https://github.com/svenstaro/miniserve/issues/498"
	echo
	EOF
}
