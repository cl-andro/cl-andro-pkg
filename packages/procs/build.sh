CLANDRO_PKG_HOMEPAGE=https://github.com/dalance/procs
CLANDRO_PKG_DESCRIPTION="A modern replacement for ps"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.14.11"
CLANDRO_PKG_SRCURL=https://github.com/dalance/procs/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=3d6b3561ce05362a092ea8488458f552d6636d3a280290e21f841c432cadf91a
CLANDRO_PKG_BUILD_DEPENDS="asciidoctor"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

# This package contains makefiles to run the tests. So, we need to override build steps.
clandro_step_make() {
	clandro_setup_rust
	cargo build --jobs $CLANDRO_PKG_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
	asciidoctor -b manpage man/procs.1.adoc
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin target/${CARGO_TARGET_NAME}/release/procs
	install -Dm644 man/procs.1 "$CLANDRO_PREFIX"/share/man/man1/procs.1
	install -Dm644 /dev/null "$CLANDRO_PREFIX"/share/bash-completion/completions/procs
	install -Dm644 /dev/null "$CLANDRO_PREFIX"/share/zsh/site-functions/_procs
	install -Dm644 /dev/null "$CLANDRO_PREFIX"/share/fish/vendor_completions.d/procs.fish
}

clandro_step_create_debscripts() {
	cat <<-EOF >./postinst
		#!${CLANDRO_PREFIX}/bin/sh
		procs --gen-completion-out bash > ${CLANDRO_PREFIX}/share/bash-completion/completions/procs
		procs --gen-completion-out zsh > ${CLANDRO_PREFIX}/share/zsh/site-functions/_procs
		procs --gen-completion-out fish > ${CLANDRO_PREFIX}/share/fish/vendor_completions.d/procs.fish
	EOF
}
