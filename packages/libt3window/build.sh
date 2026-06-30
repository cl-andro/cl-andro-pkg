CLANDRO_PKG_HOMEPAGE=https://os.ghalkes.nl/t3/libt3window.html
CLANDRO_PKG_DESCRIPTION="A library providing a windowing abstraction on terminals"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.4.2"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://os.ghalkes.nl/dist/libt3window-${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=d5d3fbbed3f51fb5349e29f5bc98a3a7239f88aed18ecf97d21fb8b1a49f2012
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libtranscript, libunistring, ncurses"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--without-gettext"

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
		AC_OUTPUT
	EOF
	touch install-sh
	cp "$CLANDRO_SCRIPTDIR/scripts/config.sub" ./
	cp "$CLANDRO_SCRIPTDIR/scripts/config.guess" ./
	autoreconf -fi
	./configure --host=$CLANDRO_HOST_PLATFORM
	popd
	export LIBTOOL=$libtooldir/libtool

	CFLAGS+=" $CPPFLAGS"
}
