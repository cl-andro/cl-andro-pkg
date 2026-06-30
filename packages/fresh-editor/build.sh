CLANDRO_PKG_HOMEPAGE=https://getfresh.dev/
CLANDRO_PKG_DESCRIPTION="Text editor for your terminal: easy, powerful and fast"
CLANDRO_PKG_LICENSE="GPL-2.0-only"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.3.5"
CLANDRO_PKG_SRCURL="https://github.com/sinelaw/fresh/releases/download/v$CLANDRO_PKG_VERSION/fresh-editor-$CLANDRO_PKG_VERSION-source.tar.gz"
CLANDRO_PKG_SHA256=d1a549b882f62bd193fe5ce0adbb8d32ab022b1541ae241ece79055427f6d402
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	clandro_setup_rust

	cargo vendor
	find ./vendor \
		-mindepth 1 -maxdepth 1 -type d \
		! -wholename ./vendor/trash \
		! -wholename ./vendor/arboard \
		! -wholename ./vendor/x11rb-protocol \
		! -wholename ./vendor/cc \
		! -wholename ./vendor/winit \
		! -wholename ./vendor/x11rb-protocol \
		! -wholename ./vendor/xkbcommon-dl \
		! -wholename ./vendor/wayland-cursor \
		! -wholename ./vendor/smithay-client-toolkit \
		-exec rm -rf '{}' \;

	local patch="$CLANDRO_PKG_BUILDER_DIR/rust-cc-do-not-concatenate-all-the-CFLAGS.diff"
	local dir="vendor/cc"
	echo "Applying patch: $patch"
	patch -p1 -d "$dir" < "$patch"

	patch="$CLANDRO_PKG_BUILDER_DIR/trash-rs-implement-get_mount_points-android.diff"
	dir="vendor/trash"
	echo "Applying patch: $patch"
	patch -p1 -d "$dir" < "$patch"

	patch="$CLANDRO_PKG_BUILDER_DIR/wayland-cursor-no-shm.diff"
	dir="vendor/wayland-cursor"
	echo "Applying patch: $patch"
	patch -p1 -d "$dir" < "$patch"

	patch="$CLANDRO_PKG_BUILDER_DIR/smithay-client-toolkit-no-shm.diff"
	dir="vendor/smithay-client-toolkit"
	echo "Applying patch: $patch"
	patch -p1 -d "$dir" < "${patch}"

	find vendor/{trash,arboard,x11rb-protocol,xkbcommon-dl,winit,wayland-cursor,smithay-client-toolkit} -type f -print0 | \
		xargs -0 sed -i \
		-e 's|"android"|"disabling_this_because_it_is_for_building_an_apk"|g' \
		-e 's|"linux"|"android"|g' \
		-e "s|libxkbcommon.so.0|libxkbcommon.so|g" \
		-e "s|libxkbcommon-x11.so.0|libxkbcommon-x11.so|g" \
		-e "s|libxcb.so.1|libxcb.so|g" \
		-e "s|/tmp|$CLANDRO_PREFIX/tmp|g"

	echo "" >> Cargo.toml
	echo '[patch.crates-io]' >> Cargo.toml
	for crate in trash arboard cc winit x11rb-protocol xkbcommon-dl wayland-cursor smithay-client-toolkit; do
		echo "$crate = { path = \"./vendor/$crate\" }" >> Cargo.toml
	done

	# error: function-like macro '__GLIBC_USE' is not defined
	export BINDGEN_EXTRA_CLANG_ARGS="--sysroot ${CLANDRO_STANDALONE_TOOLCHAIN}/sysroot"
	case "${CLANDRO_ARCH}" in
	arm) BINDGEN_EXTRA_CLANG_ARGS+=" --target=arm-linux-androideabi" ;;
	*) BINDGEN_EXTRA_CLANG_ARGS+=" --target=${CLANDRO_ARCH}-linux-android" ;;
	esac
}

clandro_step_make() {
	if [[ "$CLANDRO_ARCH_BITS" == "64" ]]; then
		cargo build \
			--jobs "$CLANDRO_PKG_MAKE_PROCESSES" \
			--target "$CARGO_TARGET_NAME" \
			--release
	else
		# for some reason, this is required only for 32-bit Android targets to prevent
		# "error[E0422]: cannot find struct, variant or union type `JSValueUnion` in this scope"
		# issue has been reported, but for the other person, they were actually trying to build
		# for a 64-bit target, but their problem was that they were stuck building for 32-bit
		# and that's why they had that error
		# https://github.com/DelSkayn/rquickjs/issues/600
		cargo build \
			--jobs "$CLANDRO_PKG_MAKE_PROCESSES" \
			--target "$CARGO_TARGET_NAME" \
			--release \
			--package "$CLANDRO_PKG_NAME" \
			--no-default-features \
			--features runtime
	fi
}

clandro_step_make_install() {
	# based on AUR package https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=fresh-editor
	rm -rf "$CLANDRO_PREFIX/share/$CLANDRO_PKG_NAME"

	install -Dm755 "target/${CARGO_TARGET_NAME}/release/fresh" "$CLANDRO_PREFIX/share/$CLANDRO_PKG_NAME/fresh"
	install -dm755 "$CLANDRO_PREFIX/bin"
	ln -sf "$CLANDRO_PREFIX/share/$CLANDRO_PKG_NAME/fresh" "$CLANDRO_PREFIX/bin/fresh"

	install -Dm644 README.md "$CLANDRO_PREFIX/share/doc/$CLANDRO_PKG_NAME/README.md"

	if [[ "$CLANDRO_ARCH_BITS" == "64" ]]; then
		# Plugins
		cp -r crates/fresh-editor/plugins "$CLANDRO_PREFIX/share/$CLANDRO_PKG_NAME/"
	fi

	# Keymaps
	cp -r crates/fresh-editor/keymaps "$CLANDRO_PREFIX/share/$CLANDRO_PKG_NAME/"
}

clandro_step_post_make_install() {
	"$CLANDRO_ELF_CLEANER" --api-level "$CLANDRO_PKG_API_LEVEL" "$CLANDRO_PREFIX/share/$CLANDRO_PKG_NAME/fresh"
}
