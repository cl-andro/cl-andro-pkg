CLANDRO_PKG_HOMEPAGE="https://apps.gnome.org/Amberol/"
CLANDRO_PKG_DESCRIPTION="Small and simple sound and music player that is well integrated with GNOME"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2026.1"
CLANDRO_PKG_SRCURL="https://gitlab.gnome.org/World/amberol/-/archive/${CLANDRO_PKG_VERSION}/amberol-${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256="2112eebac5c7b0aab7243c428c794aecb136168c326648cfbbd8654ea2cc7631"
CLANDRO_PKG_DEPENDS="dconf, gdk-pixbuf, glib, graphene, gst-plugins-bad, gst-plugins-base, gst-plugins-good, gstreamer, gtk4, hicolor-icon-theme, libadwaita, pango"
CLANDRO_PKG_BUILD_DEPENDS="blueprint-compiler, glib-cross, libiconv"
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	export CARGO_BUILD_TARGET="${CARGO_TARGET_NAME}"
	export PKG_CONFIG_ALLOW_CROSS=1

	local env_host=$(printf $CARGO_TARGET_NAME | tr a-z A-Z | sed s/-/_/g)
	export CARGO_TARGET_${env_host}_RUSTFLAGS+=" -C link-arg=-liconv"

	clandro_setup_rust
	clandro_setup_meson
	clandro_setup_bpc
	clandro_setup_glib_cross_pkg_config_wrapper
}
