# x11-packages
CLANDRO_PKG_HOMEPAGE=https://github.com/Enselic/recordmydesktop
CLANDRO_PKG_DESCRIPTION="GTK frontend to recordMyDesktop"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.4.0
CLANDRO_PKG_SRCURL=https://github.com/Enselic/recordmydesktop/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=69602d32c1be82cd92083152c7c44c0206ca0d6419d76a6144ffcfe07b157a72
CLANDRO_PKG_DEPENDS="gtk3, pygobject, python, recordmydesktop"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_RM_AFTER_INSTALL="lib/locale"

_PYTHON_VERSION=$(. $CLANDRO_SCRIPTDIR/packages/python/build.sh; echo $_MAJOR_VERSION)

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
am_cv_python_pythondir=$CLANDRO_PREFIX/lib/python${_PYTHON_VERSION}/site-packages
"

clandro_step_post_get_source() {
	CLANDRO_PKG_SRCDIR+="/gtk-recordmydesktop"
}

clandro_step_pre_configure() {
	autoreconf -fi

	clandro_setup_python_crossenv
	pushd $CLANDRO_PYTHON_CROSSENV_SRCDIR
	_CROSSENV_PREFIX=$CLANDRO_PKG_BUILDDIR/python-crossenv-prefix
	python${_PYTHON_VERSION} -m crossenv \
		$CLANDRO_PREFIX/bin/python${_PYTHON_VERSION} \
		${_CROSSENV_PREFIX}
	popd
	. ${_CROSSENV_PREFIX}/bin/activate
}
