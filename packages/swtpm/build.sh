CLANDRO_PKG_HOMEPAGE=https://github.com/stefanberger/swtpm
CLANDRO_PKG_DESCRIPTION="Software TPM Emulator"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_LICENSE_FILE="LICENSE"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.10.1"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL="https://github.com/stefanberger/swtpm/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=f8da11cadfed27e26d26c5f58a7b8f2d14d684e691927348906b5891f525c684
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="glib, json-glib, libseccomp, libtpms, openssl"
CLANDRO_PKG_BUILD_DEPENDS="libtasn1"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--with-openssl
--without-gnutls
--disable-tests
"

clandro_step_pre_configure() {
	autoreconf -fi

	CPPFLAGS+=" -Dindex=strchr"
}

clandro_step_post_massage() {
	rm -r "${CLANDRO_PKG_MASSAGEDIR}/${CLANDRO_PREFIX}"/libexec/installed-tests
}
