CLANDRO_PKG_HOMEPAGE=https://cmus.github.io/
CLANDRO_PKG_DESCRIPTION="Small, fast and powerful console music player"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.12.0"
CLANDRO_PKG_REVISION=7
CLANDRO_PKG_DEPENDS="ffmpeg, libandroid-support, libflac, libiconv, libmad, libmodplug, libvorbis, libwavpack, ncurses, opusfile, pulseaudio, alsa-lib"
CLANDRO_PKG_SRCURL=https://github.com/cmus/cmus/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=44b96cd5f84b0d84c33097c48454232d5e6a19cd33b9b6503ba9c13b6686bfc7
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	# cherry-pick patches
	local sha commits=(
		8b96ab56184626d01a3a89ce1647b0488cf22391 # ensure the aaudio buffer is at least 80ms
	)
	for sha in "${commits[@]}"; do
		clandro_download "https://github.com/cmus/cmus/commit/${sha}.patch" "${CLANDRO_PKG_TMPDIR}/${sha}.patch" "SKIP_CHECKSUM" # skip checksum since we're already referencing an exact commit hash
		git apply "${CLANDRO_PKG_TMPDIR}/${sha}.patch"
	done

	# we need to be able to link against aaudio even on older api levels (it will fall back properly at runtime)
	if [[ $CLANDRO_PKG_API_LEVEL -lt 26 ]]; then
		local _libdir="$CLANDRO_PKG_TMPDIR/libaaudio"
		rm -rf "${_libdir}"
		mkdir -p "${_libdir}"
		cp "$CLANDRO_STANDALONE_TOOLCHAIN/sysroot/usr/lib/$CLANDRO_HOST_PLATFORM/26/libaaudio.so" "${_libdir}"
		LDFLAGS+=" -L${_libdir}"
	fi

	LD=$CC
	LDFLAGS+=" -lm"
	export CUE_LIBS=" -lm"
	export CONFIG_OSS=n
	export CONFIG_ALSA=y
}

clandro_step_configure() {
	./configure prefix=$CLANDRO_PREFIX
}

clandro_step_post_massage() {
	# it's weakly linked and we do funny stuff with it, so ensure it actually got linked properly
	if ! $READELF --needed-libs lib/cmus/op/aaudio.so | grep -E '^\s*libaaudio.so$' -q; then
		clandro_error_exit "DT_NEEDED for aaudio is not correctly set"
	fi
}
