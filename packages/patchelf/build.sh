CLANDRO_PKG_HOMEPAGE=https://nixos.org/patchelf.html
CLANDRO_PKG_DESCRIPTION="Utility to modify the dynamic linker and RPATH of ELF executables"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.18.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/NixOS/patchelf/archive/refs/tags/$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=1451d01ee3a21100340aed867d0b799f46f0b1749680028d38c3f5d0128fb8a7
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	./bootstrap.sh
}
