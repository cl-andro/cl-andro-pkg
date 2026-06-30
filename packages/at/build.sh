CLANDRO_PKG_HOMEPAGE=https://salsa.debian.org/debian/at
CLANDRO_PKG_DESCRIPTION="AT and batch delayed command scheduling utility and daemon"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=3.2.5
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_SRCURL=https://deb.debian.org/debian/pool/main/a/at/at_${CLANDRO_PKG_VERSION}.orig.tar.gz
CLANDRO_PKG_SHA256=bb066b389d7c9bb9d84a35738032b85c30cba7d949f758192adc72c9477fd3b8
CLANDRO_PKG_SUGGESTS="clandro-services"
CLANDRO_PKG_BUILD_IN_SRC=true

# Force make -j1.
CLANDRO_PKG_MAKE_PROCESSES=1

# Setting loadavg_mx to 8.0 as most devices (8 core)
# do not have loadavg below 5-6.
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_path_SENDMAIL=$CLANDRO_PREFIX/bin/sendmail
--with-loadavg_mx=8.0
--with-etcdir=$CLANDRO_PREFIX/etc
--with-jobdir=$CLANDRO_PREFIX/var/spool/atd
--with-atspool=$CLANDRO_PREFIX/var/spool/atd
"

# at.allow and at.deny are not supported in Termux.
CLANDRO_PKG_RM_AFTER_INSTALL="
share/man/man5
"

CLANDRO_PKG_SERVICE_SCRIPT=("atd" "mkdir -p $CLANDRO_PREFIX/var/run && exec atd -f")

clandro_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!${CLANDRO_PREFIX}/bin/sh
	mkdir -p $CLANDRO_PREFIX/var/run
	EOF
}
