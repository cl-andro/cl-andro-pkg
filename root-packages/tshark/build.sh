CLANDRO_PKG_HOMEPAGE=https://www.wireshark.org/
CLANDRO_PKG_DESCRIPTION="Network protocol analyzer and sniffer"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.6.5"
CLANDRO_PKG_SRCURL=https://www.wireshark.org/download/src/all-versions/wireshark-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=b5322538b20fa3e0bf004be83c534a42937d442be3f960d01b4e1f0db6c50386
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="brotli, c-ares, glib, libandroid-support, libcap, libgcrypt, libgmp, libgnutls, libgpg-error, libiconv, libidn2, liblz4, liblzma, libminizip, libnettle, libnghttp2, libnl, libopus, libpcap, libsnappy, libssh, libunistring, libxml2, openssl, pcre2, speexdsp, zlib, zstd"
CLANDRO_PKG_BREAKS="tshark-dev"
CLANDRO_PKG_REPLACES="tshark-dev"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_wireshark=OFF
-DENABLE_LUA=OFF
-DHAVE_LINUX_IF_BONDING_H=1
"
CLANDRO_PKG_HOSTBUILD=true

clandro_step_host_build() {
	gcc $CLANDRO_PKG_SRCDIR/tools/lemon/lemon.c -o lemon
}

clandro_step_pre_configure() {
	export PATH=$CLANDRO_PKG_HOSTBUILD_DIR:$PATH
	LDFLAGS+=" -lm -landroid-support"
	sed -i "s#-T/usr/share/lemon/lempar.c#-T$CLANDRO_PKG_SRCDIR/tools/lemon/lempar.c#" $CLANDRO_PKG_SRCDIR/cmake/modules/UseLemon.cmake
}
