CLANDRO_PKG_HOMEPAGE=https://github.com/GitoxideLabs/gitoxide
CLANDRO_PKG_DESCRIPTION="Rust implementation of Git"
CLANDRO_PKG_LICENSE="Apache-2.0, MIT"
CLANDRO_PKG_LICENSE_FILE="LICENSE-APACHE, LICENSE-MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.53.0"
CLANDRO_PKG_SRCURL="https://github.com/GitoxideLabs/gitoxide/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=81d99c6b60cc93a01dc7539c310e3e8737fe88dd86ee8887cf203ba7b76aca59
CLANDRO_PKG_DEPENDS="resolv-conf"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_METHOD=repology
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"

clandro_step_pre_configure() {
	clandro_setup_cmake
	clandro_setup_rust

	cargo vendor
	find ./vendor \
		-mindepth 1 -maxdepth 1 -type d \
		! -wholename ./vendor/aws-lc-sys \
		! -wholename ./vendor/hickory-resolver \
		! -wholename ./vendor/rustls-platform-verifier \
		-exec rm -rf '{}' \;

	local patch="$CLANDRO_PKG_BUILDER_DIR/aws-lc-sys.diff"
	local dir="vendor/aws-lc-sys"
	echo "Applying patch: $patch"
	patch --silent -p1 -d "${dir}" < "$patch"

	patch="$CLANDRO_PKG_BUILDER_DIR/hickory-resolver.diff"
	dir="vendor/hickory-resolver"
	echo "Applying patch: $patch"
	sed -e "s|@CLANDRO_PREFIX@|$CLANDRO_PREFIX|" \
		"$patch" | patch --silent -p1 -d "${dir}"

	find vendor/rustls-platform-verifier -type f -print0 | \
		xargs -0 sed -i \
		-e 's|"android"|"disabling_this_because_it_is_for_building_an_apk"|g' \
		-e "s|ANDROID|DISABLING_THIS_BECAUSE_IT_IS_FOR_BUILDING_AN_APK|g" \
		-e 's|"linux"|"android"|g'

	echo "" >> Cargo.toml
	echo '[patch.crates-io]' >> Cargo.toml
	echo 'aws-lc-sys = { path = "./vendor/aws-lc-sys" }' >> Cargo.toml
	echo 'hickory-resolver = { path = "./vendor/hickory-resolver" }' >> Cargo.toml
	echo 'rustls-platform-verifier = { path = "./vendor/rustls-platform-verifier" }' >> Cargo.toml

	if [ "$CLANDRO_ARCH" == "x86_64" ]; then
		local env_host=$(printf $CARGO_TARGET_NAME | tr a-z A-Z | sed s/-/_/g)
		export CARGO_TARGET_${env_host}_RUSTFLAGS+=" -C link-arg=$($CC -print-libgcc-file-name)"
	fi
}

clandro_step_make() {
	cargo build \
		--jobs $CLANDRO_PKG_MAKE_PROCESSES \
		--target $CARGO_TARGET_NAME \
		--release \
		--no-default-features \
		--features max-pure
}

clandro_step_make_install() {
	install -Dm755 -t $CLANDRO_PREFIX/bin \
		target/${CARGO_TARGET_NAME}/release/ein \
		target/${CARGO_TARGET_NAME}/release/gix
}
