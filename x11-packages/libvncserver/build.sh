CLANDRO_PKG_HOMEPAGE=https://libvnc.github.io/
CLANDRO_PKG_DESCRIPTION="Cross-platform C libraries that allow you to easily implement VNC server or client functionality"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.9.15"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://github.com/LibVNC/libvncserver/archive/refs/tags/LibVNCServer-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=62352c7795e231dfce044beb96156065a05a05c974e5de9e023d688d8ff675d7
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libgcrypt, libjpeg-turbo, liblzo, libpng, openssl, zlib"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_POLICY_VERSION_MINIMUM=3.5
-DWITH_GNUTLS=OFF
-DWITH_OPENSSL=ON
-DWITH_SASL=OFF
"

clandro_step_post_massage() {
	local f
	for f in ./lib/pkgconfig/libvnc{client,server}.pc; do
		if [ -e "${f}" ]; then
			sed -i '/^Libs\.private:/s/ -l\(-pthread\)/ \1/' "${f}"
		fi
	done
}
