CLANDRO_PKG_HOMEPAGE=https://wvware.sourceforge.net/
CLANDRO_PKG_DESCRIPTION="A library which allows access to Microsoft Word files"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.2.9
CLANDRO_PKG_REVISION=6
CLANDRO_PKG_SRCURL=https://fossies.org/linux/misc/old/wv-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=4c730d3b325c0785450dd3a043eeb53e1518598c4f41f155558385dd2635c19d
CLANDRO_PKG_DEPENDS="glib, libgsf, libpng, libxml2, zlib"

clandro_step_pre_configure() {
	NOCONFIGURE=1 ./autogen.sh
}
