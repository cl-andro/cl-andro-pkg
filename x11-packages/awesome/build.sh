CLANDRO_PKG_HOMEPAGE=https://github.com/awesomeWM/awesome
CLANDRO_PKG_DESCRIPTION="A highly configurable, next generation framework window manager for X"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
# Latest release version 4.3 does not support Lua 5.4.
_COMMIT=fa805ab465821c54094126b71a92acf2eba17674
CLANDRO_PKG_VERSION="2026.03.31"
CLANDRO_PKG_SRCURL=git+https://github.com/awesomeWM/awesome
CLANDRO_PKG_SHA256=ed61955ed9bdf1d216b881543572c32c83a15f419d9410d5c6b4ed3df3392383
CLANDRO_PKG_GIT_BRANCH=master
CLANDRO_PKG_DEPENDS="dbus, gdk-pixbuf, glib, libcairo, lua54, libx11, libxcb, libxdg-basedir, libxkbcommon, lua-lgi, pango, startup-notification, xcb-util, xcb-util-cursor, xcb-util-keysyms, xcb-util-wm, xcb-util-xrm"
CLANDRO_PKG_BUILD_DEPENDS="imagemagick"
CLANDRO_PKG_BREAKS="awesome-luajit"
CLANDRO_PKG_CONFLICTS="awesome-luajit"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DLUA_MATH_LIBRARY=
-DCMAKE_POLICY_VERSION_MINIMUM=3.5
-DLUA_INCLUDE_DIR=$CLANDRO_PREFIX/include/lua5.4
-DLUA_LIBRARY=$CLANDRO_PREFIX/lib/liblua5.4.so
"
CLANDRO_PKG_HOSTBUILD=true

clandro_step_post_get_source() {
	git fetch --unshallow
	git checkout $_COMMIT

	local version="$(git log -1 --format=%cs | sed 's/-/./g')"
	if [ "$version" != "$CLANDRO_PKG_VERSION" ]; then
		echo -n "ERROR: The specified version \"$CLANDRO_PKG_VERSION\""
		echo " is different from what is expected to be: \"$version\""
		return 1
	fi

	local s=$(find . -type f ! -path '*/.git/*' -print0 | xargs -0 sha256sum | LC_ALL=C sort | sha256sum)
	if [[ "${s}" != "${CLANDRO_PKG_SHA256}  "* ]]; then
		clandro_error_exit "Checksum mismatch for source files."
	fi

	find "$CLANDRO_PKG_SRCDIR" -type f -print0 | \
		xargs -0 sed -i \
		-e "s|/usr/bin/env lua|/usr/bin/env lua5.4|g" \
		-e "s|/usr/bin/lua|/usr/bin/lua5.4|g"
}

_load_ubuntu_packages() {
	local hostbuild_lua_version="5.4"
	export HOSTBUILD_ROOTFS="${CLANDRO_PKG_HOSTBUILD_DIR}/ubuntu_packages"
	export LD_LIBRARY_PATH="${HOSTBUILD_ROOTFS}/usr/lib/x86_64-linux-gnu"
	LD_LIBRARY_PATH+=":${HOSTBUILD_ROOTFS}/usr/lib"
	export LUA_PATH="${HOSTBUILD_ROOTFS}/usr/share/lua/$hostbuild_lua_version/?.lua;${CLANDRO_PKG_SRCDIR}/?.lua"
	export LUA_CPATH="${HOSTBUILD_ROOTFS}/usr/lib/x86_64-linux-gnu/lua/$hostbuild_lua_version/?.so"
	export PATH="${HOSTBUILD_ROOTFS}/usr/bin:$PATH"
	local hostbuild_imagemagick_version="$(convert --version | head -n1 | cut -d' ' -f3 | cut -d'-' -f1)"
	export MAGICK_CODER_MODULE_PATH="${HOSTBUILD_ROOTFS}/usr/lib/x86_64-linux-gnu/ImageMagick-$hostbuild_imagemagick_version/modules-Q16/coders"
}

