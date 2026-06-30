CLANDRO_PKG_HOMEPAGE=https://github.com/cronie-crond/cronie/
CLANDRO_PKG_DESCRIPTION="Daemon that runs specified programs at scheduled times and related tools"
CLANDRO_PKG_LICENSE="ISC, BSD 2-Clause, BSD 3-Clause, GPL-2.0, LGPL-2.1"
CLANDRO_PKG_LICENSE_FILE="COPYING, COPYING.obstack"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.7.2"
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_SRCURL=https://github.com/cronie-crond/cronie/releases/download/cronie-${CLANDRO_PKG_VERSION}/cronie-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=f1da374a15ba7605cf378347f96bc8b678d3d7c0765269c8242cfe5b0789c571
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
CLANDRO_PKG_DEPENDS="dash"
CLANDRO_PKG_SUGGESTS="clandro-services"
CLANDRO_PKG_CONFLICTS="busybox (<< 1.31.1-11)"
CLANDRO_PKG_REPLACES="anacron"

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-anacron
--disable-pam
--with-editor=$CLANDRO_PREFIX/bin/editor
"

CLANDRO_PKG_SERVICE_SCRIPT=("crond" 'exec crond -n -s')

clandro_step_post_get_source() {
	sed -i "s|\"/usr/sbin/sendmail\"|\"${CLANDRO_PREFIX}/bin/sendmail\"|" "${CLANDRO_PKG_SRCDIR}/configure"
	sed -i "s|\"/usr/sbin/sendmail\"|\"${CLANDRO_PREFIX}/bin/sendmail\"|" "${CLANDRO_PKG_SRCDIR}/src/cron.c"
	sed -i "s|\"/tmp\"|\"${CLANDRO_PREFIX}/tmp\"|" "${CLANDRO_PKG_SRCDIR}/src/crontab.c"
	sed -i "s|_PATH_BSHELL \"/bin/sh\"|_PATH_BSHELL \"${CLANDRO_PREFIX}/bin/sh\"|" "${CLANDRO_PKG_SRCDIR}/src/crontab.c"
	sed -i "s|_PATH_STDPATH \"/usr/bin:/bin:/usr/sbin:/sbin\"|_PATH_STDPATH \"${CLANDRO_PREFIX}/bin\"|" "${CLANDRO_PKG_SRCDIR}/src/crontab.c"
	sed -i "s|_PATH_TMP \"/tmp\"|_PATH_TMP \"${CLANDRO_PREFIX}/tmp\"|" "${CLANDRO_PKG_SRCDIR}/src/crontab.c"
	sed -i "s|getdtablesize()|sysconf(_SC_OPEN_MAX)|" "${CLANDRO_PKG_SRCDIR}/src/do_command.c"
	sed -i "s|getdtablesize()|sysconf(_SC_OPEN_MAX)|" "${CLANDRO_PKG_SRCDIR}/src/popen.c"
}

clandro_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$CLANDRO_PREFIX/bin/sh
	mkdir -p $CLANDRO_PREFIX/var/run
	mkdir -p $CLANDRO_PREFIX/var/spool/cron
	mkdir -p $CLANDRO_PREFIX/etc/cron.d
	mkdir -p $CLANDRO_ANDROID_HOME/.cache
	EOF
}
