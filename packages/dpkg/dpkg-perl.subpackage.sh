CLANDRO_SUBPKG_DESCRIPTION="Perl modules for dpkg"
CLANDRO_SUBPKG_INCLUDE="share/perl5"
CLANDRO_SUBPKG_DEPENDS="perl, clang, make"
CLANDRO_SUBPKG_PLATFORM_INDEPENDENT=true

clandro_step_create_subpkg_debscripts() {
	cat <<- POSTINST_EOF > ./postinst
	#!$CLANDRO_PREFIX/bin/bash
	set -e

	export PERL_MM_USE_DEFAULT=1

	echo "Sideloading Perl Locale::gettext ..."
	cpan -Ti Locale::gettext

	exit 0
	POSTINST_EOF
}
