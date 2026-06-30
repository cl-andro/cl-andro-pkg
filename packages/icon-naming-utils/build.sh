CLANDRO_PKG_HOMEPAGE=http://tango.freedesktop.org/
CLANDRO_PKG_DESCRIPTION="Maps the new names of icons for Tango to the legacy names used by the GNOME and KDE desktops"
CLANDRO_PKG_LICENSE="GPL-2.0-only"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.8.90"
CLANDRO_PKG_SRCURL="https://tango.freedesktop.org/releases/icon-naming-utils-$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=044ab2199ed8c6a55ce36fd4fcd8b8021a5e21f5bab028c0a7cdcf52a5902e1c
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_DEPENDS="perl"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--sysconfdir=$CLANDRO_PREFIX/etc
--localstatedir=$CLANDRO_PREFIX/var
"

clandro_step_pre_configure() {
	autoreconf -fi
}

clandro_step_create_debscripts()  {
	cat <<- POSTINST_EOF > ./postinst
	#!$CLANDRO_PREFIX/bin/bash
	set -e

	export PERL_MM_USE_DEFAULT=1

	echo "Sideloading Perl XML::Simple ..."
	cpan -Ti XML::Simple

	exit 0
	POSTINST_EOF
}
