CLANDRO_PKG_HOMEPAGE=https://michael-f-bryan.github.io/mdbook-linkcheck/
CLANDRO_PKG_DESCRIPTION="A backend for mdbook which will check your links for you"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.7.7"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://github.com/Michael-F-Bryan/mdbook-linkcheck/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=3194243acf12383bd328a9440ab1ae304e9ba244d3bd7f85f1c23b0745c4847a
CLANDRO_PKG_DEPENDS="openssl"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	clandro_setup_rust
	export OPENSSL_NO_VENDOR=1
}

clandro_step_make() {
	cargo build --jobs $CLANDRO_PKG_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin target/${CARGO_TARGET_NAME}/release/mdbook-linkcheck
}
