CLANDRO_PKG_HOMEPAGE=https://wiki.debian.org/Aptitude
CLANDRO_PKG_DESCRIPTION="terminal-based package manager"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.8.13
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=http://deb.debian.org/debian/pool/main/a/aptitude/aptitude_$CLANDRO_PKG_VERSION.orig.tar.xz
CLANDRO_PKG_SHA256=0ef50cb5de27215dd30de74dd9b46b318f017bd0ec3f5c4735df7ac0beb40248
CLANDRO_PKG_DEPENDS="apt, boost, googletest, libcwidget, libsigc++-2.0, libsqlite, libxapian, ncurses"
CLANDRO_PKG_BUILD_DEPENDS="boost-headers"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-tests
--disable-docs
--disable-boost-lib-checks
--with-boost=$CLANDRO_PREFIX
--with-package-state-loc=$CLANDRO_PREFIX/var/lib/aptitude
--with-lock-loc=$CLANDRO_PREFIX/var/lock/aptitude
--disable-nls
"

clandro_step_pre_configure() {
	CXXFLAGS+=" -DNCURSES_WIDECHAR=1"
}

clandro_step_create_debscripts() {
	cat <<- EOF > postrm
	#!$CLANDRO_PREFIX/bin/sh
	case "\$1" in
	purge)
		rm -fr $CLANDRO_PREFIX/var/lib/aptitude
		rm -f $CLANDRO_PREFIX/var/log/aptitude $CLANDRO_PREFIX/var/log/aptitude.[0-9].gz
		;;
	esac
	EOF
}
