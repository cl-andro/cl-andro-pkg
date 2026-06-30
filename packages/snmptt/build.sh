CLANDRO_PKG_HOMEPAGE=http://www.snmptt.org/
CLANDRO_PKG_DESCRIPTION="SNMP trap translator"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.5
CLANDRO_PKG_SRCURL=https://downloads.sourceforge.net/snmptt/snmptt_${CLANDRO_PKG_VERSION}.tgz
CLANDRO_PKG_SHA256=91fb6146a08c0d143e4193f1fffdb697f769f75666d72a73eeb78c013b8a227f
CLANDRO_PKG_DEPENDS="net-snmp, perl"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	find . -maxdepth 1 -type f -name 'snmptt*' | xargs -n 1 sed -i \
		-e 's:\([^A-Za-z0-9.]\)/etc/:\1'$CLANDRO_PREFIX'/etc/:g' \
		-e 's:\([^A-Za-z0-9.]\)/sbin/:\1'$CLANDRO_PREFIX'/bin/:g' \
		-e 's:\([^A-Za-z0-9.]\)/usr/sbin/:\1'$CLANDRO_PREFIX'/bin/:g' \
		-e 's:\([^A-Za-z0-9.]\)/var/:\1'$CLANDRO_PREFIX'/var/:g' \
		-e 's:\([^A-Za-z0-9.]\)/usr/local/etc/:\1'$CLANDRO_PREFIX'/local/etc/:g'
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin \
		snmptt snmptt-net-snmp-test \
		snmpttconvert snmpttconvertmib \
		snmptthandler snmptthandler-embedded
	install -Dm600 -t $CLANDRO_PREFIX/share/snmptt/examples examples/*
	install -Dm600 -t $CLANDRO_PREFIX/etc/snmptt snmptt.ini
	install -Dm600 -T examples/snmptt.conf.generic \
		$CLANDRO_PREFIX/etc/snmptt/snmptt.conf
}
