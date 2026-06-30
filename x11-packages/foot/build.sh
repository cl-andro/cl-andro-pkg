CLANDRO_PKG_HOMEPAGE=https://codeberg.org/dnkl/foot
CLANDRO_PKG_DESCRIPTION="Fast, lightweight and minimalistic Wayland terminal emulator"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.26.1"
CLANDRO_PKG_SRCURL=https://codeberg.org/dnkl/foot/archive/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=2213a78b773c1f87bc503fcc2914d1f3474e9aaa2cb7fc92ec5dba4867ab71e0
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libandroid-support, fontconfig, freetype, libfcft, libpixman, libwayland, libxkbcommon, utf8proc"
CLANDRO_PKG_BUILD_DEPENDS="libtllist, libwayland-protocols, libwayland-cross-scanner, scdoc, xdg-utils"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Ddocs=enabled
-Dterminfo-base-name=foot-extra
-Dtests=false
"

clandro_step_pre_configure() {
	clandro_setup_wayland_cross_pkg_config_wrapper

	# libandroid-support provides this
	export CPPFLAGS+=" -D__STDC_ISO_10646__=201103L"

	cp "${CLANDRO_PKG_BUILDER_DIR}/reallocarray.c" "${CLANDRO_PKG_SRCDIR}"
}
