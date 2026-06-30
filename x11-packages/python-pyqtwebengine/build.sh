CLANDRO_PKG_HOMEPAGE=https://www.riverbankcomputing.com/software/pyqtwebengine/
CLANDRO_PKG_DESCRIPTION="Python Bindings for the Qt WebEngine Framework"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="5.15.7"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://files.pythonhosted.org/packages/source/P/PyQtWebEngine/PyQtWebEngine-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=f121ac6e4a2f96ac289619bcfc37f64e68362f24a346553f5d6c42efa4228a4d
CLANDRO_PKG_DEPENDS="libc++, pyqt5, python, python-pip, qt5-qtbase, qt5-qtwebengine"
CLANDRO_PKG_BUILD_DEPENDS="qt5-qtbase-cross-tools"
CLANDRO_PKG_PYTHON_COMMON_BUILD_DEPS="wheel, PyQt-builder"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_MAKE_ARGS="
--verbose
--scripts-dir=$CLANDRO_PREFIX/bin
--qmake=$CLANDRO_PREFIX/opt/qt/cross/bin/qmake
"

clandro_step_pre_configure() {
	local _cxx=$(basename $CXX)
	local _bindir=$CLANDRO_PKG_BUILDDIR/_wrapper/bin
	mkdir -p ${_bindir}
	sed -e 's|@CXX@|'"$(command -v $CXX)"'|g' \
		-e 's|@CLANDRO_PREFIX@|'"${CLANDRO_PREFIX}"'|g' \
		-e 's|@PYTHON_VERSION@|'"${CLANDRO_PYTHON_VERSION}"'|g' \
		$CLANDRO_PKG_BUILDER_DIR/cxx-wrapper > ${_bindir}/${_cxx}
	chmod 0700 ${_bindir}/${_cxx}
	export PATH=${_bindir}:$PATH

	CLANDRO_PKG_EXTRA_MAKE_ARGS+=" --target-dir=$CLANDRO_PYTHON_HOME/site-packages"
}

clandro_step_make() {
	python ${CLANDRO_PYTHON_CROSSENV_PREFIX}/build/bin/sip-build \
		--jobs ${CLANDRO_PKG_MAKE_PROCESSES} \
		${CLANDRO_PKG_EXTRA_MAKE_ARGS}
}

clandro_step_make_install() {
	make -C build install
}
