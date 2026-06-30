CLANDRO_PKG_HOMEPAGE=https://wiki.gnome.org/Accessibility
CLANDRO_PKG_DESCRIPTION="Assistive Technology Service Provider Interface (AT-SPI)"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.60.3"
# https://download.gnome.org/sources/at-spi2-core/${CLANDRO_PKG_VERSION%.*}/at-spi2-core-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SRCURL=https://gitlab.gnome.org/GNOME/at-spi2-core/-/archive/${CLANDRO_PKG_VERSION}/at-spi2-core-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=1ce9adb87dd4a54f70119d9639a2398d9e60befc542be59b7fa6161946a97d05
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="dbus, glib, libx11, libxi, libxtst"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, libxml2"
CLANDRO_PKG_PROVIDES="at-spi2-atk, atk"
CLANDRO_PKG_REPLACES="at-spi2-atk (<< 2.46.0), atk (<< 2.46.0), libatk"
CLANDRO_PKG_BREAKS="at-spi2-atk (<< 2.46.0), atk (<< 2.46.0), libatk"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Ddbus_daemon=$CLANDRO_PREFIX/bin/dbus-daemon
-Dintrospection=enabled
-Dx11=enabled
"

clandro_step_pre_configure() {
	clandro_setup_gir
	clandro_setup_glib_cross_pkg_config_wrapper
	clandro_setup_python_pip

	export CLANDRO_MESON_ENABLE_SOVERSION=1
}

clandro_step_post_massage() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION_GUARD_FILES=(
		'lib/libatk-1.0.so.0'
		'lib/libatk-bridge-2.0.so.0'
		'lib/libatspi.so.0'
	)

	local f
	for f in "${_SOVERSION_GUARD_FILES[@]}"; do
		[ -e "${f}" ] || clandro_error_exit "SOVERSION guard check failed."
	done
}
