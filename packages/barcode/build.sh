CLANDRO_PKG_HOMEPAGE=https://www.gnu.org/software/barcode/
CLANDRO_PKG_DESCRIPTION="Tool to convert text strings to printed bars"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.99
CLANDRO_PKG_REVISION=5
CLANDRO_PKG_SRCURL=http://mirrors.kernel.org/gnu/barcode/barcode-$CLANDRO_PKG_VERSION.tar.xz
CLANDRO_PKG_SHA256=e87ecf6421573e17ce35879db8328617795258650831affd025fba42f155cdc6
CLANDRO_PKG_BUILD_DEPENDS="gettext"

clandro_step_pre_configure() {
	CPPFLAGS+=" -I$CLANDRO_PREFIX/share/gettext"
	CFLAGS+=" -fcommon"
}
