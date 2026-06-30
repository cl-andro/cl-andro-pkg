CLANDRO_PKG_HOMEPAGE=https://gtkwave.github.io/gtkwave/
CLANDRO_PKG_DESCRIPTION="A wave viewer which reads LXT, LXT2, VZT, GHW and VCD/EVCD files"
CLANDRO_PKG_LICENSE="GPL-2.0, MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1:3.3.116"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://github.com/gtkwave/gtkwave/archive/refs/tags/v${CLANDRO_PKG_VERSION:2}.tar.gz
CLANDRO_PKG_SHA256=b178398da32f8e1958db74057fec278fe0fcc3400485f20ded3ab2330c58f598
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE='newest-tag'
CLANDRO_PKG_UPDATE_VERSION_REGEXP='\d+\.\d+\.\d+'
CLANDRO_PKG_DEPENDS="gdk-pixbuf, glib, gtk3, libandroid-shmem, libbz2, libc++, liblzma, pango, zlib"
CLANDRO_PKG_RECOMMENDS="desktop-file-utils"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--disable-tcl --disable-mime-update --enable-gtk3"

clandro_step_post_get_source() {
	rm -rf "$CLANDRO_PKG_SRCDIR/gtkwave3"
	mv "$CLANDRO_PKG_SRCDIR/gtkwave3-gtk3" "$CLANDRO_PKG_TMPDIR/gtkwave3-gtk3"
	mv "$CLANDRO_PKG_TMPDIR/gtkwave3-gtk3"/* "$CLANDRO_PKG_SRCDIR"
	rm -rf "$CLANDRO_PKG_TMPDIR/gtkwave3-gtk3"
}
