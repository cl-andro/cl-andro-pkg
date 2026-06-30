CLANDRO_PKG_HOMEPAGE=https://github.com/lgi-devs/lgi
CLANDRO_PKG_DESCRIPTION="Dynamic Lua binding to GObject libraries using GObject-Introspection"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.9.2+p20251219
CLANDRO_PKG_REVISION=2
_COMMIT=a1308b23b07a787d21fad86157b0b60eb3079f64
CLANDRO_PKG_SRCURL=https://github.com/lgi-devs/lgi/archive/${_COMMIT}.tar.gz
CLANDRO_PKG_SHA256=fda70ea777c6add0511f847dcf6985a767c29fc55fb688fdf748ab415bc29dad
CLANDRO_PKG_DEPENDS="glib, gobject-introspection, libcairo, libffi, lua54"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
	-Dtests=false
	-Dlua-pc=lua54
"

clandro_step_pre_configure() {
	clandro_setup_cmake
}
