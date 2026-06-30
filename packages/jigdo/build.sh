CLANDRO_PKG_HOMEPAGE=http://atterer.org/jigdo/
CLANDRO_PKG_DESCRIPTION="Distribute large images by sending and receiving the files that make them up"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.8.2"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://www.einval.com/~steve/software/jigdo/download/jigdo-$CLANDRO_PKG_VERSION.tar.xz
CLANDRO_PKG_SHA256=36f286d93fa6b6bf7885f4899c997894d21da3a62176592ac162d9c6a8644f9e
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libbz2, libc++, libdb, wget, zlib"
CLANDRO_PKG_BUILD_IN_SRC=true

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--mandir=$CLANDRO_PREFIX/share/man
--without-gui
"

clandro_step_pre_configure() {
	# Should prevent random failures on installation step.
	export CLANDRO_PKG_MAKE_PROCESSES=1
}
