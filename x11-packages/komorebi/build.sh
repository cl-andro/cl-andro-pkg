CLANDRO_PKG_HOMEPAGE=https://github.com/cheesecakeufo/komorebi
CLANDRO_PKG_DESCRIPTION="Animated Wallpapers for Linux"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.1"
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL="https://github.com/cheesecakeufo/komorebi/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=66ee2fe21e16c3f9c18b824fa88a8b726812b1fdd81217cb53f7dad8d6dbae0f
CLANDRO_PKG_DEPENDS="clutter, clutter-gst, clutter-gtk, gdk-pixbuf, glib, gstreamer, gtk3, komorebi-data, libgee, webkit2gtk-4.1"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, valac"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_POLICY_VERSION_MINIMUM=3.5
"

clandro_step_post_get_source() {
	sed -i 's/\(webkit2gtk-4.\)0/\11/g' CMakeLists.txt
	find . -type f -name '*.vala' -o -name '*.desktop' | xargs -n 1 sed -i \
		"s:/System/Resources/Komorebi:${CLANDRO_PREFIX}/share/komorebi:g"
}

clandro_step_pre_configure() {
	clandro_setup_gir
}
