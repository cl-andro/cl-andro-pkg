CLANDRO_PKG_HOMEPAGE=https://biomejs.dev/
CLANDRO_PKG_DESCRIPTION="A toolchain for web projects, aimed to provide functionalities to maintain them. Biome offers formatter and linter, usable via CLI and LSP"
CLANDRO_PKG_LICENSE="Apache-2.0, MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.4.14"
CLANDRO_PKG_SRCURL=https://github.com/biomejs/biome/archive/refs/tags/@biomejs/biome@${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=b78ed9c873ccaa598e8c6ee8824f539048d25e7befba40f52ec4509cdf9acb0c
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make() {
	clandro_setup_rust
	BIOME_VERSION="$CLANDRO_PKG_VERSION" cargo build --package biome_cli --jobs "$CLANDRO_PKG_MAKE_PROCESSES" --target "$CARGO_TARGET_NAME" --release
}

clandro_step_make_install() {
	install -Dm700 -t "$CLANDRO_PREFIX/bin" "target/${CARGO_TARGET_NAME}/release/biome"
}
