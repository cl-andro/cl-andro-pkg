CLANDRO_PKG_HOMEPAGE=https://xorg.freedesktop.org/
CLANDRO_PKG_DESCRIPTION="A library that exposes a event API on top of Linux futexes"
CLANDRO_PKG_LICENSE="HPND"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.3.3"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/lib/libxshmfence-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=d4a4df096aba96fea02c029ee3a44e11a47eb7f7213c1a729be83e85ec3fde10
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_DEPENDS="xorgproto, xorg-util-macros"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-futex
--disable-static
"
