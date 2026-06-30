# x11-packages
CLANDRO_PKG_HOMEPAGE=https://github.com/python-xlib/python-xlib
CLANDRO_PKG_DESCRIPTION="A fully functional X client library for Python programs"
CLANDRO_PKG_LICENSE="LGPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.24
CLANDRO_PKG_REVISION=23
CLANDRO_PKG_SRCURL=https://github.com/python-xlib/python-xlib/releases/download/${CLANDRO_PKG_VERSION}/python-xlib-${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=7ecf32b18b59be2c06848410bae848792ead119ac31084f487730581b3ab598c
CLANDRO_PKG_DEPENDS="libx11, python2, python2-six"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_PLATFORM_INDEPENDENT=true

clandro_step_make() {
	return
}

clandro_step_make_install() {
	## python2 setuptools needed
	export PYTHONPATH=${CLANDRO_PREFIX}/lib/python2.7/site-packages/
	python2.7 setup.py install --root="/" --prefix="${CLANDRO_PREFIX}" --force
}
