CLANDRO_PKG_HOMEPAGE=https://github.com/logrotate/logrotate
CLANDRO_PKG_DESCRIPTION="Simplify the administration of log files on a system which generates a lot of log files"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.22.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/logrotate/logrotate/releases/download/${CLANDRO_PKG_VERSION}/logrotate-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=42b4080ee99c9fb6a7d12d8e787637d057a635194e25971997eebbe8d5e57618
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libpopt, libandroid-glob"

clandro_step_pre_configure() {
	LDFLAGS+=" -landroid-glob"
}
