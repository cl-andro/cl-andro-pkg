# X11 package
CLANDRO_PKG_HOMEPAGE=https://xorg.freedesktop.org/
CLANDRO_PKG_DESCRIPTION="X11 toolkit intrinsics library"
CLANDRO_PKG_LICENSE="MIT, HPND"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.3.1"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/lib/libXt-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=e0a774b33324f4d4c05b199ea45050f87206586d81655f8bef4dba434d931288
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libice, libsm, libx11"
CLANDRO_PKG_BUILD_DEPENDS="xorg-util-macros"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_path_RAWCPP=/usr/bin/cpp
--enable-malloc0returnsnull
"

clandro_step_pre_configure() {
	export CFLAGS_FOR_BUILD=" "
	export LDFLAGS_FOR_BUILD=" "
}
