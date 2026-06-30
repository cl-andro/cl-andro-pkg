CLANDRO_PKG_HOMEPAGE=https://github.com/cargo-bins/cargo-binstall
CLANDRO_PKG_DESCRIPTION="Tool to fetch and install precompiled musl-based static binaries from the Rust ecosystem"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.19.1"
CLANDRO_PKG_SRCURL="https://github.com/cargo-bins/cargo-binstall/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=78a514462b487556265bb68adf9c0288b0e4263c9b08b583825b1cf685e36697
CLANDRO_PKG_DEPENDS="resolv-conf"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	clandro_setup_rust

	cargo vendor
	find ./vendor \
		-mindepth 1 -maxdepth 1 -type d \
		! -wholename ./vendor/rustls-platform-verifier \
		! -wholename ./vendor/hickory-resolver \
		! -wholename ./vendor/camino \
		! -wholename ./vendor/resolv-conf \
		! -wholename ./vendor/netdev \
		-exec rm -rf '{}' \;

	find vendor/{rustls-platform-verifier,hickory-resolver} -type f -print0 | \
		xargs -0 sed -i \
		-e 's|"android"|"disabling_this_because_it_is_for_building_an_apk"|g' \
		-e "s|ANDROID|DISABLING_THIS_BECAUSE_IT_IS_FOR_BUILDING_AN_APK|g" \
		-e 's|"linux"|"android"|g'

	find vendor/{hickory-resolver,camino,resolv-conf,netdev} -type f -print0 | \
		xargs -0 sed -i \
		-e "s|/etc|$CLANDRO_PREFIX/etc|g"

	cat >> Cargo.toml <<-EOF

		[patch.crates-io]
		rustls-platform-verifier = { path = "./vendor/rustls-platform-verifier" }
		hickory-resolver = { path = "./vendor/hickory-resolver" }
		camino = { path = "./vendor/camino" }
		resolv-conf = { path = "./vendor/resolv-conf" }
		netdev = { path = "./vendor/netdev" }
	EOF
}

clandro_step_make() {
	cargo build --jobs "$CLANDRO_PKG_MAKE_PROCESSES" --target "$CARGO_TARGET_NAME" --release
}

clandro_step_make_install() {
	install -Dm700 -t "$CLANDRO_PREFIX/bin" "target/$CARGO_TARGET_NAME/release/$CLANDRO_PKG_NAME"
}
