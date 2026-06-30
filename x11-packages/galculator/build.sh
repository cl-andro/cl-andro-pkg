CLANDRO_PKG_HOMEPAGE=https://sourceforge.net/projects/galculator/
CLANDRO_PKG_DESCRIPTION="GTK+ based scientific calculator"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.1.4
CLANDRO_PKG_REVISION=25
CLANDRO_PKG_SRCURL="https://github.com/galculator/galculator/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=dcbdb48ddf8a3f68b9aa5902f880f174fd269de2b7410988148d05871012e142
CLANDRO_PKG_DEPENDS="atk, gdk-pixbuf, glib, gtk3, libcairo, pango"

clandro_step_pre_configure() {
	autoreconf -fi
	CFLAGS+=" -fcommon"
}
