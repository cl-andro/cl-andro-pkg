CLANDRO_PKG_HOMEPAGE=https://os.ghalkes.nl/tilde/
CLANDRO_PKG_DESCRIPTION="A text editor for the console/terminal"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.1.3
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://os.ghalkes.nl/dist/tilde-${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=6b86ffaa5c632c9055f74fca713c5bf8420ee60718850dc16a95abe49fa2641a
CLANDRO_PKG_DEPENDS="libc++, libt3config, libt3highlight, libt3widget, libtranscript, libunistring"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--without-gettext"

clandro_step_post_get_source() {
	sed -i 's/ -s / /g' Makefile.in
	rm -f src/tilde
	find src -type f | xargs -n 1 sed -i 's:tilde/::g'
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
}
