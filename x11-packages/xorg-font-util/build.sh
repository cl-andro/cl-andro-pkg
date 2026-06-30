CLANDRO_PKG_HOMEPAGE=https://xorg.freedesktop.org/
CLANDRO_PKG_DESCRIPTION="X.Org font utilities"
# Licenses: MIT, BSD 2-Clause, UCD
CLANDRO_PKG_LICENSE="custom"
CLANDRO_PKG_LICENSE_FILE="COPYING"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.4.2"
CLANDRO_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/font/font-util-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=02e4f8afdcf03cc8372ca9c37aa104b1e36b47722dbc79531be08f0a4c622999
CLANDRO_PKG_AUTO_UPDATE=true

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--with-mapdir=${CLANDRO_PREFIX}/share/fonts/util
--with-fontrootdir=${CLANDRO_PREFIX}/share/fonts
"
