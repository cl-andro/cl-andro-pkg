CLANDRO_PKG_HOMEPAGE=https://github.com/dnglab/dnglab
CLANDRO_PKG_DESCRIPTION="Camera RAW to DNG file format converter"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="Florian Wagner <florian@wagner-flo.de>"
CLANDRO_PKG_VERSION="0.7.2"
CLANDRO_PKG_SRCURL=https://github.com/dnglab/dnglab/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=c363a5ff8c058dd6d2ffe22a2ece986fa6ad146043f0211d9b77d789083901ce
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make() {
	clandro_setup_rust
	cargo build --jobs $CLANDRO_PKG_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

clandro_step_make_install() {
	install -Dm755 -t "${CLANDRO_PREFIX}"/bin target/${CARGO_TARGET_NAME}/release/dnglab
	install -Dm644 bin/dnglab/completions/dnglab.bash "${CLANDRO_PREFIX}/share/bash-completion/completions/dnglab"
}

clandro_step_make_install() {
	install -Dm755 -t "${CLANDRO_PREFIX}"/bin target/${CARGO_TARGET_NAME}/release/dnglab
	# Manpages
	install -Dm755 -t "${CLANDRO_PREFIX}"/share/man/man1 bin/dnglab/manpages/*.1
	# Shell completions
	install -Dm644 bin/dnglab/completions/_dnglab "${CLANDRO_PREFIX}/share/zsh/site-functions/_dnglab"
	install -Dm644 bin/dnglab/completions/dnglab.bash "${CLANDRO_PREFIX}/share/bash-completion/completions/dnglab"
	install -Dm644 bin/dnglab/completions/dnglab.fish "${CLANDRO_PREFIX}/share/fish/vendor_completions.d/dnglab.fish"
	install -Dm644 bin/dnglab/completions/dnglab.elv "${CLANDRO_PREFIX}/share/elvish/lib/dnglab.elv"
}
