CLANDRO_PKG_HOMEPAGE=https://git.gavinhoward.com/gavin/bc
CLANDRO_PKG_DESCRIPTION="Unix dc and POSIX bc with GNU and BSD extensions"
CLANDRO_PKG_LICENSE="BSD 2-Clause"
CLANDRO_PKG_MAINTAINER="Gavin D. Howard <gavin@gavinhoward.com>"
CLANDRO_PKG_VERSION="7.0.3"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/gavinhoward/bc/releases/download/${CLANDRO_PKG_VERSION}/bc-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=6e59d1154d167f8073a56de58a5476cc6213a7672abdf4197b5cc9599d56cd43
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="readline"

clandro_step_configure() {
	cd $CLANDRO_PKG_BUILDDIR
	# Without NLS_PATH set like this, bc will complain that the
	# locale files will not be in the right place.
	#
	# GEN_HOST=0 prevents the need for a host compiler.
	#
	# The --predefined-build-type makes bc and dc act like the GNU
	# bc and dc by default, although users can change that at
	# runtime.
	NLS_PATH=$CLANDRO_PREFIX/share/locale/%L/%N GEN_HOST=0 EXECSUFFIX=-gh \
		$CLANDRO_PKG_SRCDIR/configure.sh \
		--predefined-build-type=GNU --enable-readline \
		--disable-nls --prefix=$CLANDRO_PREFIX
}

clandro_step_make_install() {
	install -Dm700 -T bin/bc $CLANDRO_PREFIX/bin/bc-gh
	ln -sf ./bc-gh $CLANDRO_PREFIX/bin/dc-gh
	chmod 700 $CLANDRO_PREFIX/bin/dc-gh
	install -Dm600 manuals/bc.1 $CLANDRO_PREFIX/share/man/man1/bc-gh.1
	install -Dm600 manuals/dc.1 $CLANDRO_PREFIX/share/man/man1/dc-gh.1
}
