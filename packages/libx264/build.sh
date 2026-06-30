CLANDRO_PKG_HOMEPAGE=https://www.videolan.org/developers/x264.html
CLANDRO_PKG_DESCRIPTION="Library for encoding video streams into the H.264/MPEG-4 AVC format"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
_COMMIT=4613ac3c15fd75cebc4b9f65b7fb95e70a3acce1
# X264_BUILD from x264.h; commit count using "git rev-list --count HEAD" on x264 git repo
CLANDRO_PKG_VERSION="1:0.164.3191"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://code.videolan.org/videolan/x264/-/archive/$_COMMIT/x264-$_COMMIT.tar.bz2
CLANDRO_PKG_SHA256=2a1b197fd1fbc85045794f18c9353648a9ae3cbe194b7b92d523d096f9445464
CLANDRO_PKG_BREAKS="libx264-dev"
CLANDRO_PKG_REPLACES="libx264-dev"
# Avoid linking against ffmpeg libraries to avoid circular dependency:
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-lavf
--disable-swscale
"

clandro_step_pre_configure() {
	if [ $CLANDRO_ARCH = "i686" ]; then
		# Avoid text relocations on i686, see:
		# https://mailman.videolan.org/pipermail/x264-devel/2016-March/011589.html
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" --disable-asm"
	elif [ $CLANDRO_ARCH = "x86_64" ]; then
		# Avoid requiring nasm for now:
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" --disable-asm"
	fi
}

clandro_step_post_make_install() {
	install -Dm644 ${CLANDRO_PKG_SRCDIR}/tools/bash-autocomplete.sh ${CLANDRO_PREFIX}/share/bash-completion/completions/x264
}
