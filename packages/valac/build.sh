CLANDRO_PKG_HOMEPAGE=https://wiki.gnome.org/Projects/Vala
CLANDRO_PKG_DESCRIPTION="C# like language for the GObject system"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.56.19"
CLANDRO_PKG_SRCURL=https://download.gnome.org/sources/vala/${CLANDRO_PKG_VERSION%.*}/vala-$CLANDRO_PKG_VERSION.tar.xz
CLANDRO_PKG_SHA256=5ad7cbbfcc0de61b403d6797c9ef60455bfbebd8e162aec33b5b0b097adfb9d5
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="glib"
CLANDRO_PKG_RECOMMENDS="clang, pkg-config"
CLANDRO_PKG_BREAKS="valac-dev"
CLANDRO_PKG_REPLACES="valac-dev"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--with-cgraph=no"

clandro_step_post_make_install() {
	local v=$(echo ${CLANDRO_PKG_VERSION#*:} | cut -d . -f 1-2)
	ln -sf vala-${v}/libvalaccodegen.so $CLANDRO_PREFIX/lib/libvalaccodegen.so
}
