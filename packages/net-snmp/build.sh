CLANDRO_PKG_HOMEPAGE=http://www.net-snmp.org/
CLANDRO_PKG_DESCRIPTION="Various tools relating to the Simple Network Management Protocol"
CLANDRO_PKG_LICENSE="HPND, BSD 3-Clause, MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="5.9.5.2"
CLANDRO_PKG_SRCURL="https://github.com/net-snmp/net-snmp/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=dc67748f382f7c0d2c17b62aabb1445724d80bb20a09081b7f010c9c86b84d45
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--with-agentx-socket=$CLANDRO_PREFIX/var/agentx/master
--with-default-snmp-version=3
--with-logfile=$CLANDRO_PREFIX/var/log/net-snmpd.log
--with-mnttab=$CLANDRO_PREFIX/etc/mtab
--with-persistent-directory=$CLANDRO_PREFIX/var/lib/net-snmp
--with-sys-contact=root@localhost
--with-sys-location=Unknown
--with-temp-file-pattern=$CLANDRO_PREFIX/tmp/snmpdXXXXXX
ac_cv_path_LPSTAT_PATH=$CLANDRO_PREFIX/bin/lpstat
"

clandro_step_pre_configure() {
	if [ $CLANDRO_ARCH = "x86_64" ]; then
		CPPFLAGS+=" -DOPENSSL_NO_INLINE_ASM"
	fi
}
