CLANDRO_SUBPKG_DESCRIPTION="X virtual framebuffer"
CLANDRO_SUBPKG_DEPEND_ON_PARENT=false
CLANDRO_SUBPKG_DEPENDS="libandroid-shmem, libdrm, libpixman, libx11, libxau, libxfont2, libxinerama, libxkbfile, libxshmfence, opengl, openssl, xkeyboard-config, xorg-protocol-txt, xorg-xkbcomp"
CLANDRO_SUBPKG_CONFLICTS="xorg-xvfb"
CLANDRO_SUBPKG_REPLACES="xorg-xvfb"
CLANDRO_SUBPKG_INCLUDE="
bin/Xvfb
bin/xvfb-run
share/man/man1/Xvfb.1.gz
"
