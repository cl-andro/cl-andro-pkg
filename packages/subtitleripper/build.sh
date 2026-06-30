CLANDRO_PKG_HOMEPAGE=https://subtitleripper.sourceforge.net/
CLANDRO_PKG_DESCRIPTION="DVD subtitle ripper for Linux"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
_VERSION=0.3-4
CLANDRO_PKG_VERSION=${_VERSION//-/.}
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://downloads.sourceforge.net/subtitleripper/subtitleripper-${_VERSION}.tgz
CLANDRO_PKG_SHA256=8af6c2ebe55361900871c731ea1098b1a03efa723cd29ee1d471435bd21f3ac4
CLANDRO_PKG_DEPENDS="libpng, netpbm, zlib"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	CPPFLAGS+=" -DHAVE_GETLINE"
	CFLAGS+=" $CPPFLAGS"
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin \
		srttool subtitle2pgm subtitle2vobsub vobsub2pgm
}
