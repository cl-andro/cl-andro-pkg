CLANDRO_PKG_HOMEPAGE=https://timidity.sourceforge.net/
CLANDRO_PKG_DESCRIPTION="MIDI-to-WAVE converter and player"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.15.0
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://downloads.sourceforge.net/timidity/TiMidity++-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=9eaf4fadb0e19eb8e35cd4ac16142d604c589e43d0e8798237333697e6381d39
CLANDRO_PKG_CONFFILES="
share/timidity/timidity.cfg
"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--enable-dynamic
--enable-vt100
--enable-server
--enable-network
--with-module-dir=$CLANDRO_PREFIX/share/timidity
lib_cv_va_copy=yes
lib_cv___va_copy=yes
lib_cv_va_val_copy=yes
ac_cv_header_sys_time_h=yes
"

clandro_step_pre_configure() {
	autoreconf -fi

	CPPFLAGS+=" -DSTDC_HEADERS"
}

clandro_step_post_configure() {
	mkdir -p _build
	$CC_FOR_BUILD $CLANDRO_PKG_SRCDIR/timidity/calcnewt.c \
		-o _build/calcnewt -lm
	export PATH="$(pwd)/_build:$PATH"

	ln -sf $CLANDRO_PKG_SRCDIR/timidity/resample.c timidity/
}

clandro_step_post_make_install() {
	sed "s:@CLANDRO_PREFIX@:$CLANDRO_PREFIX:g" \
		$CLANDRO_PKG_BUILDER_DIR/timidity.cfg > timidity.cfg
	install -Dm600 -t $CLANDRO_PREFIX/share/timidity timidity.cfg
}
