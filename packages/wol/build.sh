CLANDRO_PKG_HOMEPAGE=https://sourceforge.net/projects/wake-on-lan/
CLANDRO_PKG_DESCRIPTION="Program implementing Wake On LAN functionality"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.7.1
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_SRCURL=https://downloads.sourceforge.net/project/wake-on-lan/wol/${CLANDRO_PKG_VERSION}/wol-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=e0086c9b9811df2bdf763ec9016dfb1bcb7dba9fa6d7858725b0929069a12622
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--mandir=$CLANDRO_PREFIX/share/man"
CLANDRO_PKG_RM_AFTER_INSTALL="info/"

clandro_step_pre_configure() {
	export ac_cv_func_mmap_fixed_mapped=yes
	export jm_cv_func_working_malloc=yes
	export ac_cv_func_alloca_works=yes
}
