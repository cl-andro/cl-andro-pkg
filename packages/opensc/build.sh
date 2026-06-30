CLANDRO_PKG_HOMEPAGE=https://github.com/OpenSC/OpenSC
CLANDRO_PKG_DESCRIPTION="Open source smart card tools and middleware"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.27.1"
CLANDRO_PKG_SRCURL="https://github.com/OpenSC/OpenSC/releases/download/${CLANDRO_PKG_VERSION}/opensc-${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=976f4a23eaf3397a1a2c3a7aac80bf971a8c3d829c9a79f06145bfaeeae5eca7
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="glib, libpcsclite"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
CFLAGS=-I$CLANDRO_PREFIX/include/PCSC
"

clandro_step_pre_configure() {
	autoreconf -vfi
}
