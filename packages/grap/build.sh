CLANDRO_PKG_HOMEPAGE=https://www.lunabase.org/~faber/Vault/software/grap/
CLANDRO_PKG_DESCRIPTION="Language for typesetting graphs"
CLANDRO_PKG_LICENSE="BSD 2-Clause"
CLANDRO_LICENSE_FILE="COPYRIGHT"
CLANDRO_PKG_MAINTAINER="@xingguangcuican6666 <xingguangcuican666@foxmail.com>"
CLANDRO_PKG_VERSION="1.49"
CLANDRO_PKG_SRCURL="https://www.lunabase.org/~faber/Vault/software/grap/grap-${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=f0bc7f09641a5ec42f019da64b0b2420d95c223b91b3778ae73cb68acfdf4e23
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_RM_AFTER_INSTALL="
share/doc/grap/CHANGES
share/doc/grap/COPYRIGHT
share/doc/grap/README
share/doc/grap/grap.man
"

clandro_step_pre_configure() {
	autoreconf -fi
}
