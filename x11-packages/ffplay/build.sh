CLANDRO_PKG_HOMEPAGE=https://ffmpeg.org
CLANDRO_PKG_DESCRIPTION="FFplay media player"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
# Please align the version with `ffmpeg` package.
CLANDRO_PKG_VERSION="8.1.1"
CLANDRO_PKG_SRCURL=https://www.ffmpeg.org/releases/ffmpeg-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=b6863adde98898f42602017462871b5f6333e65aec803fdd7a6308639c52edf3
CLANDRO_PKG_DEPENDS="ffmpeg, libandroid-shmem, libx11, libxcb, libxext, libxv, pulseaudio, sdl2 | sdl2-compat"
CLANDRO_PKG_ANTI_BUILD_DEPENDS="sdl2-compat"

clandro_step_pre_configure() {
	_FFPLAY_PREFIX="$CLANDRO_PREFIX/opt/$CLANDRO_PKG_NAME"
	LDFLAGS="-Wl,-rpath=${_FFPLAY_PREFIX}/lib $LDFLAGS -landroid-shmem"
}

clandro_step_configure() {
	local _ARCH
	case "$CLANDRO_ARCH" in
		"arm") _ARCH=armeabi-v7a ;;
		"i686") _ARCH=x86 ;;
		*) _ARCH="$CLANDRO_ARCH" ;;
	esac

	"$CLANDRO_PKG_SRCDIR/configure" \
		--prefix="${_FFPLAY_PREFIX}" \
		--cc="$CC" \
		--pkg-config="$PKG_CONFIG" \
		--arch="${_ARCH}" \
		--cross-prefix=llvm- \
		--enable-cross-compile \
		--target-os=android \
		--disable-version3 \
		--disable-static \
		--enable-shared \
		--disable-autodetect \
		--disable-doc \
		--disable-asm \
		--enable-libpulse \
		--enable-libxcb \
		--enable-libxcb-shm \
		--enable-libxcb-xfixes \
		--enable-libxcb-shape \
		--enable-sdl \
		--enable-xlib \
		--enable-ffplay
}

clandro_step_post_make_install() {
	mkdir -p "$CLANDRO_PREFIX/bin"
	ln -sfr "${_FFPLAY_PREFIX}/bin/ffplay" "$CLANDRO_PREFIX/bin/"
}

clandro_step_post_massage() {
	cd "$CLANDRO_PKG_MASSAGEDIR/${_FFPLAY_PREFIX}" || exit 1
	find . ! -type d \
		! -wholename "./bin/ffplay" \
		! -wholename "./lib/libavdevice.so*" \
		-exec rm -f '{}' \;
	find . -type d -empty -delete
}
