CLANDRO_PKG_HOMEPAGE=https://github.com/wez/wezterm
CLANDRO_PKG_DESCRIPTION="GPU-accelerated cross-platform terminal emulator and multiplexer"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="20240203-110809-5046fc22"
CLANDRO_PKG_SRCURL="https://github.com/wezterm/wezterm/releases/download/$CLANDRO_PKG_VERSION/wezterm-$CLANDRO_PKG_VERSION-src.tar.gz"
CLANDRO_PKG_SHA256=df60b1081d402b5a9239cc4cef16fc699eab68bbbeac9c669cb5d991a6010b2c
CLANDRO_PKG_DEPENDS="fontconfig, freetype, glib, harfbuzz, hicolor-icon-theme, libpng, libssh2, libx11, libxcb, libxkbcommon, openssl, ttf-jetbrains-mono, xdg-utils, xcb-util, xcb-util-image, zlib"
CLANDRO_PKG_RECOMMENDS="ncurses, ttf-nerd-fonts-symbols"
CLANDRO_PKG_BREAKS="wezterm-nightly"
CLANDRO_PKG_CONFLICTS="wezterm-nightly"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	clandro_setup_rust

	sed -i 's/"vendored-fonts", //' wezterm-gui/Cargo.toml

	export LIBSSH2_SYS_USE_PKG_CONFIG=1

	cargo vendor
	find ./vendor \
		-mindepth 1 -maxdepth 1 -type d \
		! -wholename ./vendor/mac_address \
		! -wholename ./vendor/serial-unix \
		! -wholename ./vendor/serial-core \
		! -wholename ./vendor/libssh-rs-sys \
		! -wholename ./vendor/wgpu \
		! -wholename ./vendor/wayland-cursor \
		! -wholename ./vendor/starship-battery \
		! -wholename ./vendor/smithay-client-toolkit \
		! -wholename ./vendor/wgpu-hal \
		-exec rm -rf '{}' \;

	# rust-battery will not support Android
	# https://github.com/svartalf/rust-battery/issues/33#issuecomment-529193904
	# but if the "linux" backend for it is forced,
	# the wezterm battery information API
	# https://wezterm.org/config/lua/wezterm/battery_info.html
	# actually works and shows the correct battery level on my
	# Samsung Galaxy S8+ SM-G955F with LineageOS 21 Android 14.
	# Treat Android as Linux for this library.
	# on my Samsung Galaxy S9 SM-G960U with Samsung One UI 2.5 Android 10,
	# wezterm logs "permission denied", but with a handled error and does not crash
	# and other wezterm functionality is not impeded.
	find \
		vendor/mac_address \
		vendor/starship-battery \
		vendor/wgpu-hal \
		window \
		-type f -print0 | \
		xargs -0 sed -i \
		-e 's|\\"android\\"|\\"disabling_this_because_it_is_for_building_an_apk\\"|g' \
		-e 's|"android"|"disabling_this_because_it_is_for_building_an_apk"|g' \
		-e 's|\\"linux\\"|\\"android\\"|g' \
		-e 's|"linux"|"android"|g'

	local patch="$CLANDRO_PKG_BUILDER_DIR/serial-unix-bump-termios.diff"
	local dir="vendor/serial-unix"
	echo "Applying patch: $patch"
	patch -p1 -d "$dir" < "${patch}"

	local patch="$CLANDRO_PKG_BUILDER_DIR/libssh-rs-sys-termux.diff"
	local dir="vendor/libssh-rs-sys"
	echo "Applying patch: $patch"
	patch -p1 -d "$dir" < "${patch}"

	local patch="$CLANDRO_PKG_BUILDER_DIR/wayland-cursor-no-shm.diff"
	local dir="vendor/wayland-cursor"
	echo "Applying patch: $patch"
	patch -p1 -d "$dir" < "${patch}"

	local patch="$CLANDRO_PKG_BUILDER_DIR/smithay-client-toolkit-no-shm.diff"
	local dir="vendor/smithay-client-toolkit"
	echo "Applying patch: $patch"
	patch -p1 -d "$dir" < "${patch}"

	sed -i '/\[patch.crates-io\]/a mac_address = { path = "./vendor/mac_address" }' Cargo.toml
	sed -i '/\[patch.crates-io\]/a serial-unix = { path = "./vendor/serial-unix" }' Cargo.toml
	sed -i '/\[patch.crates-io\]/a serial-core = { path = "./vendor/serial-core" }' Cargo.toml
	sed -i '/\[patch.crates-io\]/a libssh-rs-sys = { path = "./vendor/libssh-rs-sys" }' Cargo.toml
	sed -i '/\[patch.crates-io\]/a wayland-cursor = { path = "./vendor/wayland-cursor" }' Cargo.toml
	sed -i '/\[patch.crates-io\]/a starship-battery = { path = "./vendor/starship-battery" }' Cargo.toml
	sed -i '/\[patch.crates-io\]/a smithay-client-toolkit = { path = "./vendor/smithay-client-toolkit" }' Cargo.toml
	sed -i '/\[patch.crates-io\]/a wgpu-hal = { path = "./vendor/wgpu-hal" }' Cargo.toml

	# fixes 'error[E0282]: type annotations needed for `Box<_>`'
	# https://github.com/time-rs/time/issues/717
	# wgpu --precise 0.18.0 is necessary to avoid
	# error: failed to select a version for the requirement `wgpu = "^0.18"`
	# because the stable releease 20240203-110809-5046fc22 of wezterm
	# has a hard exact dependency on the yanked version 0.18.0
	# of crate wgpu
	cargo update wgpu --precise 0.18.0 time
}

