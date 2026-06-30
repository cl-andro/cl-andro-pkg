CLANDRO_PKG_HOMEPAGE=https://github.com/sytsereitsma/mdbook-plantuml
CLANDRO_PKG_DESCRIPTION="mdBook preprocessor to render PlantUML code blocks as images in your book"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.8.0
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=git+https://github.com/sytsereitsma/mdbook-plantuml
CLANDRO_PKG_DEPENDS="openssl"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	clandro_setup_rust

	: "${CARGO_HOME:=$HOME/.cargo}"
	export CARGO_HOME

	cargo vendor
	find ./vendor \
		-mindepth 1 -maxdepth 1 -type d \
		! -wholename ./vendor/traitobject \
		-exec rm -rf '{}' \;

	patch --silent -p1 \
		-d ./vendor/traitobject/ \
		< "$CLANDRO_PKG_BUILDER_DIR"/traitobject-rust-1.87.diff

	echo "" >> Cargo.toml
	echo '[patch.crates-io]' >> Cargo.toml
	echo 'traitobject = { path = "./vendor/traitobject" }' >> Cargo.toml
}

clandro_step_make() {
	clandro_setup_rust
	cargo build --jobs $CLANDRO_PKG_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin target/${CARGO_TARGET_NAME}/release/mdbook-plantuml
}
