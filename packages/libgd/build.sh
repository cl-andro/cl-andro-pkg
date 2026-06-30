CLANDRO_PKG_HOMEPAGE=https://libgd.github.io/
CLANDRO_PKG_DESCRIPTION="GD is an open source code library for the dynamic creation of images by programmers"
CLANDRO_PKG_LICENSE="custom"
CLANDRO_PKG_LICENSE_FILE="COPYING"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1:2.3.3"
CLANDRO_PKG_REVISION=7
CLANDRO_PKG_SRCURL="https://github.com/libgd/libgd/releases/download/gd-${CLANDRO_PKG_VERSION:2}/libgd-${CLANDRO_PKG_VERSION:2}.tar.gz"
CLANDRO_PKG_SHA256=dd3f1f0bb016edcc0b2d082e8229c822ad1d02223511997c80461481759b1ed2
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_METHOD=repology
CLANDRO_PKG_DEPENDS="fontconfig, freetype, libavif, libheif, libiconv, libjpeg-turbo, libpng, libtiff, libwebp, zlib"
CLANDRO_PKG_BREAKS="libgd-dev"
CLANDRO_PKG_REPLACES="libgd-dev"

# Disable vpx support for now, look at https://github.com/gagern/libgd/commit/d41eb72cd4545c394578332e5c102dee69e02ee8
# for enabling:
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--without-vpx --without-x"
