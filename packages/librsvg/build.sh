CLANDRO_PKG_HOMEPAGE=https://wiki.gnome.org/action/show/Projects/LibRsvg
CLANDRO_PKG_DESCRIPTION="Library to render SVG files using cairo"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.62.1"
CLANDRO_PKG_SRCURL=https://download.gnome.org/sources/librsvg/${CLANDRO_PKG_VERSION%.*}/librsvg-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=b41ca84206242fddd826a2bf76348d7cdf52c1050cbfa060b866e81a252145c3
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="fontconfig, freetype, gdk-pixbuf, glib, harfbuzz, libcairo, libdav1d, libpng, libxml2, pango"
# Note: Do not add valac which prevents bootstrapping due to cyclic dependency (#27567)
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner"
CLANDRO_PKG_BREAKS="librsvg-dev"
CLANDRO_PKG_REPLACES="librsvg-dev"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Davif=enabled
-Ddocs=disabled
-Dintrospection=enabled
-Dtests=false
-Dvala=enabled
-Dpixbuf-loader=enabled
"

clandro_step_pre_configure() {
	clandro_setup_gir
	clandro_setup_meson
	clandro_setup_rust
	clandro_setup_cargo_c

	# clandro_setup_rust unsets CFLAGS so we called clandro_setup_meson before
	# we need to reset clandro_setup_meson to avoid `line 70: CFLAGS: unbound variable` error
	clandro_setup_meson() { :; }

	sed -i 's/@BUILD_TRIPLET@/'"$CARGO_TARGET_NAME"'/' "meson.build"

	LDFLAGS+=" -fuse-ld=lld"

	# Work around https://gitlab.gnome.org/GNOME/librsvg/-/issues/820
	if [ "$CLANDRO_ARCH" = "arm" ]; then
		LDFLAGS+=" -Wl,-z,muldefs"
	fi

	# See https://github.com/GNOME/librsvg/blob/master/COMPILING.md
	export RUST_TARGET=$CARGO_TARGET_NAME
}

clandro_step_post_massage() {
	find lib -name '*.la' -delete
}
