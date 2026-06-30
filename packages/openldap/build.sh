CLANDRO_PKG_HOMEPAGE=https://openldap.org
CLANDRO_PKG_DESCRIPTION="OpenLDAP server"
CLANDRO_PKG_LICENSE="OpenLDAP"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.6.13"
CLANDRO_PKG_SRCURL=https://www.openldap.org/software/download/OpenLDAP/openldap-release/openldap-${CLANDRO_PKG_VERSION}.tgz
CLANDRO_PKG_SHA256=d693b49517a42efb85a1a364a310aed16a53d428d1b46c0d31ef3fba78fcb656
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libsasl, libuuid, openssl"
CLANDRO_PKG_BREAKS="openldap-dev"
CLANDRO_PKG_REPLACES="openldap-dev"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_MAKE_ARGS="STRIP="
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
ol_cv_lib_icu=no
ac_cv_func_memcmp_working=yes
--enable-dynamic
--with-yielding_select=yes
--enable-backends=no
--enable-monitor
--enable-mdb
--enable-ldap"

clandro_step_pre_configure() {
	autoreconf -fi

	CFLAGS+=" -DMDB_USE_ROBUST=0"
	LDFLAGS+=" -lcrypto -llog"
}
