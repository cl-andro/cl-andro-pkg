CLANDRO_PKG_HOMEPAGE=https://sourceforge.net/projects/xournal/
CLANDRO_PKG_DESCRIPTION="Notetaking and sketching application"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.4.8.2016
CLANDRO_PKG_REVISION=38
CLANDRO_PKG_SRCURL=https://downloads.sourceforge.net/xournal/xournal-$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=b25898dbd7a149507f37a16769202d69fbebd4a000d766923bbd32c5c7462826
CLANDRO_PKG_DEPENDS="atk, desktop-file-utils, fontconfig, freetype, glib, gtk2, hicolor-icon-theme, libandroid-shmem, libart-lgpl, libcairo, libgnomecanvas, pango, poppler, libx11, shared-mime-info, zlib"
CLANDRO_PKG_RM_AFTER_INSTALL="lib/locale"

clandro_step_pre_configure() {
	CPPFLAGS+=" -D__USE_GNU"
	CXXFLAGS+=" -std=c++17"
	export LIBS="-Wl,--no-as-needed -landroid-shmem"
}
