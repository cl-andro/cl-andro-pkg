CLANDRO_PKG_HOMEPAGE=https://www.gnome.org/
CLANDRO_PKG_DESCRIPTION="Allows you to load glade interface files in a program at runtime"
CLANDRO_PKG_LICENSE="LGPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.6.4
CLANDRO_PKG_REVISION=24
CLANDRO_PKG_SRCURL=https://download.gnome.org/sources/libglade/2.6/libglade-${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=64361e7647839d36ed8336d992fd210d3e8139882269bed47dc4674980165dec
CLANDRO_PKG_DEPENDS="atk, fontconfig, freetype, gdk-pixbuf, glib, gtk2, libcairo, libxml2, pango"
CLANDRO_PKG_RM_AFTER_INSTALL="share/gtk-doc"

# For libglade-convert.
CLANDRO_PKG_SUGGESTS="python2"

clandro_step_pre_configure() {
	export LIBS="-lgmodule-2.0"
}

clandro_step_post_make_install() {
	sed \
		-i "s|#!/usr/bin/python|#!${CLANDRO_PREFIX}/bin/python2|g" \
		"${CLANDRO_PREFIX}/bin/libglade-convert"
}
