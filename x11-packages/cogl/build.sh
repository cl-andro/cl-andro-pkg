CLANDRO_PKG_HOMEPAGE=https://developer-old.gnome.org/cogl/
CLANDRO_PKG_DESCRIPTION="A small open source library for using 3D graphics hardware for rendering"
CLANDRO_PKG_LICENSE="MIT, BSD 3-Clause"
CLANDRO_PKG_LICENSE_FILE="COPYING"
CLANDRO_PKG_MAINTAINER="@clandro"
_MAJOR_VERSION=1.22
CLANDRO_PKG_VERSION=${_MAJOR_VERSION}.8
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://download.gnome.org/sources/cogl/${_MAJOR_VERSION}/cogl-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=a805b2b019184710ff53d0496f9f0ce6dcca420c141a0f4f6fcc02131581d759
CLANDRO_PKG_DEPENDS="gdk-pixbuf, glib, harfbuzz, libandroid-shmem, libcairo, libx11, libxcomposite, libxdamage, libxext, libxfixes, libxrandr, opengl, pango"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner"
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
with_gl_libname=libGL.so
--enable-introspection=yes
"

clandro_step_pre_configure() {
	clandro_setup_gir

	LDFLAGS+=" -landroid-shmem"

	export GLIB_GENMARSHAL=glib-genmarshal
	export GOBJECT_QUERY=gobject-query
	export GLIB_MKENUMS=glib-mkenums
	export GLIB_COMPILE_RESOURCES=glib-compile-resources
}
