CLANDRO_PKG_HOMEPAGE=https://exiftool.org/
CLANDRO_PKG_DESCRIPTION="Utility for reading, writing and editing meta information in a wide variety of files."
CLANDRO_PKG_LICENSE="Artistic-License-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="13.58"
CLANDRO_PKG_SRCURL="https://exiftool.org/Image-ExifTool-$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=c84fb6b613a480a638225d44979bf44cd2f91c92b79f4d2aa43773c89fa4199e
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="perl"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true

clandro_step_make_install() {
	local current_perl_version=$(. $CLANDRO_SCRIPTDIR/packages/perl/build.sh; echo $CLANDRO_PKG_VERSION)

	install -Dm700 "$CLANDRO_PKG_SRCDIR"/exiftool "$CLANDRO_PREFIX"/bin/exiftool
	find "$CLANDRO_PKG_SRCDIR"/lib -name "*.pod" -delete
	mkdir -p "$CLANDRO_PREFIX/lib/perl5/site_perl/$current_perl_version"
	rm -rf "$CLANDRO_PREFIX/lib/perl5/site_perl/${current_perl_version}"/{Image,File}
	cp -a "$CLANDRO_PKG_SRCDIR"/lib/{Image,File} "$CLANDRO_PREFIX/lib/perl5/site_perl/${current_perl_version}/"
}
