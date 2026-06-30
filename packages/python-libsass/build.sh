CLANDRO_PKG_HOMEPAGE=https://github.com/sass/libsass-python
CLANDRO_PKG_DESCRIPTION="A straightforward binding of libsass for Python"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.23.0"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://github.com/sass/libsass-python/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=4bff7819756f52f6e4592f03f205104d1ca431088d9452aed5042f89a36f9873
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libsass, python"
CLANDRO_PKG_PYTHON_COMMON_BUILD_DEPS="wheel"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	export SYSTEM_SASS=1
}
