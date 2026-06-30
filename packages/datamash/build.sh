CLANDRO_PKG_HOMEPAGE=https://www.gnu.org/software/datamash/
CLANDRO_PKG_DESCRIPTION="Program performing numeric, textual and statistical operations"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.9"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://mirrors.kernel.org/gnu/datamash/datamash-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=f382ebda03650dd679161f758f9c0a6cc9293213438d4a77a8eda325aacb87d2
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
gl_cv_func_strcasecmp_works=yes
"
