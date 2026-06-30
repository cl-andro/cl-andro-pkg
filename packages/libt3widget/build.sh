CLANDRO_PKG_HOMEPAGE=https://os.ghalkes.nl/t3/libt3widget.html
CLANDRO_PKG_DESCRIPTION="A library of widgets and dialogs to facilitate construction of easy-to-use terminal-based programs"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.2.2
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=https://os.ghalkes.nl/dist/libt3widget-${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=9eb7e1d0ccdfc917f18ba1785a2edb4faa6b0af8b460653d962abf91136ddf1c
CLANDRO_PKG_DEPENDS="libc++, libt3config, libt3key, libt3window, libtranscript, libunistring, pcre2"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--without-gettext
--without-x11
--without-gpm
"

clandro_step_post_get_source() {
	sed -i 's/ -s / /g' Makefile.in
}

clandro_step_pre_configure() {
	local libtooldir=$CLANDRO_PKG_TMPDIR/_libtool
	mkdir -p $libtooldir
	pushd $libtooldir
	cat > configure.ac <<-EOF
		AC_INIT
		LT_INIT
		AC_PROG_CXX
		AC_OUTPUT
	EOF
	touch install-sh
	cp "$CLANDRO_SCRIPTDIR/scripts/config.sub" ./
	cp "$CLANDRO_SCRIPTDIR/scripts/config.guess" ./
	autoreconf -fi
	./configure --host=$CLANDRO_HOST_PLATFORM
	popd
	export LIBTOOL=$libtooldir/libtool

	CXXFLAGS+=" $CPPFLAGS"
	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}
