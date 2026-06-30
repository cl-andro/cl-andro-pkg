CLANDRO_PKG_HOMEPAGE=https://sleuthkit.org/
CLANDRO_PKG_DESCRIPTION="The Sleuth Kit® (TSK) is a library for digital forensics tools. "
CLANDRO_PKG_LICENSE="custom"
CLANDRO_PKG_LICENSE_FILE="licenses/README.md, licenses/GNUv2-COPYING, licenses/GNUv3-COPYING, licenses/IBM-LICENSE, licenses/Apache-LICENSE-2.0.txt, licenses/cpl1.0.txt, licenses/bsd.txt, licenses/mit.txt"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.15.0"
CLANDRO_PKG_SRCURL=https://github.com/sleuthkit/sleuthkit/archive/refs/tags/sleuthkit-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=4888ef54f9b404853712945218b3168696569db9167d7e01ec76e44b6c05c71c
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
CLANDRO_PKG_DEPENDS="libc++, libsqlite, zlib"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--disable-java"

clandro_step_pre_configure() {
	./bootstrap
}
