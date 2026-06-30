CLANDRO_PKG_HOMEPAGE=https://github.com/yuri-xyz/chroma.git
CLANDRO_PKG_DESCRIPTION="Shader-based audio visualizer for the terminal"
CLANDRO_PKG_LICENSE="GPL-3.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.0.0+g3c32e7d"
CLANDRO_PKG_SRCURL="https://github.com/yuri-xyz/chroma/archive/${CLANDRO_PKG_VERSION##*+g}.tar.gz"
CLANDRO_PKG_SHA256=464789449f261051f194ef44c0d71c3e9e139e6e9effa63ee7787a9c6fa91350
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_DEPENDS="vulkan-icd, alsa-lib"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--features audio"

clandro_step_pre_configure() {
	clandro_setup_rust

	cargo vendor
	find ./vendor \
		-mindepth 1 -maxdepth 1 -type d \
		! -wholename ./vendor/cpal \
		! -wholename ./vendor/wgpu \
		! -wholename ./vendor/wgpu-hal \
		-exec rm -rf '{}' \;

	find \
		vendor/cpal \
		vendor/wgpu \
		vendor/wgpu-hal \
		-type f -print0 | \
		xargs -0 sed -i \
		-e 's|\\"android\\"|\\"disabling_this_because_it_is_for_building_an_apk\\"|g' \
		-e 's|"android"|"disabling_this_because_it_is_for_building_an_apk"|g' \
		-e 's|\\"linux\\"|\\"android\\"|g' \
		-e 's|"linux"|"android"|g'

	echo "" >> Cargo.toml
	echo '[patch.crates-io]' >> Cargo.toml
	echo 'cpal = { path = "./vendor/cpal" }' >> Cargo.toml
	echo 'wgpu = { path = "./vendor/wgpu" }' >> Cargo.toml
	echo 'wgpu-hal = { path = "./vendor/wgpu-hal" }' >> Cargo.toml
}
