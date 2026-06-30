CLANDRO_PKG_HOMEPAGE=https://gpac.wp.imt.fr/
CLANDRO_PKG_DESCRIPTION="An open-source multimedia framework focused on modularity and standards compliance"
CLANDRO_PKG_LICENSE="LGPL-2.1-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.4.0"
CLANDRO_PKG_REVISION=5
CLANDRO_PKG_SRCURL=https://github.com/gpac/gpac/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=99c8c994d5364b963d18eff24af2576b38d38b3460df27d451248982ea16157a
CLANDRO_PKG_DEPENDS="ffmpeg, freetype, liba52, libjpeg-turbo, liblzma, libmad, libnghttp2, libogg, libpng, libtheora, libvorbis, openjpeg, openssl, pulseaudio, xvidcore, zlib"
CLANDRO_PKG_EXTRA_MAKE_ARGS="STRIP=:"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--disable-x11"

clandro_step_pre_configure() {
	declare -a _commits=(
	18863aa2
	)

	declare -a _checksums=(
	3a4e10a031bc081a402bfd24889f85fcbf99d4fd36a9086aedda546445037bec
	)

	for i in "${!_commits[@]}"; do
		PATCHFILE="${CLANDRO_PKG_CACHEDIR}/gpac_patch_${_commits[i]}.patch"
		clandro_download \
			"https://github.com/gpac/gpac/commit/${_commits[i]}.patch" \
			"$PATCHFILE" \
			"${_checksums[i]}"
		patch -p1 -i "$PATCHFILE"
	done

	CFLAGS+=" -fPIC"
	for f in $CFLAGS $CPPFLAGS; do
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" --extra-cflags=$f"
	done
	for f in $LDFLAGS; do
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" --extra-ldflags=$f"
	done
}
