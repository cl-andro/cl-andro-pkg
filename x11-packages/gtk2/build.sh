CLANDRO_PKG_HOMEPAGE=https://www.gtk.org/
CLANDRO_PKG_DESCRIPTION="GObject-based multi-platform GUI toolkit (legacy)"
CLANDRO_PKG_LICENSE="LGPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
_MAJOR_VERSION=2.24
CLANDRO_PKG_VERSION=${_MAJOR_VERSION}.33
CLANDRO_PKG_REVISION=8
CLANDRO_PKG_SRCURL=https://download.gnome.org/sources/gtk+/${_MAJOR_VERSION}/gtk+-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=ac2ac757f5942d318a311a54b0c80b5ef295f299c2a73c632f6bfb1ff49cc6da
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_DEPENDS="adwaita-icon-theme, atk, coreutils, desktop-file-utils, fontconfig, freetype, glib, gtk-update-icon-cache, harfbuzz, libandroid-shmem, libcairo, librsvg, libx11, libxcomposite, libxcursor, libxdamage, libxext, libxfixes, libxi, libxinerama, libxrandr, libxrender, pango, shared-mime-info, ttf-dejavu"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner"
CLANDRO_PKG_CONFLICTS="libgtk2"
CLANDRO_PKG_REPLACES="libgtk2"
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--enable-shm
--enable-xkb
--enable-xinerama
--disable-glibtest
--disable-cups
--disable-papi
--with-xinput=yes
--enable-introspection=yes
"

## 1. gtk-update-icon-cache is subpackage of 'gtk3'
## 2. locales are not supported by Termux and wasting space
## 3. for backward compatibility; not in build using Git source
CLANDRO_PKG_RM_AFTER_INSTALL="
bin/gtk-update-icon-cache
lib/locale
share/gtk-doc
"

clandro_step_pre_configure() {
	autoreconf -fi

	clandro_setup_gir

	export LIBS="-landroid-shmem"
	export LDFLAGS="${LDFLAGS} -landroid-shmem"
}

clandro_step_post_configure() {
	touch ./gtk/g-ir-scanner
}

clandro_step_create_debscripts() {
	for i in $(test "$CLANDRO_PACKAGE_FORMAT" != "pacman" && echo postinst) prerm triggers; do
		sed \
			"s|@CLANDRO_PREFIX@|${CLANDRO_PREFIX}|g" \
			"${CLANDRO_PKG_BUILDER_DIR}/hooks/${i}.in" > ./${i}
		chmod 755 ./${i}
	done
	unset i
	chmod 644 ./triggers
}
