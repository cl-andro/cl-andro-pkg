CLANDRO_PKG_HOMEPAGE=https://sw.kovidgoyal.net/kitty/
CLANDRO_PKG_DESCRIPTION="Cross-platform, fast, feature-rich, GPU based terminal"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.46.2"
CLANDRO_PKG_SRCURL="https://github.com/kovidgoyal/kitty/releases/download/v${CLANDRO_PKG_VERSION}/kitty-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=e8ea44b13a1c70032a35128a8c4c8c29c90a7cfbe0ad4f6aa2927a057d10f83e
# fontconfig is dlopen(3)ed:
CLANDRO_PKG_DEPENDS="dbus, fontconfig, harfbuzz, libpng, librsync, libx11, libxkbcommon, littlecms, ncurses, opengl, openssl, python, xxhash, zlib"
CLANDRO_PKG_BUILD_DEPENDS="libxcursor, libxi, libxinerama, libxrandr, simde, xorgproto"
CLANDRO_PKG_PYTHON_COMMON_BUILD_DEPS="wheel"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_RM_AFTER_INSTALL="
share/doc/kitty/html
share/terminfo/x/xterm-kitty
"
CLANDRO_PKG_AUTO_UPDATE=true

# shellcheck disable=SC2164
clandro_step_host_build() {
	if [[ "${CLANDRO_ON_DEVICE_BUILD}" == "true" ]]; then return; fi

	# https://github.com/kovidgoyal/kitty/issues/6354

	clandro_setup_golang
	clandro_setup_ninja

	# XXX: clandro_setup_meson is not expected to be called in host build
	AR=;CC=;CFLAGS=;CPPFLAGS=;CXX=;CXXFLAGS=;LD=;LDFLAGS=;PKG_CONFIG=;STRIP=
	clandro_setup_meson
	unset AR CC CFLAGS CPPFLAGS CXX CXXFLAGS LD LDFLAGS PKG_CONFIG STRIP

	local -A ver=(
		[libx11]="$(. "${CLANDRO_SCRIPTDIR}/packages/libx11/build.sh"; echo "${CLANDRO_PKG_VERSION}")"
		[libxcb]="$(. "${CLANDRO_SCRIPTDIR}/packages/libxcb/build.sh"; echo "${CLANDRO_PKG_VERSION}")"
		[xcb_proto]="$(. "${CLANDRO_SCRIPTDIR}/packages/xcb-proto/build.sh"; echo "${CLANDRO_PKG_VERSION}")"
		[libxkbcommon]="$(. "${CLANDRO_SCRIPTDIR}/x11-packages/libxkbcommon/build.sh"; echo "${CLANDRO_PKG_VERSION}")"
	)
	local -A srcurl=(
		[libx11]="$(. "${CLANDRO_SCRIPTDIR}/packages/libx11/build.sh"; echo "${CLANDRO_PKG_SRCURL}")"
		[libxcb]="$(. "${CLANDRO_SCRIPTDIR}/packages/libxcb/build.sh"; echo "${CLANDRO_PKG_SRCURL}")"
		[xcb_proto]="$(. "${CLANDRO_SCRIPTDIR}/packages/xcb-proto/build.sh"; echo "${CLANDRO_PKG_SRCURL}")"
		[libxkbcommon]="$(. "${CLANDRO_SCRIPTDIR}/x11-packages/libxkbcommon/build.sh"; echo "${CLANDRO_PKG_SRCURL}")"
	)
	local -A sha256=(
		[libx11]="$(. "${CLANDRO_SCRIPTDIR}/packages/libx11/build.sh"; echo "${CLANDRO_PKG_SHA256}")"
		[libxcb]="$(. "${CLANDRO_SCRIPTDIR}/packages/libxcb/build.sh"; echo "${CLANDRO_PKG_SHA256}")"
		[xcb_proto]="$(. "${CLANDRO_SCRIPTDIR}/packages/xcb-proto/build.sh"; echo "${CLANDRO_PKG_SHA256}")"
		[libxkbcommon]="$(. "${CLANDRO_SCRIPTDIR}/x11-packages/libxkbcommon/build.sh"; echo "${CLANDRO_PKG_SHA256}")"
	)

	clandro_download "${srcurl[libx11]}" "${CLANDRO_PKG_CACHEDIR}/$(basename "${srcurl[libx11]}")" "${sha256[libx11]}"
	clandro_download "${srcurl[libxcb]}" "${CLANDRO_PKG_CACHEDIR}/$(basename "${srcurl[libxcb]}")" "${sha256[libxcb]}"
	clandro_download "${srcurl[xcb_proto]}" "${CLANDRO_PKG_CACHEDIR}/$(basename "${srcurl[xcb_proto]}")" "${sha256[xcb_proto]}"
	clandro_download "${srcurl[libxkbcommon]}" "${CLANDRO_PKG_CACHEDIR}/$(basename "${srcurl[libxkbcommon]}")" "${sha256[libxkbcommon]}"

	tar -xf "${CLANDRO_PKG_CACHEDIR}/$(basename "${srcurl[libx11]}")"
	tar -xf "${CLANDRO_PKG_CACHEDIR}/$(basename "${srcurl[libxcb]}")"
	tar -xf "${CLANDRO_PKG_CACHEDIR}/$(basename "${srcurl[xcb_proto]}")"
	tar -xf "${CLANDRO_PKG_CACHEDIR}/$(basename "${srcurl[libxkbcommon]}")"

	export PKG_CONFIG_PATH="${CLANDRO_PKG_HOSTBUILD_DIR}/lib/pkgconfig"
	PKG_CONFIG_PATH+=":${CLANDRO_PKG_HOSTBUILD_DIR}/share/pkgconfig"
	PKG_CONFIG_PATH+=":${CLANDRO_PKG_HOSTBUILD_DIR}/lib/x86_64-linux-gnu/pkgconfig"

	pushd "xcb-proto-${ver[xcb_proto]}" || clandro_error_exit "Failed to hostbuild 'xcb_proto'"
	./configure --prefix "${CLANDRO_PKG_HOSTBUILD_DIR}"
	make -j "${CLANDRO_PKG_MAKE_PROCESSES}" install
	popd
	pushd "libxcb-${ver[libxcb]}" || clandro_error_exit "Failed to hostbuild 'libxcb'"
	./configure --prefix "${CLANDRO_PKG_HOSTBUILD_DIR}"
	make -j "${CLANDRO_PKG_MAKE_PROCESSES}" install
	popd
	pushd "libxkbcommon-xkbcommon-${ver[libxkbcommon]}" || clandro_error_exit "Failed to hostbuild 'libxkbcommon'"
	${CLANDRO_MESON} setup \
		"${CLANDRO_PKG_HOSTBUILD_DIR}/build-xkbcommon" . \
		--prefix "${CLANDRO_PKG_HOSTBUILD_DIR}" \
		-Denable-bash-completion=false \
		-Denable-wayland=false \
		-Denable-docs=false
	ninja \
		-C "${CLANDRO_PKG_HOSTBUILD_DIR}/build-xkbcommon" \
		-j "${CLANDRO_PKG_MAKE_PROCESSES}" install
	popd
	pushd "libX11-${ver[libx11]}" || clandro_error_exit "Failed to hostbuild 'libx11'"
	./configure --prefix "${CLANDRO_PKG_HOSTBUILD_DIR}"
	make -j "${CLANDRO_PKG_MAKE_PROCESSES}" install
	popd

	pushd "${CLANDRO_PKG_SRCDIR}" || clandro_error_exit "Failed to run './dev.sh build'"
	echo "./dev.sh build" && ./dev.sh build
	python3 setup.py clean --clean-for-cross-compile --verbose
	popd
}

