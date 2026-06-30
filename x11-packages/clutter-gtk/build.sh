CLANDRO_PKG_HOMEPAGE=https://wiki.gnome.org/Projects/Clutter
CLANDRO_PKG_DESCRIPTION="A library providing facilities to integrate Clutter into GTK+ applications and vice versa"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
_MAJOR_VERSION=1.8
CLANDRO_PKG_VERSION=${_MAJOR_VERSION}.4
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://download.gnome.org/sources/clutter-gtk/${_MAJOR_VERSION}/clutter-gtk-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=521493ec038973c77edcb8bc5eac23eed41645117894aaee7300b2487cb42b06
CLANDRO_PKG_DEPENDS="atk, clutter, cogl, fontconfig, freetype, gdk-pixbuf, glib, gtk3, harfbuzz, json-glib, libcairo, libx11, libxcomposite, libxdamage, libxext, libxfixes, libxi, libxrandr, pango"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner"
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--enable-introspection=yes
"

clandro_step_pre_configure() {
	clandro_setup_gir
}
