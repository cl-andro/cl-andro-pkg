CLANDRO_PKG_HOMEPAGE=https://www.gnu.org/software/diffutils/
CLANDRO_PKG_DESCRIPTION="Programs (cmp, diff, diff3 and sdiff) related to finding differences between files"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="Joshua Kahn <tom@termux.dev> & @clandro"
CLANDRO_PKG_VERSION="3.12"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://mirrors.kernel.org/gnu/diffutils/diffutils-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=7c8b7f9fc8609141fdea9cece85249d308624391ff61dedaf528fcb337727dfd
CLANDRO_PKG_DEPENDS="libiconv"
CLANDRO_PKG_ESSENTIAL=true

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
gl_cv_func_strcasecmp_works=yes
ac_cv_path_PR_PROGRAM=${CLANDRO_PREFIX}/bin/pr
"
