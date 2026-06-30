CLANDRO_PKG_HOMEPAGE=https://sourceforge.net/projects/pcmanfm/
CLANDRO_PKG_DESCRIPTION="Library for file management"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.3.2
CLANDRO_PKG_REVISION=6
CLANDRO_PKG_SRCURL=https://downloads.sourceforge.net/pcmanfm/libfm-$CLANDRO_PKG_VERSION.tar.xz
CLANDRO_PKG_SHA256=a5042630304cf8e5d8cff9d565c6bd546f228b48c960153ed366a34e87cad1e5
CLANDRO_PKG_DEPENDS="atk, glib, gtk3, libandroid-support, libcairo, libexif, libffi, menu-cache, pango, pcre"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--with-gtk=3"

CLANDRO_PKG_CONFLICTS="libfm-extra"
CLANDRO_PKG_REPLACES="libfm-extra"
CLANDRO_PKG_PROVIDES="libfm-extra (= $CLANDRO_PKG_VERSION)"
