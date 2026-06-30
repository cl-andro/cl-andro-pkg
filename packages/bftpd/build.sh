CLANDRO_PKG_HOMEPAGE=https://bftpd.sourceforge.net/
CLANDRO_PKG_DESCRIPTION="Small, easy-to-configure FTP server"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.6"
CLANDRO_PKG_SRCURL=https://downloads.sourceforge.net/sourceforge/bftpd/bftpd-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=a867ba93a608cccb60944e1fae00e52b463f416b09235f87a31c023b296ac12e
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libcrypt"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--mandir=$CLANDRO_PREFIX/share/man
"

CLANDRO_PKG_CONFFILES="etc/bftpd.conf"
CLANDRO_PKG_RM_AFTER_INSTALL="var/log/bftpd.log"

clandro_step_pre_configure() {
	CFLAGS+=" -fcommon"
}
