CLANDRO_PKG_HOMEPAGE=https://github.com/stefanberger/libtpms
CLANDRO_PKG_DESCRIPTION="Provides software emulation of a Trusted Platform Module (TPM 1.2 and TPM 2.0)"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.10.2"
CLANDRO_PKG_SRCURL=https://github.com/stefanberger/libtpms/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=edac03680f8a4a1c5c1d609a10e3f41e1a129e38ff5158f0c8deaedc719fb127
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="openssl"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--with-openssl
--with-tpm2
"

clandro_step_pre_configure() {
	autoreconf -fi
	CPPFLAGS+=" -Dindex=strchr"
}
