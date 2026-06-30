CLANDRO_PKG_HOMEPAGE=https://gleam.run
CLANDRO_PKG_DESCRIPTION="A friendly language for building type-safe, scalable systems!"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.16.0"
CLANDRO_PKG_SRCURL=https://github.com/gleam-lang/gleam/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=dd676c5faff4963d7a26683b164788a09f1261326bcb1c7fc20e001ed3843c30
CLANDRO_PKG_DEPENDS="erlang"
CLANDRO_PKG_SUGGESTS="nodejs | nodejs-lts"
CLANDRO_PKG_ANTI_BUILD_DEPENDS="nodejs, nodejs-lts"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_configure() {
	clandro_setup_rust
}

clandro_step_make() {
	cargo build --jobs "${CLANDRO_PKG_MAKE_PROCESSES}" --target "${CARGO_TARGET_NAME}" --release
}

clandro_step_make_install() {
	install -Dm700 -t "${CLANDRO_PREFIX}/bin" "target/${CARGO_TARGET_NAME}/release/gleam"
}
