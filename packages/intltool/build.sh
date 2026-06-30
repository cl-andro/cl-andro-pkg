CLANDRO_PKG_HOMEPAGE=https://launchpad.net/intltool
CLANDRO_PKG_DESCRIPTION="The internationalization tool collection"
CLANDRO_PKG_MAINTAINER="@suhan-paradkar"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_VERSION=0.51.0
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_SRCURL=https://launchpad.net/intltool/trunk/$CLANDRO_PKG_VERSION/+download/intltool-$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=67c74d94196b153b774ab9f89b2fa6c6ba79352407037c8c14d5aeb334e959cd
CLANDRO_PKG_DEPENDS="perl, clang, make, libexpat"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true

clandro_step_create_debscripts()  {
	cat <<- POSTINST_EOF > ./postinst
	#!$CLANDRO_PREFIX/bin/bash
	set -e

	export PERL_MM_USE_DEFAULT=1

	echo "Sideloading Perl XML::Parser..."
	cpan -Ti XML::Parser

	exit 0
	POSTINST_EOF
}
