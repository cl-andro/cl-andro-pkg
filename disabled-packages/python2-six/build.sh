# x11-packages
CLANDRO_PKG_HOMEPAGE=https://pypi.org/project/six/
CLANDRO_PKG_DESCRIPTION="Python 2 and 3 compatibility utilities"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.12.0
CLANDRO_PKG_REVISION=23
CLANDRO_PKG_SRCURL=https://pypi.io/packages/source/s/six/six-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=d16a0141ec1a18405cd4ce8b4613101da75da0e9a7aec5bdd4fa804d0e0eba73
CLANDRO_PKG_DEPENDS="python2"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_PLATFORM_INDEPENDENT=true

clandro_step_make() {
	return
}

clandro_step_make_install() {
	export PYTHONPATH=${CLANDRO_PREFIX}/lib/python2.7/site-packages/
	python2.7 setup.py install --prefix="${CLANDRO_PREFIX}" --force
}
