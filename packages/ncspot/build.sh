CLANDRO_PKG_HOMEPAGE=https://github.com/hrkfdn/ncspot
CLANDRO_PKG_DESCRIPTION="An ncurses Spotify client written in Rust"
CLANDRO_PKG_LICENSE="BSD 2-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.3.3"
CLANDRO_PKG_SRCURL=https://github.com/hrkfdn/ncspot/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=26edf6f1861828452355d614349c0a2af49113b392d7cd52290ea7f180f6bfe5
CLANDRO_PKG_DEPENDS="dbus, pulseaudio"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_CONFLICTS="ncspot-mpris"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--no-default-features
--features termion_backend,pulseaudio_backend
"
# NOTE: ncurses-rs runs a test while building which fails while cross compiling:
# therefore, we use termion_backend instead.
# share_clipboard cannot be used due to 1Password/arboard#56.

clandro_step_pre_configure() {
	clandro_setup_cmake
	clandro_setup_ninja
	clandro_setup_rust

	# bindgen-cli@0.71.0 is broken
	cargo install --force --locked bindgen-cli@0.69.5

	# TODO: Remove this after aws-lc-sys > 0.26.0 update in Crago.toml
	export CMAKE_POLICY_VERSION_MINIMUM=3.5

	export TARGET_CMAKE_GENERATOR="Ninja"

	# Setup subsequent cmake running inside cargo
	# Crate used to invoke cmake does not work fine with cross-compilation so we wrap cmake
	_CMAKE="$CLANDRO_PKG_TMPDIR/bin/cmake"
	mkdir -p "$(dirname "$_CMAKE")"

	echo "#!$(readlink /proc/$$/exe)" > "$_CMAKE"
	echo "echo CMAKE \"\$@\"" >> "$_CMAKE"
	echo "[[ \"\$@\" =~ \"--build\" ]] && exec $(command -v cmake) \"\$@\" || \
	exec $(command -v cmake) \
	-DCMAKE_ANDROID_STANDALONE_TOOLCHAIN=\"$CLANDRO_STANDALONE_TOOLCHAIN\" \
	-DCMAKE_SYSTEM_NAME=Android \
	-DCMAKE_SYSTEM_VERSION=$CLANDRO_PKG_API_LEVEL \
	-DCMAKE_LINKER=\"$CLANDRO_STANDALONE_TOOLCHAIN/bin/$LD\" \
	-DCMAKE_MAKE_PROGRAM=\"$(command -v ninja)\" \"\$@\"" >> "$_CMAKE"
	chmod +x "$_CMAKE"

	export PATH="$(dirname "$_CMAKE"):$PATH"
	CXXFLAGS+=" --target=$CCTERMUX_HOST_PLATFORM"
	CFLAGS+=" --target=$CCTERMUX_HOST_PLATFORM"
	LDFLAGS+=" --target=$CCTERMUX_HOST_PLATFORM"
}
