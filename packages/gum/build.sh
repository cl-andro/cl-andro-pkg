CLANDRO_PKG_HOMEPAGE="https://github.com/charmbracelet/gum"
CLANDRO_PKG_DESCRIPTION="A tool for creating minimal interactive TUIs for shell scripts"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_LICENSE_FILE="LICENSE"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.17.0"
CLANDRO_PKG_SRCURL="https://github.com/charmbracelet/gum/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=763a7f89dfebf8e77f86e680bace48a09423cfb9e4b4f4ba22d2c9836d311f95
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make() {
	clandro_setup_golang
	cd "$CLANDRO_PKG_SRCDIR"
	export GOPATH="${CLANDRO_PKG_BUILDDIR}"
	go build
}

clandro_step_make_install() {
	install -Dm755 -t "${CLANDRO_PREFIX}/bin" "${CLANDRO_PKG_SRCDIR}/gum"

	install -Dm644 /dev/null $CLANDRO_PREFIX/share/man/man1/gum.1
	install -Dm644 /dev/null $CLANDRO_PREFIX/share/bash-completion/completions/gum
	install -Dm644 /dev/null $CLANDRO_PREFIX/share/zsh/site-functions/_gum
	install -Dm644 /dev/null $CLANDRO_PREFIX/share/fish/vendor_completions.d/gum.fish
}

clandro_step_create_debscripts() {
	# Note: the following lines should be indented with *tabs* (not spaces)
	cat <<- EOF > ./postinst
	#!$CLANDRO_PREFIX/bin/sh

	# Generating manpages
	printf >&2 "%s\n" "Generating manpages for gum"
	if ! gum man > "$CLANDRO_PREFIX/share/man/man1/gum.1"; then
		printf >&2 "\t%s\n" "manpages for gum: FAILED"
	fi

	# Generating shell completions
	printf >&2 "%s\n" "Generating shell completions for gum"
	if ! gum completion bash \
		> "$CLANDRO_PREFIX/share/bash-completion/completions/gum"; then
		printf >&2 "\t%s\n" "bash completions for gum: FAILED"
	fi
	if ! gum completion zsh \
		> "$CLANDRO_PREFIX/share/zsh/site-functions/_gum"; then
		printf >&2 "\t%s\n" "zsh completions for gum: FAILED"
	fi
	if ! gum completion fish \
		> "$CLANDRO_PREFIX/share/fish/vendor_completions.d/gum.fish"; then
		printf >&2 "\t%s\n" "fish completions for gum: FAILED"
	fi
	EOF
}
