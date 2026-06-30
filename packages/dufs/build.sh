CLANDRO_PKG_HOMEPAGE=https://github.com/sigoden/dufs
CLANDRO_PKG_DESCRIPTION="A file server that supports static serving, uploading, searching, accessing control, webdav..."
CLANDRO_PKG_LICENSE="Apache-2.0,MIT"
CLANDRO_PKG_LICENSE_FILE="LICENSE-APACHE,LICENSE-MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.46.0"
CLANDRO_PKG_SRCURL=https://github.com/sigoden/dufs/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=e5bb926107736802bfd3be6937482dd3daf396a5c481fed714de542055286ebc
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	clandro_setup_rust
	cargo build --jobs $CLANDRO_PKG_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

clandro_step_post_make_install() {
	install -Dm755 -t $CLANDRO_PREFIX/bin target/${CARGO_TARGET_NAME}/release/dufs
	install -Dm644 -t $CLANDRO_PREFIX/share/doc/$CLANDRO_PKG_NAME README*

	install -Dm644 /dev/null "$CLANDRO_PREFIX"/share/bash-completion/completions/dufs
	install -Dm644 /dev/null "$CLANDRO_PREFIX"/share/zsh/site-functions/_dufs
	install -Dm644 /dev/null "$CLANDRO_PREFIX"/share/fish/vendor_completions.d/dufs.fish
}

clandro_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$CLANDRO_PREFIX/bin/sh

	dufs --completions bash \
		> "$CLANDRO_PREFIX"/share/bash-completion/completions/dufs
	dufs --completions zsh \
		> "$CLANDRO_PREFIX"/share/zsh/site-functions/_dufs
	dufs --completions fish \
		> "$CLANDRO_PREFIX"/share/fish/vendor_completions.d/dufs.fish
	EOF
}
