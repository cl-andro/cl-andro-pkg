CLANDRO_PKG_HOMEPAGE=https://www.freedesktop.org/wiki/Software/pkg-config/
CLANDRO_PKG_DESCRIPTION="Helper tool used when compiling applications and libraries"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.29.2
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=https://pkgconfig.freedesktop.org/releases/pkg-config-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=6fc69c01688c9458a57eb9a1664c9aba372ccda420a02bf4429fe610e7e7d591
CLANDRO_PKG_DEPENDS="glib"
CLANDRO_PKG_RM_AFTER_INSTALL="bin/*-pkg-config"
CLANDRO_PKG_GROUPS="base-devel"

clandro_step_pre_configure() {
	# Use ln -s instead of ln to avoid attempt at hardlinking on
	# device
	export ac_cv_prog_LN='ln -s'
}
