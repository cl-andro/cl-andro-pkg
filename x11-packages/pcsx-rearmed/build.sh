CLANDRO_PKG_HOMEPAGE=https://github.com/notaz/pcsx_rearmed
CLANDRO_PKG_DESCRIPTION="Yet another PCSX fork based on the PCSX-Reloaded project"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="26"
CLANDRO_PKG_SRCURL=git+https://github.com/notaz/pcsx_rearmed
CLANDRO_PKG_GIT_BRANCH=r${CLANDRO_PKG_VERSION}
CLANDRO_PKG_SHA256=887e9b5ee7b8115d35099c730372b4158fd3e215955a06d68e20928b339646af
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libpng, opengl, pulseaudio, sdl, zlib"
CLANDRO_PKG_BUILD_DEPENDS="binutils-cross"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_pkg_auto_update() {
	# Get latest release tag:
	local tag="$(clandro_github_api_get_tag "${CLANDRO_PKG_SRCURL}")"
	if grep -qP "^r\d+\$" <<<"$tag"; then
		clandro_pkg_upgrade_version "$tag"
	else
		echo "WARNING: Skipping auto-update: Not a release ($tag)"
	fi
}

clandro_step_post_get_source() {
	# convert CRLF to LF globally while working with this package in termux
	# https://github.com/termux/termux-packages/issues/11744
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		DOS2UNIX="$CLANDRO_PKG_TMPDIR/dos2unix"
		(. "$CLANDRO_SCRIPTDIR/packages/dos2unix/build.sh"; CLANDRO_PKG_SRCDIR="$DOS2UNIX" clandro_step_get_source)
		pushd "$DOS2UNIX"
		make dos2unix
		popd # DOS2UNIX
		export PATH="$DOS2UNIX:$PATH"
	fi

	find "$CLANDRO_PKG_SRCDIR" -type f -print0 | xargs -0 dos2unix
}

clandro_step_pre_configure() {
	CFLAGS+=" $CPPFLAGS"
	CFLAGS="${CFLAGS/-Oz/-Os}"
	if [ "$CLANDRO_ARCH" = "arm" ]; then
		clandro_setup_no_integrated_as
	fi
	export SDL_CONFIG="$CLANDRO_PREFIX/bin/sdl-config"
}

clandro_step_configure() {
	sh ./configure
}

clandro_step_make_install() {
	install -Dm755 pcsx $CLANDRO_PREFIX/bin/pcsx
	mkdir -p $CLANDRO_PREFIX/etc/pcsx $CLANDRO_PREFIX/lib/pcsx_plugins
	cp -fr frontend/pandora/skin $CLANDRO_PREFIX/etc/pcsx/
	install -m755 plugins/*.so $CLANDRO_PREFIX/lib/pcsx_plugins/
	ln -fs ../../lib/pcsx_plugins $CLANDRO_PREFIX/etc/pcsx/plugins
}