clandro_step_host_build() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "true" ]]; then
		return
	fi

	local hostbuild_lua_version="5.4"

	local -a ubuntu_packages=(
		"imagemagick"
		"imagemagick-6-common"
		"imagemagick-6.q16"
		"libaom3"
		"libde265-0"
		"libdjvulibre-text"
		"libdjvulibre21"
		"libfftw3-double3"
		"libheif-plugin-aomdec"
		"libheif-plugin-aomenc"
		"libheif-plugin-libde265"
		"libheif1"
		"libjxr-tools"
		"libjxr0t64"
		"liblqr-1-0"
		"liblua$hostbuild_lua_version-0"
		"liblua$hostbuild_lua_version-dev"
		"libmagickcore-6.q16-7-extra"
		"libmagickcore-6.q16-7t64"
		"libmagickwand-6.q16-7t64"
		"libstartup-notification0"
		"libstartup-notification0-dev"
		"libwmflite-0.2-7"
		"libx11-xcb-dev"
		"libxcb-cursor-dev"
		"libxcb-cursor0"
		"libxcb-icccm4"
		"libxcb-icccm4-dev"
		"libxcb-image0"
		"libxcb-image0-dev"
		"libxcb-keysyms1"
		"libxcb-keysyms1-dev"
		"libxcb-randr0-dev"
		"libxcb-render-util0"
		"libxcb-render-util0-dev"
		"libxcb-shape0"
		"libxcb-shape0"
		"libxcb-shape0-dev"
		"libxcb-shape0-dev"
		"libxcb-util-dev"
		"libxcb-util0-dev"
		"libxcb-util1"
		"libxcb-xfixes0-dev"
		"libxcb-xinerama0"
		"libxcb-xinerama0-dev"
		"libxcb-xkb-dev"
		"libxcb-xkb1"
		"libxcb-xrm-dev"
		"libxcb-xrm0"
		"libxcb-xtest0"
		"libxcb-xtest0-dev"
		"libxdg-basedir-dev"
		"libxdg-basedir1"
		"libxkbcommon-x11-0"
		"libxkbcommon-x11-dev"
		"lua-any"
		"lua-expat"
		"lua-filesystem"
		"lua-ldoc"
		"lua-penlight"
	)

	clandro_download_ubuntu_packages "${ubuntu_packages[@]}"

	local HOSTBUILD_ROOTFS="${CLANDRO_PKG_HOSTBUILD_DIR}/ubuntu_packages"

	find "${HOSTBUILD_ROOTFS}" -type f -name '*.pc' | \
		xargs -n 1 sed -i -e "s|/usr|${HOSTBUILD_ROOTFS}/usr|g"
	find "${HOSTBUILD_ROOTFS}/usr/lib/x86_64-linux-gnu" -xtype l \
		-exec sh -c "ln -snvf /usr/lib/x86_64-linux-gnu/\$(readlink \$1) \$1" sh {} \;
	ln -sf convert-im6.q16 "${HOSTBUILD_ROOTFS}/usr/bin/convert"
	ln -sf $(command -v "lua$hostbuild_lua_version") "${HOSTBUILD_ROOTFS}/usr/bin/lua-any"

	_load_ubuntu_packages

	clandro_setup_cmake
	clandro_setup_ninja
	# XXX: clandro_setup_meson is not expected to be called in host build
	AR=;CC=;CFLAGS=;CPPFLAGS=;CXX=;CXXFLAGS=;LD=;LDFLAGS=;PKG_CONFIG=;STRIP=
	clandro_setup_meson
	unset AR CC CFLAGS CPPFLAGS CXX CXXFLAGS LD LDFLAGS PKG_CONFIG STRIP

	export PKG_CONFIG_PATH="${HOSTBUILD_ROOTFS}/usr/lib/x86_64-linux-gnu/pkgconfig"
	export CFLAGS="-I${HOSTBUILD_ROOTFS}/usr/include/x86_64-linux-gnu"
	CFLAGS+=" -I/usr/include/xcb"

	LUA_LGI="$CLANDRO_PKG_HOSTBUILD_DIR/lua-lgi"
	(. "$CLANDRO_SCRIPTDIR/packages/lua-lgi/build.sh"; CLANDRO_PKG_SRCDIR="$LUA_LGI" clandro_step_get_source)
	$CLANDRO_MESON setup \
		"$LUA_LGI" \
		"$LUA_LGI/build" \
		--prefix "$HOSTBUILD_ROOTFS/usr" \
		-Dlua-pc=lua"${hostbuild_lua_version//./}" \
		-Dlua-bin=lua"${hostbuild_lua_version}"
	$CLANDRO_MESON compile -C "$LUA_LGI/build"
	$CLANDRO_MESON install -C "$LUA_LGI/build"

	cmake \
		-G Ninja \
		-S "${CLANDRO_PKG_SRCDIR}" \
		-DCMAKE_POLICY_VERSION_MINIMUM=3.5 \
		-DCMAKE_PREFIX_PATH="${HOSTBUILD_ROOTFS}/usr" \
		-DCMAKE_INSTALL_PREFIX="${HOSTBUILD_ROOTFS}/usr" \
		-DLUA_INCLUDE_DIR="${HOSTBUILD_ROOTFS}/usr/include/lua$hostbuild_lua_version" \
		-DLUA_LIBRARY="/usr/lib/x86_64-linux-gnu/liblua$hostbuild_lua_version.so.0" \
		-DLUA_EXECUTABLE=$(command -v "lua$hostbuild_lua_version")
	ninja \
		-j "${CLANDRO_PKG_MAKE_PROCESSES}" \
		install
	unset PKG_CONFIG_PATH CFLAGS
}

clandro_step_pre_configure() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		_load_ubuntu_packages
		export PATH="$CLANDRO_PKG_HOSTBUILD_DIR:$PATH"
	fi

	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DLUA_EXECUTABLE=$(command -v lua5.4)"
}
