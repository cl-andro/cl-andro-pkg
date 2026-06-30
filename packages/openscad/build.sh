CLANDRO_PKG_HOMEPAGE=https://openscad.org/
CLANDRO_PKG_DESCRIPTION="The programmers solid 3D CAD modeller (headless build)"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2021.01"
CLANDRO_PKG_REVISION=6
CLANDRO_PKG_SRCURL="https://files.openscad.org/openscad-$CLANDRO_PKG_VERSION.src.tar.gz"
CLANDRO_PKG_SHA256=d938c297e7e5f65dbab1461cac472fc60dfeaa4999ea2c19b31a4184f2d70359
CLANDRO_PKG_DEPENDS="boost, double-conversion, fontconfig, freetype, glib, harfbuzz, libc++, libgmp, libmpfr, libxml2, libzip"
CLANDRO_PKG_BUILD_DEPENDS="boost-headers, cgal, eigen"
CLANDRO_PKG_GROUPS="science"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_POLICY_VERSION_MINIMUM=3.5
-DBoost_USE_STATIC_LIBS=OFF
-DBUILD_SHARED_LIBS=ON
-DBUILD_STATIC_LIBS=OFF
-DNULLGL=ON
"

clandro_step_make_install () {
	mkdir -p $CLANDRO_PREFIX/share/openscad
	install openscad $CLANDRO_PREFIX/bin/
	cp -r $CLANDRO_PKG_SRCDIR/libraries $CLANDRO_PREFIX/share/openscad/
	cp -r $CLANDRO_PKG_SRCDIR/examples $CLANDRO_PREFIX/share/openscad/
}
