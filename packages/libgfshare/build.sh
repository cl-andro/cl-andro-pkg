CLANDRO_PKG_HOMEPAGE=https://www.digital-scurf.org/software/libgfshare
CLANDRO_PKG_DESCRIPTION="Utilities for multi-way secret-sharing"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.0.0
CLANDRO_PKG_REVISION=8
CLANDRO_PKG_SRCURL=https://www.digital-scurf.org/files/libgfshare/libgfshare-$CLANDRO_PKG_VERSION.tar.bz2
CLANDRO_PKG_SHA256=86f602860133c828356b7cf7b8c319ba9b27adf70a624fe32275ba1ed268331f
CLANDRO_PKG_BREAKS="libgfshare-dev"
CLANDRO_PKG_REPLACES="libgfshare-dev"

clandro_step_post_configure() {
	gcc -DHAVE_CONFIG_H \
		-I. \
		-I"$CLANDRO_PKG_SRCDIR" \
		-I"$CLANDRO_PKG_SRCDIR"/include \
		"$CLANDRO_PKG_SRCDIR"/src/gfshare_maketable.c \
		-o gfshare_maketable
	touch -d "next hour" gfshare_maketable
}
