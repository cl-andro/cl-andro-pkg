CLANDRO_PKG_HOMEPAGE=https://www.perl.org/
CLANDRO_PKG_DESCRIPTION="Capable, feature-rich programming language"
CLANDRO_PKG_LICENSE="Artistic-License-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
# Packages which should be rebuilt after version change:
# - exiftool
# - irssi
# - libapt-pkg-perl
# - libregexp-assemble-perl
# - psutils (currently a disabled package)
# - subversion
# - vim
# - vim-gtk
CLANDRO_PKG_VERSION=(5.42.0
                    1.6.4)
CLANDRO_PKG_SHA256=(73cf6cc1ea2b2b1c110a18c14bbbc73a362073003893ffcedc26d22ebdbdd0c3
                   b176522bceb1fc3533eb85e4435e5ab06f7473633979122a8f5b18a2b4fc865a)
CLANDRO_PKG_SRCURL=("https://www.cpan.org/src/5.0/perl-${CLANDRO_PKG_VERSION[0]}.tar.xz"
                   "https://github.com/arsv/perl-cross/archive/refs/tags/${CLANDRO_PKG_VERSION[1]}.tar.gz")
CLANDRO_PKG_DEPENDS="libandroid-utimes"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_MAKE_PROCESSES=1
CLANDRO_PKG_RM_AFTER_INSTALL="bin/perl${CLANDRO_PKG_VERSION}"
CLANDRO_PKG_ON_DEVICE_BUILD_NOT_SUPPORTED=true

clandro_step_post_get_source() {
	# This port uses perl-cross: http://arsv.github.io/perl-cross/
	cp -rf perl-cross-"${CLANDRO_PKG_VERSION[1]}"/* .

	# Remove old installation to force fresh:
	rm -rf "$CLANDRO_PREFIX/lib/perl5"
	rm -f "$CLANDRO_PREFIX/lib/libperl.so"
	rm -f "$CLANDRO_PREFIX/include/perl"

	# apply perl-cross patches to this perl version if necessary
	#local perl_cross_version="5.40.2"
	#cp -r "cnf/diffs/perl5-${perl_cross_version}/" cnf/diffs/perl5-${CLANDRO_PKG_VERSION[0]}/
}

clandro_step_configure() {
	export PATH="$PATH:$CLANDRO_STANDALONE_TOOLCHAIN/bin"

	(
		ORIG_AR="$AR"; unset AR
		ORIG_AS="$AS"; unset AS
		ORIG_CC="$CC"; unset CC
		ORIG_CXX="$CXX"; unset CXX
		ORIG_CFLAGS="$CFLAGS"; unset CFLAGS
		ORIG_CPPFLAGS="$CPPFLAGS"; unset CPPFLAGS
		ORIG_CXXFLAGS="$CXXFLAGS"; unset CXXFLAGS
		ORIG_LDFLAGS="$LDFLAGS"; unset LDFLAGS
		ORIG_RANLIB="$RANLIB"; unset RANLIB
		ORIG_LD="$LD"; unset LD

		export LDFLAGS="-Wl,-rpath=$CLANDRO_PREFIX/lib -L$CLANDRO_PREFIX/lib -landroid-utimes -lm"
		export CFLAGS="-D_BSD_SOURCE=1"

		cd "$CLANDRO_PKG_BUILDDIR"
		"$CLANDRO_PKG_SRCDIR/configure" \
			--target="$CLANDRO_HOST_PLATFORM" \
			--with-cc="$ORIG_CC" \
			--with-ranlib="$ORIG_RANLIB" \
			-Dosname=android \
			-Dsysroot="$CLANDRO_STANDALONE_TOOLCHAIN/sysroot" \
			-Dprefix="$CLANDRO_PREFIX" \
			-Dsh="$CLANDRO_PREFIX/bin/sh" \
			-Dld="$ORIG_CC -Wl,-rpath=$CLANDRO_PREFIX/lib -Wl,--enable-new-dtags" \
			-Dar="$ORIG_AR" \
			-Duseshrplib \
			-Duseithreads \
			-Dusemultiplicity \
			-Doptimize="-O2" \
			--with-libs="-lm -L$CLANDRO_PREFIX/lib -landroid-utimes"
	)
}

clandro_step_post_make_install() {
	# Replace hardlinks with symlinks:
	cd "$CLANDRO_PREFIX/share/man/man1"
	rm perlbug.1
	ln -s perlthanks.1 perlbug.1
	cd "$CLANDRO_PREFIX/bin"
	rm perlbug
	ln -s perlthanks perlbug

	cd "$CLANDRO_PREFIX/lib"
	ln -f -s "perl5/${CLANDRO_PKG_VERSION}/${CLANDRO_ARCH}-android/CORE/libperl.so" libperl.so

	cd "$CLANDRO_PREFIX/include"
	ln -f -s ../lib/perl5/"${CLANDRO_PKG_VERSION}/${CLANDRO_ARCH}"-android/CORE perl
	cd ../lib/perl5/"${CLANDRO_PKG_VERSION}/${CLANDRO_ARCH}"-android/
	chmod +w Config_heavy.pl
	sed 's',"--sysroot=$CLANDRO_STANDALONE_TOOLCHAIN"/sysroot,"-I${CLANDRO_PREFIX}/include",'g' Config_heavy.pl > Config_heavy.pl.new
	sed 's',"$CLANDRO_STANDALONE_TOOLCHAIN"/sysroot,"-I${CLANDRO_PREFIX%%/usr}",'g' Config_heavy.pl.new > Config_heavy.pl
	rm Config_heavy.pl.new
}
