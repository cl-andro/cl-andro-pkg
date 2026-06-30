CLANDRO_PKG_HOMEPAGE=https://github.com/Macchina-CLI/macchina
CLANDRO_PKG_DESCRIPTION="A system information fetcher, with an emphasis on performance and minimalism."
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.4.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=git+https://github.com/Macchina-CLI/macchina
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXCLUDED_ARCHES="arm, i686"

clandro_step_make() {
	clandro_setup_rust
	cargo build --jobs ${CLANDRO_PKG_MAKE_PROCESSES} --target ${CARGO_TARGET_NAME} --release
}

clandro_step_make_install() {
	install -Dm755 -t ${CLANDRO_PREFIX}/bin target/${CARGO_TARGET_NAME}/release/macchina
}
