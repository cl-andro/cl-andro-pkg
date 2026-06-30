CLANDRO_PKG_HOMEPAGE=http://openbox.org
CLANDRO_PKG_DESCRIPTION="Highly configurable and lightweight X11 window manager"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=3.6.1
CLANDRO_PKG_REVISION=61
CLANDRO_PKG_SRCURL=http://openbox.org/dist/openbox/openbox-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=8b4ac0760018c77c0044fab06a4f0c510ba87eae934d9983b10878483bde7ef7
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--disable-session-management"
CLANDRO_PKG_DEPENDS="bash, fontconfig, freetype, gdk-pixbuf, glib, harfbuzz, imlib2, libcairo, libice, librsvg, libsm, libx11, libxcursor, libxext, libxft, libxinerama, libxml2, libxrandr, libxrender, pango, startup-notification"

# Configuration utility.
CLANDRO_PKG_RECOMMENDS="obconf-qt"

# For default menu entries.
CLANDRO_PKG_SUGGESTS="aterm, fltk, geany, the-powder-toy, dosbox"

CLANDRO_PKG_RM_AFTER_INSTALL="
bin/gdm-control
bin/gnome-panel-control
bin/openbox-gnome-session
bin/openbox-kde-session
share/man/man1/openbox-gnome-session.1
share/man/man1/openbox-kde-session.1
share/gnome-session
share/gnome
share/xsessions/openbox-gnome.desktop
share/xsessions/openbox-kde.desktop
"

CLANDRO_PKG_CONFFILES="
etc/xdg/openbox/autostart
etc/xdg/openbox/environment
etc/xdg/openbox/menu.xml
etc/xdg/openbox/rc.xml
"

clandro_step_post_make_install() {
	## install custom variant of scripts startup scripts
	cp -f "${CLANDRO_PKG_BUILDER_DIR}/scripts/openbox-session" "${CLANDRO_PREFIX}/bin/openbox-session"
	sed -i "s|@CLANDRO_PREFIX@|$CLANDRO_PREFIX|g" "${CLANDRO_PREFIX}/bin/openbox-session"
	chmod 755 "${CLANDRO_PREFIX}/bin/openbox-session"

	cp -f "${CLANDRO_PKG_BUILDER_DIR}/scripts/openbox-autostart" "${CLANDRO_PREFIX}/libexec/openbox-autostart"
	sed -i "s|@CLANDRO_PREFIX@|$CLANDRO_PREFIX|g" "${CLANDRO_PREFIX}/libexec/openbox-autostart"
	chmod 755 "${CLANDRO_PREFIX}/libexec/openbox-autostart"

	cp -f "${CLANDRO_PKG_BUILDER_DIR}/scripts/openbox-xdg-autostart" "${CLANDRO_PREFIX}/libexec/openbox-xdg-autostart"
	sed -i "s|@CLANDRO_PREFIX@|$CLANDRO_PREFIX|g" "${CLANDRO_PREFIX}/libexec/openbox-xdg-autostart"
	chmod 755 "${CLANDRO_PREFIX}/libexec/openbox-xdg-autostart"

	## install custom config files
	cp -f "${CLANDRO_PKG_BUILDER_DIR}/configs/autostart" "${CLANDRO_PREFIX}/etc/xdg/openbox/autostart"
	chmod 755 "${CLANDRO_PREFIX}/etc/xdg/openbox/autostart"

	cp -f "${CLANDRO_PKG_BUILDER_DIR}/configs/environment" "${CLANDRO_PREFIX}/etc/xdg/openbox/environment"
	chmod 755 "${CLANDRO_PREFIX}/etc/xdg/openbox/environment"

	cp -f "${CLANDRO_PKG_BUILDER_DIR}/configs/menu.xml" "${CLANDRO_PREFIX}/etc/xdg/openbox/menu.xml"
	chmod 644 "${CLANDRO_PREFIX}/etc/xdg/openbox/menu.xml"

	cp -f "${CLANDRO_PKG_BUILDER_DIR}/configs/rc.xml" "${CLANDRO_PREFIX}/etc/xdg/openbox/rc.xml"
	chmod 644 "${CLANDRO_PREFIX}/etc/xdg/openbox/rc.xml"

	## install theme 'Onyx-Black'
	cp -a "${CLANDRO_PKG_BUILDER_DIR}/Theme-Onyx-Black" "${CLANDRO_PREFIX}/share/themes/Onyx-black"
	find "${CLANDRO_PREFIX}/share/themes/Onyx-black" -type d | xargs chmod 755
	find "${CLANDRO_PREFIX}/share/themes/Onyx-black" -type f | xargs chmod 644
}
