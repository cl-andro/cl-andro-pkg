CLANDRO_PKG_HOMEPAGE=https://libvips.github.io/libvips/
CLANDRO_PKG_DESCRIPTION="A fast image processing library with low memory needs"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="8.18.2"
CLANDRO_PKG_SRCURL="https://github.com/libvips/libvips/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=c6e9f3c384436c6ffc75848d1ad76347368b9639897f6d9f909178dc986d5200
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="cgif, fftw, fontconfig, glib, imagemagick, imath, libc++, libcairo, libexif, libexpat, libheif, libimagequant, libjpeg-turbo, libjxl, libpng, librsvg, libtiff, libwebp, littlecms, openexr, openjpeg, pango, poppler, zlib"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, glib-cross, valac"
CLANDRO_PKG_DISABLE_GIR=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dintrospection=enabled
-Dvapi=true
-Dorc=disabled
"

clandro_step_pre_configure() {
	clandro_setup_gir
	clandro_setup_glib_cross_pkg_config_wrapper

	export CLANDRO_MESON_ENABLE_SOVERSION=1
}

clandro_step_post_massage() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=42
	if [ ! -e "lib/libvips.so.${_SOVERSION}" ]; then
		echo "ERROR: Expected: lib/libvips.so.${_SOVERSION}" 1>&2
		echo "ERROR: Found   : $(find lib/libvips* -regex '.*so\.[0-9]+')" 1>&2
		clandro_error_exit "Not proceeding with update."
	fi
}
