CLANDRO_PKG_HOMEPAGE=https://tectonic-typesetting.github.io/
CLANDRO_PKG_DESCRIPTION="A modernized, complete, self-contained TeX/LaTeX engine"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.16.9"
CLANDRO_PKG_SRCURL="https://github.com/tectonic-typesetting/tectonic/archive/refs/tags/tectonic@${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=9861d4d4230b987d8560f1b84fe6c8a550738401be65b9425b0c7d0466178f2b
CLANDRO_PKG_DEPENDS="fontconfig, freetype, harfbuzz, libc++, libgraphite, libicu, libpng, openssl, zlib"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make() {
	clandro_setup_rust
	cargo build --jobs $CLANDRO_PKG_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release --features "external-harfbuzz"
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin target/${CARGO_TARGET_NAME}/release/tectonic
}
