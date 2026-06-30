CLANDRO_PKG_HOMEPAGE=https://www.tug.org/texlive/
CLANDRO_PKG_DESCRIPTION="TeX Live is a distribution of the TeX typesetting system. This package contains architecture dependent binaries."
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="Henrik Grimler @Grimler91"
CLANDRO_PKG_VERSION="1:2026.0"
CLANDRO_PKG_SRCURL="https://github.com/TeX-Live/texlive-source/archive/refs/heads/tags/texlive-${CLANDRO_PKG_VERSION:2}.tar.gz"
CLANDRO_PKG_SHA256=f92e1be0fe4b3ad4e596f8443c5e4e7315ecf0554c2fc153d7af52f854865e24
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_DEPENDS="freetype, harfbuzz, harfbuzz-icu, libandroid-complex-math, libc++, libcairo, libgd, libgmp, libgraphite, libiconv, libicu, lua52, libmpfr, libpaper, libpixman, libpng, teckit, zlib"
# libpcre, glib, fontconfig are dependencies of libcairo. pkg-config gives an error if they are missing
# libuuid, libxml2 are needed by fontconfig
CLANDRO_PKG_BUILD_DEPENDS="icu-devtools, pcre, glib, fontconfig, libuuid, libxml2"
CLANDRO_PKG_BREAKS="texlive (<< 20180414), texlive-bin-dev"
CLANDRO_PKG_REPLACES="texlive (<< 20170524-3), texlive-bin-dev"
CLANDRO_PKG_RECOMMENDS="texlive-installer"
CLANDRO_PKG_HOSTBUILD=true

TL_ROOT=$CLANDRO_PREFIX/share/texlive/${CLANDRO_PKG_VERSION:2:6}
TL_BINDIR=$CLANDRO_PREFIX/bin/texlive

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
RANLIB=ranlib
--bindir=$TL_BINDIR
--build=$CLANDRO_BUILD_TUPLE
--datarootdir=$TL_ROOT
--disable-dialog
--disable-gregorio
--disable-luajittex
--disable-makejvf
--disable-mendexk
--disable-mflua
--disable-mfluajit
--disable-multiplatform
--disable-musixtnt
--disable-native-texlive-build
--disable-pmx
--disable-ps2pk
--disable-psutils
--disable-seetexk
--disable-t1utils
--disable-ttfdump
--disable-xz
--enable-dvisvgm
--enable-luatex
--enable-makeindexk
--infodir=$CLANDRO_PREFIX/share/info
--mandir=$CLANDRO_PREFIX/share/man
--with-system-cairo
--with-system-gd
--with-system-gmp
--with-system-graphite2
--with-system-harfbuzz
--with-system-icu
--with-system-libpaper
--with-system-lua
--with-system-mpfr
--with-system-teckit
--with-system-zlib
--without-texi2html
--without-texinfo
--without-x
--without-xdvipdfmx
--with-banner-add=/Termux"

# These files are provided by texlive:
CLANDRO_PKG_RM_AFTER_INSTALL="
bin/a2ping
bin/tlmgr
bin/man
share/texlive/texmf-dist/web2c/mktex.opt
share/texlive/texmf-dist/web2c/mktexdir.opt
share/texlive/texmf-dist/web2c/mktexnam.opt
share/texlive/texmf-dist/web2c/fmtutil.cnf
share/texlive/texmf-dist/web2c/mktexdir
share/texlive/texmf-dist/web2c/mktexnam
share/texlive/texmf-dist/web2c/mktexupd
share/texlive/texmf-dist/web2c/texmf.cnf
share/texlive/texmf-dist/fonts
share/texlive/texmf-dist/doc
share/texlive/texmf-dist/dvips
share/texlive/texmf-dist/dvipdfmx
share/texlive/texmf-dist/texconfig
share/texlive/texmf-dist/bibtex
share/texlive/texmf-dist/scripts
share/texlive/texmf-dist/ttf2pk
share/texlive/texmf-dist/source
share/texlive/texmf-dist/chktex
share/texlive/texmf-dist/hbf2gf
"

clandro_step_host_build() {
	mkdir -p auxdir/auxsub
	mkdir -p texk/kpathsea
	mkdir -p texk/web2c

	cd $CLANDRO_PKG_HOSTBUILD_DIR/auxdir/auxsub
	$CLANDRO_PKG_SRCDIR/auxdir/auxsub/configure
	make

	cd $CLANDRO_PKG_HOSTBUILD_DIR/texk/kpathsea
	$CLANDRO_PKG_SRCDIR/texk/kpathsea/configure

	cd $CLANDRO_PKG_HOSTBUILD_DIR/texk/web2c
	$CLANDRO_PKG_SRCDIR/texk/web2c/configure --without-x
	make tangle
	make ctangle
	make tie
	make otangle
	make himktables
}

clandro_step_pre_configure() {
	export TANGLE=$CLANDRO_PKG_HOSTBUILD_DIR/texk/web2c/tangle
	export TANGLEBOOT=$CLANDRO_PKG_HOSTBUILD_DIR/texk/web2c/tangleboot
	export CTANGLE=$CLANDRO_PKG_HOSTBUILD_DIR/texk/web2c/ctangle
	export CTANGLEBOOT=$CLANDRO_PKG_HOSTBUILD_DIR/texk/web2c/ctangleboot
	export TIE=$CLANDRO_PKG_HOSTBUILD_DIR/texk/web2c/tie
	export OTANGLE=$CLANDRO_PKG_HOSTBUILD_DIR/texk/web2c/otangle
	export HIMKTABLES=$CLANDRO_PKG_HOSTBUILD_DIR/texk/web2c/himktables

	sed -e "s%@CLANDRO_PREFIX@%$CLANDRO_PREFIX%g" \
		-e "s%@YEAR@%${CLANDRO_PKG_VERSION:2:6}%g" \
		"$CLANDRO_PKG_BUILDER_DIR"/texk-kpathsea-texmf.cnf.diff | patch --silent -p1

	export LDFLAGS+=" -landroid-complex-math"
}
