CLANDRO_PKG_HOMEPAGE="https://apps.gnome.org/Clocks/"
CLANDRO_PKG_DESCRIPTION="Keep track of time"
CLANDRO_PKG_LICENSE="GPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="50.0"
CLANDRO_PKG_SRCURL=https://download.gnome.org/sources/gnome-clocks/${CLANDRO_PKG_VERSION%.*}/gnome-clocks-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=bf167f7f44f4f2fb424d4716652c9ba1f29e16e49071e26a1bb833f8dce794c6
CLANDRO_PKG_DEPENDS="geoclue, geocode-glib, glib, gnome-desktop4, gtk4, libadwaita, libgweather"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, gettext, glib-cross, valac, vorbis-tools"
CLANDRO_PKG_PYTHON_COMMON_DEPS="itstool"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_HOSTBUILD=true

clandro_step_host_build() {
	local -a ubuntu_packages=(
		"libao-common"
		"libao4"
		"libflac12t64"
		"libogg0"
		"libspeex1"
		"libvorbis0a"
		"libvorbisenc2"
		"libvorbisfile3"
		"vorbis-tools"
	)

	clandro_download_ubuntu_packages "${ubuntu_packages[@]}"
}

clandro_step_pre_configure() {
	clandro_setup_gir
	clandro_setup_glib_cross_pkg_config_wrapper
	export CLANDRO_MESON_ENABLE_SOVERSION=1

	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		export HOSTBUILD_ROOTFS="${CLANDRO_PKG_HOSTBUILD_DIR}/ubuntu_packages"
		export LD_LIBRARY_PATH="${HOSTBUILD_ROOTFS}/usr/lib/x86_64-linux-gnu"
		export PATH="${HOSTBUILD_ROOTFS}/usr/bin:$PATH"
	fi
}
