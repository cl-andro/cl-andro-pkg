CLANDRO_PKG_HOMEPAGE=https://www.spice-space.org/
CLANDRO_PKG_DESCRIPTION="Implements the server side of the SPICE protocol"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.16.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://www.spice-space.org/download/releases/spice-server/spice-${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=0a6ec9528f05371261bbb2d46ff35e7b5c45ff89bb975a99af95a5f20ff4717d
CLANDRO_PKG_DEPENDS="glib, gst-plugins-base, gstreamer, libc++, libiconv, libjpeg-turbo, liblz4, libopus, liborc, libpixman, libsasl, libspice-protocol, openssl, zlib"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--enable-manual=no
--disable-tests
"

clandro_step_pre_configure() {
	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}

clandro_step_post_make_install() {
	ln -sf libspice-server.so "${CLANDRO_PREFIX}"/lib/libspice-server.so.1
}
