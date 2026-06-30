CLANDRO_PKG_HOMEPAGE="https://github.com/microsoft/edit"
CLANDRO_PKG_DESCRIPTION="A simple editor for simple needs (Microsoft Edit)"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.0.0"
CLANDRO_PKG_SRCURL="https://github.com/microsoft/edit/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=f35da309c5f3d92b10e5c4b2267e4d5e29d809b2aa460e80326b11f7feba72a5
CLANDRO_PKG_DEPENDS="libicu"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	clandro_setup_rust
}

clandro_step_make() {
	# Allow nightly features
	export RUSTC_BOOTSTRAP=1
	cargo build --release \
		--jobs $CLANDRO_PKG_MAKE_PROCESSES \
		--target "$CARGO_TARGET_NAME"
}

clandro_step_make_install() {
	install -Dm755 "$CLANDRO_PKG_SRCDIR/target/${CARGO_TARGET_NAME}/release/edit" "$CLANDRO_PREFIX/bin/msedit"
	ln -sf "./msedit" "$CLANDRO_PREFIX/bin/edit" # and symlink bin/edit
	install -Dm644 "$CLANDRO_PKG_SRCDIR/assets/manpage/edit.1" "$CLANDRO_PREFIX/share/man/man1/msedit.1"
	ln -sf "./msedit.1.gz" "$CLANDRO_PREFIX/share/man/man1/edit.1.gz" # and symlink man1/edit.1.gz
}
