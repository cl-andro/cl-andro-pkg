CLANDRO_PKG_HOMEPAGE="https://github.com/flxzt/rnote"
CLANDRO_PKG_DESCRIPTION="An infinite canvas vector-based drawing application for handwritten notes"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@EDLLT"
CLANDRO_PKG_VERSION="0.14.2"
CLANDRO_PKG_SRCURL="https://github.com/flxzt/rnote/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=10dd7849b593034b7fbd55f5b5baa51fb082ef48d96e1a6200d361e6ed49363e
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="alsa-lib, gdk-pixbuf, gettext, glib, graphene, gtk4, hicolor-icon-theme, libadwaita, libcairo, pipewire, pango, poppler"
CLANDRO_PKG_BUILD_DEPENDS="libiconv"
CLANDRO_PKG_PYTHON_CROSS_BUILD_DEPS="toml2json"

clandro_step_pre_configure() {
	clandro_setup_cmake
	clandro_setup_glib_cross_pkg_config_wrapper
}

clandro_step_make() {
	clandro_setup_rust

	local env_host=$(printf $CARGO_TARGET_NAME | tr a-z A-Z | sed s/-/_/g)
	export CARGO_TARGET_${env_host}_RUSTFLAGS+=" -C link-arg=-liconv"

	cd "${CLANDRO_PKG_SRCDIR}" || clandro_error_exit "Failed to enter source directory, aborting build."
	cargo vendor
	find ./vendor \
		-mindepth 1 -maxdepth 1 -type d \
		! -wholename ./vendor/cpal \
		-exec rm -rf '{}' \;

	find vendor/cpal -type f -print0 | \
		xargs -0 sed -i \
		-e 's|"android"|"disabling_this_because_it_is_for_building_an_apk"|g' \
		-e 's|"linux"|"android"|g'

	sed -i '/\[patch.crates-io\]/a cpal = { path = "./vendor/cpal" }' Cargo.toml

	local target
	for target in 'rnote-cli' 'rnote'; do
		cargo build \
		--jobs "${CLANDRO_PKG_MAKE_PROCESSES}" \
		--target "${CARGO_TARGET_NAME}" \
		--package "${target}" \
		--release
	done
}

clandro_step_post_make_install() {
	install -Dm755 "${CLANDRO_PKG_SRCDIR}/target/$CARGO_TARGET_NAME/release/rnote-cli" -t "$CLANDRO_PREFIX/bin"
	install -Dm755 "${CLANDRO_PKG_SRCDIR}/target/$CARGO_TARGET_NAME/release/rnote" -t "$CLANDRO_PREFIX/bin"
}
