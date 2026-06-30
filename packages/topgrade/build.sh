CLANDRO_PKG_HOMEPAGE=https://github.com/topgrade-rs/topgrade/
CLANDRO_PKG_DESCRIPTION="Upgrade all the things"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="17.4.0"
CLANDRO_PKG_SRCURL="https://github.com/topgrade-rs/topgrade/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=97b325d4e17b1b5699090382af2240c70629432da4677400151aae05af38cf64
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	clandro_setup_rust
}

clandro_step_post_get_source() {
	rm -f pyproject.toml
}

clandro_step_post_massage() {
	mkdir -p ./share/bash-completion/completions
	mkdir -p ./share/zsh/site-functions
	mkdir -p ./share/fish/vendor_completions.d
	mkdir -p ./share/man/man1
}

clandro_step_create_debscripts() {
	cat <<-EOF > ./postinst
		#!${CLANDRO_PREFIX}/bin/sh
		${CLANDRO_PREFIX}/bin/topgrade --gen-completion bash > ${CLANDRO_PREFIX}/share/bash-completion/completions/topgrade
		${CLANDRO_PREFIX}/bin/topgrade --gen-completion zsh > ${CLANDRO_PREFIX}/share/zsh/site-functions/_topgrade
		${CLANDRO_PREFIX}/bin/topgrade --gen-completion fish > ${CLANDRO_PREFIX}/share/fish/vendor_completions.d/topgrade.fish
		${CLANDRO_PREFIX}/bin/topgrade --gen-manpage > ${CLANDRO_PREFIX}/share/man/man1/topgrade.1
		exit 0
	EOF
	cat <<-EOF > ./prerm
		#!${CLANDRO_PREFIX}/bin/sh
		rm -f ${CLANDRO_PREFIX}/share/bash-completion/completions/topgrade
		rm -f ${CLANDRO_PREFIX}/share/zsh/site-functions/_topgrade
		rm -f ${CLANDRO_PREFIX}/share/fish/vendor_completions.d/topgrade.fish
		rm -f ${CLANDRO_PREFIX}/share/man/man1/topgrade.1
		exit 0
	EOF
}
