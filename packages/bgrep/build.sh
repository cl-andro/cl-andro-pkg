CLANDRO_PKG_HOMEPAGE=https://debugmo.de/2009/04/bgrep-a-binary-grep/
CLANDRO_PKG_DESCRIPTION="Binary string grep tool"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.0
CLANDRO_PKG_REVISION=5
CLANDRO_PKG_SRCURL=https://github.com/rsharo/bgrep/archive/refs/tags/bgrep-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=ba5ddae672e84bf2d8ce91429a4ce8a5e3a154ee7e64d1016420f7dc7481ec0a
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+"
CLANDRO_PKG_BUILD_IN_SRC=true

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
gl_cv_func_strcasecmp_works=yes
"

clandro_step_pre_configure() {
	./bootstrap
}
