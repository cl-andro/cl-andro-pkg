CLANDRO_PKG_HOMEPAGE="https://celluloid-player.github.io/"
CLANDRO_PKG_DESCRIPTION="Simple GTK+ frontend for mpv"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.30"
CLANDRO_PKG_SRCURL="https://github.com/celluloid-player/celluloid/releases/download/v${CLANDRO_PKG_VERSION}/celluloid-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=7fef96431842c24e5ae78a9c42bc6523818a6c45213f23ceb146d037d6ec8559
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="gdk-pixbuf, glib, gtk4, libadwaita, libepoxy, mpv-x"

clandro_step_pre_configure() {
	# Workaround strict compiler error
	CFLAGS+=" -Wno-format-nonliteral"

	clandro_setup_glib_cross_pkg_config_wrapper
}