clandro_step_pre_configure() {
	mkdir -p "$CLANDRO_PKG_SRCDIR"/fonts
	clandro_download \
		"https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/NerdFontsSymbolsOnly/SymbolsNerdFontMono-Regular.ttf" \
		"$CLANDRO_PKG_SRCDIR/fonts/SymbolsNerdFontMono-Regular.ttf" \
		SKIP_CHECKSUM

	clandro_setup_golang
	CFLAGS+=" $CPPFLAGS"

	sed 's|@CLANDRO_PREFIX@|'"${CLANDRO_PREFIX}"'|g' \
		"${CLANDRO_PKG_BUILDER_DIR}/posix-shm.c.in" > kitty/posix-shm.c
	cp "${CLANDRO_PKG_BUILDER_DIR}/reallocarray.c" glfw/
}

clandro_step_make() {
	if [[ "${CLANDRO_ON_DEVICE_BUILD}" == "true" ]]; then
		python3 setup.py linux-package \
			--ignore-compiler-warnings \
			--verbose
		return
	fi

	python3 setup.py linux-package \
		--ignore-compiler-warnings \
		--skip-code-generation \
		--verbose

	# Needs a new host build each time it's built:
	rm -Rf "$CLANDRO_PKG_HOSTBUILD_DIR"
}

clandro_step_make_install() {
	cp -rT linux-package "$CLANDRO_PREFIX"
}
