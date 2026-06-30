CLANDRO_PKG_HOMEPAGE=https://pandas.pydata.org/
CLANDRO_PKG_DESCRIPTION="Powerful Python data analysis toolkit"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.5.3
CLANDRO_PKG_SRCURL=https://github.com/pandas-dev/pandas/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=d8abf9c2bf33cac75b28f32c174c29778414eb249e5e2ccb69b1079b97a8fc66
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++, python, python-numpy, python-pip"
CLANDRO_PKG_PYTHON_COMMON_BUILD_DEPS="Cython, numpy, wheel"
CLANDRO_PKG_PYTHON_TARGET_DEPS="python-dateutil, pytz"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	LDFLAGS+=" -lm"
}

clandro_step_make_install() {
	pip install --no-deps --no-build-isolation . --prefix $CLANDRO_PREFIX
}
