CLANDRO_PKG_HOMEPAGE=https://git.kernel.org/pub/scm/utils/dtc/dtc
CLANDRO_PKG_DESCRIPTION="Device Tree Compiler"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.7.2"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://git.kernel.org/pub/scm/utils/dtc/dtc.git/snapshot/dtc-$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=8f1486962f093f28a2f79f01c1fd82f144ef640ceabe555536d43362212ceb7c
CLANDRO_PKG_BREAKS="dtc-dev, qemu-common (<< 1:8.2.5-2), qemu-system-x86-64 (<< 1:8.2.5-3)"
CLANDRO_PKG_REPLACES="dtc-dev, qemu-common (<< 1:8.2.5-2), qemu-system-x86-64 (<< 1:8.2.5-3)"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dtests=false
-Dtools=true
"
