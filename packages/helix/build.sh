CLANDRO_PKG_HOMEPAGE="https://helix-editor.com/"
CLANDRO_PKG_DESCRIPTION="A post-modern modal text editor written in rust"
CLANDRO_PKG_LICENSE="MPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="25.07.1"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://github.com/helix-editor/helix/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=27c8bc3eba46bc7bab1e3629c6b28ff94882eeff17366b3ea69cd8ceffba7541
CLANDRO_PKG_SUGGESTS="helix-grammars, bash-completion, clang, delve, elvish, gopls, lldb, nodejs | nodejs-lts"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_RM_AFTER_INSTALL="
opt/helix/runtime/grammars/sources/
"

clandro_step_pre_configure() {
	clandro_setup_rust

	# clash with rust host build
	unset CFLAGS
}

clandro_step_make() {
	cargo build --jobs "${CLANDRO_PKG_MAKE_PROCESSES}" --target "${CARGO_TARGET_NAME}" --release
}

clandro_step_make_install() {
	local datadir="${CLANDRO_PREFIX}/opt/${CLANDRO_PKG_NAME}"
	rm -rf "${datadir}"
	mkdir -p "${datadir}"

	cat >"${CLANDRO_PREFIX}/bin/hx" <<-EOF
	#!${CLANDRO_PREFIX}/bin/sh
	HELIX_RUNTIME=${datadir}/runtime exec ${datadir}/hx "\$@"
	EOF
	chmod 0700 "${CLANDRO_PREFIX}/bin/hx"

	install -Dm700 target/"${CARGO_TARGET_NAME}"/release/hx "${datadir}/hx"

	cp -r ./runtime "${datadir}"
	find "${datadir}"/runtime/grammars -type f -name "*.so" -exec chmod 0600 "{}" \;

	install -Dm 0644 "contrib/completion/hx.zsh" "${CLANDRO_PREFIX}/share/zsh/site-functions/_hx"
	install -Dm 0644 "contrib/completion/hx.bash" "${CLANDRO_PREFIX}/share/bash-completion/completions/hx"
	install -Dm 0644 "contrib/completion/hx.fish" "${CLANDRO_PREFIX}/share/fish/vendor_completions.d/hx.fish"
}
