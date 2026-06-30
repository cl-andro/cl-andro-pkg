CLANDRO_PKG_HOMEPAGE=https://yazi-rs.github.io/
CLANDRO_PKG_DESCRIPTION="Blazing fast terminal file manager written in Rust, based on async I/O"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="26.1.22"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/sxyazi/yazi/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=83b8a1bf166bfcb54b44b966fa3f34afa7c55584bf81d29275a1cdd99d1c9c4c
CLANDRO_PKG_BUILD_DEPENDS='aosp-libs, imagemagick'
CLANDRO_PKG_RECOMMENDS='7zip, chafa, fd, ffmpeg, fzf, imagemagick, jq, poppler, ripgrep, zoxide'
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	clandro_setup_rust
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		clandro_setup_proot
	fi

	cargo vendor
	find ./vendor \
		-mindepth 1 -maxdepth 1 -type d \
		! -wholename ./vendor/trash \
		-exec rm -rf '{}' \;

	find vendor/trash -type f -print0 | \
		xargs -0 sed -i \
		-e 's|"android"|"disabling_this_because_it_is_for_building_an_apk"|g' \
		-e "s|/tmp|$CLANDRO_PREFIX/tmp|g"

	local patch="$CLANDRO_PKG_BUILDER_DIR/trash-rs-implement-get_mount_points-android.diff"
	local dir="vendor/trash"
	echo "Applying patch: $patch"
	patch -p1 -d "$dir" < "$patch"

	echo "" >> Cargo.toml
	echo '[patch.crates-io]' >> Cargo.toml
	echo 'trash = { path = "./vendor/trash" }' >> Cargo.toml
}

clandro_step_make() {
	VERGEN_GIT_SHA="termux" \
	YAZI_GEN_COMPLETIONS=true \
	cargo build --jobs "$CLANDRO_PKG_MAKE_PROCESSES" --target "$CARGO_TARGET_NAME" --release
}

clandro_step_make_install() {
	install -Dm700 -t "$CLANDRO_PREFIX/bin" "target/${CARGO_TARGET_NAME}/release/yazi"
	install -Dm700 -t "$CLANDRO_PREFIX/bin" "target/${CARGO_TARGET_NAME}/release/ya"

	# shell completions
	install -Dm644 yazi-boot/completions/yazi.bash "$CLANDRO_PREFIX/share/bash-completion/completions/yazi.bash"
	install -Dm644 yazi-boot/completions/yazi.elv  "$CLANDRO_PREFIX/share/elvish/lib/yazi.elv"
	install -Dm644 yazi-boot/completions/yazi.fish "$CLANDRO_PREFIX/share/fish/vendor_completions.d/yazi.fish"
	install -Dm644 yazi-boot/completions/yazi.nu   "$CLANDRO_PREFIX/share/nushell/vendor/autoload/yazi.nu"
	install -Dm644 yazi-boot/completions/_yazi     "$CLANDRO_PREFIX/share/zsh/site-functions/_yazi"

	# desktop entry
	install -Dm644 assets/yazi.desktop "$CLANDRO_PREFIX/share/applications/yazi.desktop"

	# application icons
	local res
	local clandro_proot_run=''
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		clandro_proot_run=termux-proot-run
	fi
	echo -n "Generating icons:"
	for res in 16 24 32 48 64 128 256; do
		mkdir -p "${CLANDRO_PREFIX}/share/icons/hicolor/${res}x${res}/apps"
		$clandro_proot_run magick assets/logo.png \
			-resize "${res}x${res}" \
			"${CLANDRO_PREFIX}/share/icons/hicolor/${res}x${res}/apps/yazi.png"
		[[ -e "${CLANDRO_PREFIX}/share/icons/hicolor/${res}x${res}/apps/yazi.png" ]] && {
			echo -n " ${res}x${res}"
		}
	done
	echo
}

clandro_step_create_debscripts() {
	cat <<- POSTINST_EOF > ./postinst
	#!$CLANDRO_PREFIX/bin/sh
	echo "Please change font from termux-styling addon"
	POSTINST_EOF
}
