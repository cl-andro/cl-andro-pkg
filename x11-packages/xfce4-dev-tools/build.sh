CLANDRO_PKG_HOMEPAGE=https://gitlab.xfce.org/xfce/xfce4-dev-tools
CLANDRO_PKG_DESCRIPTION="A collection of tools and macros for Xfce developers"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.20.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://archive.xfce.org/src/xfce/xfce4-dev-tools/${CLANDRO_PKG_VERSION%.*}/xfce4-dev-tools-${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=1fba39a08a0ecc771eaa3a3b6e4272a4f0b9e7c67d0f66e780cd6090cd4466aa
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="glib"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_prog_MESON=meson
"
