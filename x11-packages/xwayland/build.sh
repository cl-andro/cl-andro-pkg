CLANDRO_PKG_HOMEPAGE=https://xorg.freedesktop.org/wiki/
CLANDRO_PKG_DESCRIPTION="Wayland X11 server"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="24.1.11"
CLANDRO_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/xserver/xwayland-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=27115a1a8819078409bf6fecfeb7724e8137bd36426de7005a5b3aae0a2138ff
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libandroid-shmem, libdrm, libepoxy, libpciaccess, libpixman, libwayland, libwayland-protocols, libx11, libxau, libxcvt, libxfont2, libxinerama, libxkbfile, libxshmfence, opengl, openssl, xkeyboard-config, xorg-protocol-txt, xorg-xkbcomp"
CLANDRO_PKG_BUILD_DEPENDS="libwayland-cross-scanner"

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dmitshm=true
-Dxres=true
-Dxv=true
-Dsecure-rpc=false
-Dscreensaver=true
-Dxdmcp=true
-Dglx=true
-Ddri3=true
-Dxinerama=true
-Dxace=true
-Dxcsecurity=true
-Dxf86bigfont=true
-Ddrm=true
-Dglamor=false
-Dxvfb=false
-Dlibunwind=false
-Dipv6=true
-Dsha1=libcrypto
-Ddefault_font_path=$CLANDRO_PREFIX/share/fonts
"

# Remove files conflicting with xorg-server:
CLANDRO_PKG_RM_AFTER_INSTALL="
lib/xorg/protocol.txt
share/X11/xkb/compiled
share/man/man1/Xserver.1
"

clandro_step_pre_configure() {
	clandro_setup_wayland_cross_pkg_config_wrapper

	CFLAGS+=" -fcommon -fPIC -DFNDELAY=O_NDELAY -Wno-int-to-pointer-cast -Wno-implicit-function-declaration"
	CPPFLAGS+=" -fcommon -fPIC -I${CLANDRO_PREFIX}/include/libdrm"
	LDFLAGS+=" -landroid-shmem"
}
