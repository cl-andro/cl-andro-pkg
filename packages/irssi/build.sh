CLANDRO_PKG_HOMEPAGE=https://irssi.org/
CLANDRO_PKG_DESCRIPTION="Terminal based IRC client"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.4.5"
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_SRCURL="https://github.com/irssi/irssi/releases/download/$CLANDRO_PKG_VERSION/irssi-$CLANDRO_PKG_VERSION.tar.xz"
CLANDRO_PKG_SHA256=72a951cb0ad622785a8962801f005a3a412736c7e7e3ce152f176287c52fe062
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="glib, libandroid-glob, libiconv, libotr, ncurses, openssl, perl, utf8proc"
CLANDRO_PKG_BREAKS="irssi-dev"
CLANDRO_PKG_REPLACES="irssi-dev"
CLANDRO_MESON_PERL_CROSS_FILE=$CLANDRO_PKG_TMPDIR/meson-perl-cross-$CLANDRO_ARCH.txt
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dfhs-prefix=$CLANDRO_PREFIX
--cross-file $CLANDRO_MESON_PERL_CROSS_FILE
"

clandro_step_configure() {
	clandro_step_configure_meson
}

clandro_step_pre_configure() {
	LDFLAGS+=" -landroid-glob"

	# Make build log less noisy.
	CFLAGS+=" -Wno-compound-token-split-by-macro"

	local perl_version=$(. $CLANDRO_SCRIPTDIR/packages/perl/build.sh; echo $CLANDRO_PKG_VERSION)

	cat <<- MESON_PERL_CROSS >$CLANDRO_MESON_PERL_CROSS_FILE
	[properties]
	perl_version = '$perl_version'
	perl_ccopts = ['-I$CLANDRO_PREFIX/include', '-D_LARGEFILE_SOURCE', '-D_FILE_OFFSET_BITS=64', '-I$CLANDRO_PREFIX/lib/perl5/$perl_version/${CLANDRO_ARCH}-android/CORE']
	perl_ldopts = ['-Wl,-E', '-I$CLANDRO_PREFIX/include', '-L$CLANDRO_PREFIX/lib/perl5/$perl_version/${CLANDRO_ARCH}-android/CORE', '-lperl', '-lm', '-ldl']
	perl_archname = '${CLANDRO_ARCH}-android'
	perl_installsitearch = '$CLANDRO_PREFIX/lib/perl5/site_perl/$perl_version/${CLANDRO_ARCH}-android'
	perl_installvendorarch = ''
	perl_inc = ['$CLANDRO_PREFIX/lib/perl5/site_perl/$perl_version/${CLANDRO_ARCH}-android', '$CLANDRO_PREFIX/lib/perl5/site_perl/$perl_version', '$CLANDRO_PREFIX/lib/perl5/$perl_version/${CLANDRO_ARCH}-android', '$CLANDRO_PREFIX/lib/perl5/$perl_version']
	MESON_PERL_CROSS
}
