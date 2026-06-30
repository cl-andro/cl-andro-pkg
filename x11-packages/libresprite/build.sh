CLANDRO_PKG_HOMEPAGE=https://libresprite.github.io/
CLANDRO_PKG_DESCRIPTION="Free and open source program for creating and animating sprites"
CLANDRO_PKG_LICENSE="GPL-2.0-only"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.2"
CLANDRO_PKG_SRCURL="https://github.com/LibreSprite/LibreSprite/releases/download/v$CLANDRO_PKG_VERSION/SOURCE.CODE.+.submodules.tar.gz"
CLANDRO_PKG_SHA256=38a2387694df9d5725244622d1c2e6cae8aced06b19c19cfbeab96afb13523c0
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_HOSTBUILD=true
# Unlike most SDL2 programs, it appears to actually work only with the real sdl2, not sdl2-compat
# error: "Failed loading SDL3 library.""
CLANDRO_PKG_DEPENDS="freetype, giflib, libarchive, libjpeg-turbo, libpixman, libpng, libtinyxml2, libwebp, libxi, sdl2, sdl2-image, xdg-utils, zlib"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_POLICY_VERSION_MINIMUM=3.5
-DWITH_WEBP_SUPPORT=ON
-DWITH_DESKTOP_INTEGRATION=ON
"

# The original "clandro_extract_src_archive" always strips the first components
# but the source of libresprite is directly under the root directory of the tar file
clandro_extract_src_archive() {
	local file="$CLANDRO_PKG_CACHEDIR/$(basename "$CLANDRO_PKG_SRCURL")"
	mkdir -p "$CLANDRO_PKG_SRCDIR"
	tar -xf "$file" -C "$CLANDRO_PKG_SRCDIR"
}

clandro_step_host_build() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "true" ]]; then
		return
	fi

	clandro_setup_cmake
	clandro_setup_ninja

	clandro_download_ubuntu_packages libtinyxml2-10 libtinyxml2-dev

	cmake "$CLANDRO_PKG_SRCDIR" \
		-GNinja \
		-DGEN_ONLY=ON \
		-DUSE_SDL2_BACKEND=OFF \
		-DCMAKE_PREFIX_PATH="$CLANDRO_PKG_HOSTBUILD_DIR/ubuntu_packages/usr" \
		-DCMAKE_POLICY_VERSION_MINIMUM=3.5
	ninja -j "$CLANDRO_PKG_MAKE_PROCESSES"
}

clandro_step_pre_configure() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		PATH="$CLANDRO_PKG_HOSTBUILD_DIR/bin:$PATH"
		local patch="$CLANDRO_PKG_BUILDER_DIR/cross-compilation-use-hostbuilt-gen.diff"
		echo "Applying patch: $patch"
		patch -p1 -d "$CLANDRO_PKG_SRCDIR" < "${patch}"
	fi
}
