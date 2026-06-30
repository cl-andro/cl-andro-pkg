CLANDRO_PKG_HOMEPAGE=https://x3270.bgp.nu/
CLANDRO_PKG_DESCRIPTION="A family of IBM 3270 terminal emulators and related tools"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_LICENSE_FILE="include/copyright.h"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=4.1ga11
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://prdownloads.sourceforge.net/x3270/suite3270-${CLANDRO_PKG_VERSION}-src.tgz
CLANDRO_PKG_SHA256=c36d12fcf211cce48c7488b06d806b0194c71331abdce6da90953099acb1b0bf
CLANDRO_PKG_DEPENDS="less, libexpat, libiconv, ncurses"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-windows
--disable-x3270
--disable-tcl3270
ac_cv_path_LESSPATH=$CLANDRO_PREFIX/bin/less
"

clandro_step_pre_configure() {
	CPPFLAGS+=" -DNCURSES_WIDECHAR"

	find $CLANDRO_PKG_SRCDIR -name '*.c' | xargs -n 1 sed -i \
		-e 's:"\(/bin/sh"\):"'$CLANDRO_PREFIX'\1:g' \
		-e 's:"\(/tmp\):"'$CLANDRO_PREFIX'\1:g'
}

clandro_step_post_configure() {
	local bin=$CLANDRO_PKG_BUILDDIR/_prefix/bin
	mkdir -p $bin
	pushd $CLANDRO_PKG_SRCDIR/Common
	$CC_FOR_BUILD mkicon.c -o mkicon
	cp mkicon $bin/
	pushd c3270
	$CC_FOR_BUILD mkkeypad.c -o mkkeypad
	cp mkkeypad $bin/
	popd
	popd
	PATH=$bin:$PATH
}
