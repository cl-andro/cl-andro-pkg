# x11-packages
CLANDRO_PKG_HOMEPAGE=https://www.wireshark.org/
CLANDRO_PKG_DESCRIPTION="Network protocol analyzer"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.6.14
CLANDRO_PKG_REVISION=21
CLANDRO_PKG_SRCURL=https://www.wireshark.org/download/src/all-versions/wireshark-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=c4d133c48f52d81fc334c30fa21e09be484d862c29310e57fc2532e5b572e9c4

CLANDRO_PKG_DEPENDS="atk, c-ares, desktop-file-utils, gdk-pixbuf, glib, gtk3, hicolor-icon-theme, krb5, libandroid-shmem, libcairo, libcap, libgcrypt, libgnutls, libgpg-error, liblua52, liblz4, libmaxminddb, libnghttp2, libnl, libpcap, libssh, libxml2, pango, zlib"
CLANDRO_PKG_CONFLICTS="tshark, wireshark, wireshark-cli"
CLANDRO_PKG_PROVIDES="tshark, wireshark, wireshark-cli"
CLANDRO_PKG_REPLACES="tshark, wireshark, wireshark-cli"

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--with-gtk=3 --with-qt=no"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	export CFLAGS=$(echo $CFLAGS | sed 's@-Oz@-Os@g')
	export LIBS=" -landroid-shmem"
}

clandro_step_post_configure() {
	## prebuild libwsutil & libwscodecs for target (needed for plugins/codecs/l16_mono)
	cd ./wsutil && {
		make
		cd -
	}
	cd ./codecs && {
		make
		cd -
	}
}