clandro_step_make() {
	cargo build \
		--jobs "${CLANDRO_PKG_MAKE_PROCESSES}" \
		--target "${CARGO_TARGET_NAME}" \
		--release \
		--features distro-defaults
}

clandro_step_make_install() {
	install -Dm755 "target/${CARGO_TARGET_NAME}/release/${CLANDRO_PKG_NAME}" -t "${CLANDRO_PREFIX}/bin"
	install -Dm755 "target/${CARGO_TARGET_NAME}/release/${CLANDRO_PKG_NAME}-gui" -t "${CLANDRO_PREFIX}/bin"
	install -Dm755 "target/${CARGO_TARGET_NAME}/release/${CLANDRO_PKG_NAME}-mux-server" -t "${CLANDRO_PREFIX}/bin"
	install -Dm755 "target/${CARGO_TARGET_NAME}/release/strip-ansi-escapes" -t "${CLANDRO_PREFIX}/bin"
	install -Dm644 assets/icon/terminal.png "${CLANDRO_PREFIX}/share/icons/hicolor/128x128/apps/org.wezfurlong.${CLANDRO_PKG_NAME}.png"
	install -Dm644 "assets/${CLANDRO_PKG_NAME}.desktop" "${CLANDRO_PREFIX}/share/applications/org.wezfurlong.${CLANDRO_PKG_NAME}.desktop"
	install -Dm644 "assets/${CLANDRO_PKG_NAME}.appdata.xml" "${CLANDRO_PREFIX}/share/metainfo/org.wezfurlong.${CLANDRO_PKG_NAME}.appdata.xml"
	install -Dm644 "assets/${CLANDRO_PKG_NAME}-nautilus.py" "${CLANDRO_PREFIX}/share/nautilus-python/extensions/${CLANDRO_PKG_NAME}-nautilus.py"
	install -Dm755 "assets/open-${CLANDRO_PKG_NAME}-here" -t "${CLANDRO_PREFIX}/bin"
	install -Dm644 README.md -t "${CLANDRO_PREFIX}/share/doc/${CLANDRO_PKG_NAME}"
	install -Dm644 assets/shell-completion/bash "${CLANDRO_PREFIX}/share/bash-completion/completions/${CLANDRO_PKG_NAME}"
	install -Dm644 assets/shell-completion/fish "${CLANDRO_PREFIX}/share/fish/vendor_completions.d/${CLANDRO_PKG_NAME}.fish"
	install -Dm644 assets/shell-completion/zsh "${CLANDRO_PREFIX}/share/zsh/site-functions/_${CLANDRO_PKG_NAME}"
	install -Dm644 assets/shell-integration/${CLANDRO_PKG_NAME}.sh -t "${CLANDRO_PREFIX}/etc/profile.d"
}
