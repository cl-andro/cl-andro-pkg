CLANDRO_PKG_HOMEPAGE=https://gnucobol.sourceforge.io/
CLANDRO_PKG_DESCRIPTION="A free/libre COBOL compiler"
CLANDRO_PKG_LICENSE="GPL-3.0, LGPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.2"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://mirrors.kernel.org/gnu/gnucobol/gnucobol-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=3bb48af46ced4779facf41fdc2ee60e4ccb86eaa99d010b36685315df39c2ee2
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="json-c, libgmp, libvbisam, libxml2, ncurses"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--without-db
--with-json=json-c
--with-vbisam
"

clandro_step_pre_configure() {
	local lp64="$(( $CLANDRO_ARCH_BITS / 32 - 1 ))"
	export COB_LI_IS_LL="${lp64}"
	export COB_32_BIT_LONG="$(( 1 - ${lp64} ))"
	export COB_HAS_64_BIT_POINTER="${lp64}"
}
