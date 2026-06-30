# Crashes with "Dungeon description not valid"
CLANDRO_PKG_HOMEPAGE=https://sourceforge.net/apps/trac/unnethack
CLANDRO_PKG_DESCRIPTION="Dungeon crawling game, fork of NetHack"
CLANDRO_PKG_LICENSE="custom"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=5.1.0
CLANDRO_PKG_SRCURL=https://downloads.sourceforge.net/project/unnethack/unnethack/${CLANDRO_PKG_VERSION}/unnethack-${CLANDRO_PKG_VERSION}-20131208.tar.gz
CLANDRO_PKG_SHA256=d92886a02fd8f5a427d1acf628e12ee03852fdebd3af0e7d0d1279dc41c75762
# --with-owner=$USER to avoid unnethack trying to use a "games" user, --with-groups to avoid "bin" group
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--with-owner=$USER --with-group=$(groups | cut -d ' ' -f 1)"
CLANDRO_PKG_DEPENDS="gsl, ncurses"

# unnethack builds util/{makedefs,lev_comp,dgn_comp} binaries which are later used during the build.
# we first build these host tools in $CLANDRO_PKG_TMPDIR/host-build and copy them into the ordinary
# cross compile tree after configure, bumping their modification time so that they do not get rebuilt.

CFLAGS="$CFLAGS $CPPFLAGS $LDFLAGS"
export LFLAGS="$LDFLAGS"
LD="$CC"

clandro_step_pre_configure() {
	# Create a host build for the makedefs binary
	mkdir $CLANDRO_PKG_TMPDIR/host-build
	cd $CLANDRO_PKG_TMPDIR/host-build
	ORIG_CC=$CC; export CC=gcc
	ORIG_CFLAGS=$CFLAGS; export CFLAGS=""
	ORIG_CPPFLAGS=$CPPFLAGS; export CPPFLAGS=""
	ORIG_CXXFLAGS=$CXXFLAGS; export CXXFLAGS=""
	ORIG_LDFLAGS=$LDFLAGS; export LDFLAGS=""
	ORIG_LFLAGS=$LFLAGS; export LFLAGS=""
	$CLANDRO_PKG_SRCDIR/configure --with-owner=$USER
	make
	make spec_levs
	make dungeon
	set +e
	make dlb
	set -e
	export CC=$ORIG_CC
	export CFLAGS=$ORIG_CFLAGS
	export CPPFLAGS=$ORIG_CPPFLAGS
	export CXXFLAGS=$ORIG_CXXFLAGS
	export LDFLAGS=$ORIG_LDFLAGS
	export LFLAGS=$ORIG_LFLAGS
}

clandro_step_post_configure() {
	# Use the host built makedefs
	cp $CLANDRO_PKG_TMPDIR/host-build/util/makedefs $CLANDRO_PKG_BUILDDIR/util/makedefs
	cp $CLANDRO_PKG_TMPDIR/host-build/util/lev_comp $CLANDRO_PKG_BUILDDIR/util/lev_comp
	cp $CLANDRO_PKG_TMPDIR/host-build/util/dgn_comp $CLANDRO_PKG_BUILDDIR/util/dgn_comp
	cp $CLANDRO_PKG_TMPDIR/host-build/util/dlb $CLANDRO_PKG_BUILDDIR/util/dlb
	# Update timestamp so the binary does not get rebuilt
	touch -d "next hour" $CLANDRO_PKG_BUILDDIR/util/makedefs $CLANDRO_PKG_BUILDDIR/util/lev_comp $CLANDRO_PKG_BUILDDIR/util/dgn_comp $CLANDRO_PKG_BUILDDIR/util/dlb
}

clandro_step_post_make_install() {
	# Add directory which must exist:
	mkdir -p $CLANDRO_PREFIX/var/unnethack/level
	echo "This directory stores locks" > $CLANDRO_PREFIX/var/unnethack/level/README
}
