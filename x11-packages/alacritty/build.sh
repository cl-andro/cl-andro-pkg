CLANDRO_PKG_HOMEPAGE=https://alacritty.org/
CLANDRO_PKG_DESCRIPTION="A fast, cross-platform, OpenGL terminal emulator"
CLANDRO_PKG_LICENSE="Apache-2.0, MIT"
CLANDRO_PKG_MAINTAINER="Joshua Kahn <tom@termux.dev>"
CLANDRO_PKG_VERSION="0.17.0"
CLANDRO_PKG_SRCURL="https://github.com/alacritty/alacritty/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=38d6527d346cda5c6049332a1f3338a89ea66cd7981b54d4c3ce801b392496f8
CLANDRO_PKG_DEPENDS="fontconfig, freetype, libxcursor, libxi, libxrandr"
CLANDRO_PKG_BUILD_DEPENDS="libxcb, libxkbcommon, ncurses"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_configure() {
	clandro_setup_cmake
	clandro_setup_rust
	cargo clean
	cargo vendor

	find ./vendor \
		-mindepth 1 -maxdepth 1 -type d \
		! -wholename ./vendor/copypasta \
		! -wholename ./vendor/freetype-sys \
		! -wholename ./vendor/glutin \
		! -wholename ./vendor/glutin_glx_sys \
		! -wholename ./vendor/smithay-client-toolkit \
		! -wholename ./vendor/wayland-cursor \
		! -wholename ./vendor/winit \
		! -wholename ./vendor/x11rb-protocol \
		! -wholename ./vendor/xkbcommon-dl \
		-exec rm -rf '{}' \;

	local diff crate_name
	for diff in "$CLANDRO_PKG_BUILDER_DIR"/*.vendor.diff; do
		crate_name="$(basename "$diff" .vendor.diff)"
		echo "Applying patch: $diff"
		patch -p1 < "$diff"
	done

	local -a CARGO_PATCH_LINES=()
	for crate_name in copypasta freetype-sys glutin glutin_glx_sys smithay-client-toolkit wayland-cursor winit x11rb-protocol xkbcommon-dl; do
		find "vendor/$crate_name" -type f -print0 | \
			xargs -0 sed -i \
			-e 's|"android"|"disabling_this_because_it_is_for_building_an_apk"|g' \
			-e 's|"linux"|"android"|g' \
			-e "s|libxkbcommon.so.0|libxkbcommon.so|g" \
			-e "s|libxkbcommon-x11.so.0|libxkbcommon-x11.so|g" \
			-e "s|libxcb.so.1|libxcb.so|g" \
			-e "s|/tmp|$CLANDRO_PREFIX/tmp|g"
		CARGO_PATCH_LINES+=("$crate_name = { path = \"./vendor/$crate_name\" }")
	done

	{
		printf '%s\n' \
			"" \
			"[patch.crates-io]" \
			"${CARGO_PATCH_LINES[@]}"
	} >> Cargo.toml
}

clandro_step_make() {
	cargo build \
		--jobs "$CLANDRO_PKG_MAKE_PROCESSES" \
		--target "$CARGO_TARGET_NAME" \
		--release
}

clandro_step_make_install() {
	install -Dm755 -t "$CLANDRO_PREFIX/bin" \
		"target/$CARGO_TARGET_NAME/release/alacritty"

	scdoc < extra/man/alacritty.1.scd | gzip -c > "$CLANDRO_PREFIX/share/man/man1/alacritty.1.gz"
	scdoc < extra/man/alacritty-msg.1.scd | gzip -c > "$CLANDRO_PREFIX/share/man/man1/alacritty-msg.1.gz"
	scdoc < extra/man/alacritty.5.scd | gzip -c > "$CLANDRO_PREFIX/share/man/man5/alacritty.5.gz"
	scdoc < extra/man/alacritty-bindings.5.scd | gzip -c > "$CLANDRO_PREFIX/share/man/man5/alacritty-bindings.5.gz"

	install -Dm644 extra/completions/_alacritty \
		"$CLANDRO_PREFIX/share/zsh/site-functions/_alacritty"
	install -Dm644 extra/completions/alacritty.bash \
		"$CLANDRO_PREFIX/share/bash-completion/completions/alacritty.bash"
	install -Dm644 extra/completions/alacritty.fish \
		"$CLANDRO_PREFIX/share/fish/vendor_completions.d/alacritty.fish"
	install -Dm644 extra/linux/Alacritty.desktop \
		"$CLANDRO_PREFIX/share/applications/Alacritty.desktop"
	install -Dm644 extra/logo/alacritty-term.svg \
		"$CLANDRO_PREFIX/share/icons/hicolor/scalable/apps/Alacritty.svg"
}
