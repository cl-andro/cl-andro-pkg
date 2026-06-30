CLANDRO_PKG_HOMEPAGE=https://os.ghalkes.nl/libtranscript.html
CLANDRO_PKG_DESCRIPTION="A character-set conversion library"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.3.4"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://os.ghalkes.nl/dist/libtranscript-${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=daaa09038f6f3b785b86d152014b3893910f9b9e4e430c015e41b05b34c37ea7
CLANDRO_PKG_AUTO_UPDATE=true
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
