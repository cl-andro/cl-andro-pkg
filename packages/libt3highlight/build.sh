CLANDRO_PKG_HOMEPAGE=https://os.ghalkes.nl/t3/libt3highlight.html
CLANDRO_PKG_DESCRIPTION="A library for syntax highlighting different types of text files"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.5.0
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://os.ghalkes.nl/dist/libt3highlight-${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=8216190785e52a116f9f78ec6513815745904c2aaf70d0a0a09438e08640dfbb
CLANDRO_PKG_DEPENDS="libt3config, pcre2"
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
}
