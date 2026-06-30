CLANDRO_PKG_HOMEPAGE=http://gnuplot.info/
CLANDRO_PKG_DESCRIPTION="Command-line driven graphing utility"
CLANDRO_PKG_LICENSE="custom"
CLANDRO_PKG_LICENSE_FILE="Copyright"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.0.4"
CLANDRO_PKG_SRCURL=https://downloads.sourceforge.net/project/gnuplot/gnuplot/${CLANDRO_PKG_VERSION}/gnuplot-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=458d94769625e73d5f6232500f49cbadcb2b183380d43d2266a0f9701aeb9c5b
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="glib, libandroid-support, libcairo, libgd, libiconv, libx11, pango, readline"
CLANDRO_PKG_BREAKS="gnuplot-x"
CLANDRO_PKG_REPLACES="gnuplot-x"
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS="
--disable-wxwidgets
--without-lua
--without-qt
"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-wxwidgets
--with-x
--without-lua
--with-bitmap-terminals
--without-latex
--without-qt
ac_cv_search_iconv_open=-liconv
"

clandro_step_host_build() {
	"$CLANDRO_PKG_SRCDIR/configure" \
		${CLANDRO_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS}
	make -C docs/ gnuplot.gih
}

clandro_step_post_make_install() {
	mkdir -p $CLANDRO_PREFIX/share/gnuplot/${CLANDRO_PKG_VERSION:0:3}/

	cp $CLANDRO_PKG_HOSTBUILD_DIR/docs/gnuplot.gih \
		$CLANDRO_PREFIX/share/gnuplot/${CLANDRO_PKG_VERSION:0:3}/gnuplot.gih
}
