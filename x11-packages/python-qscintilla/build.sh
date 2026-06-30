CLANDRO_PKG_HOMEPAGE=https://www.riverbankcomputing.com/software/qscintilla/
CLANDRO_PKG_DESCRIPTION="Python bindings for QScintilla"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
# Align the version with `qscintilla` package.
CLANDRO_PKG_VERSION=2.14.1
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_SRCURL=https://www.riverbankcomputing.com/static/Downloads/QScintilla/${CLANDRO_PKG_VERSION}/QScintilla_src-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=dfe13c6acc9d85dfcba76ccc8061e71a223957a6c02f3c343b30a9d43a4cdd4d
CLANDRO_PKG_DEPENDS="libc++, pyqt5, python, python-pip, qscintilla (>= ${CLANDRO_PKG_VERSION}), qt5-qtbase"
CLANDRO_PKG_BUILD_DEPENDS="qt5-qtbase-cross-tools"
CLANDRO_PKG_PYTHON_COMMON_BUILD_DEPS="wheel, PyQt-builder"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_MAKE_ARGS="
--verbose
--scripts-dir=$CLANDRO_PREFIX/bin
--qmake=$CLANDRO_PREFIX/opt/qt/cross/bin/qmake
--target-dir=$CLANDRO_PYTHON_HOME/site-packages
"

clandro_step_pre_configure() {
	CLANDRO_PKG_SRCDIR+="/Python"
	CLANDRO_PKG_BUILDDIR="$CLANDRO_PKG_SRCDIR"
	cd "$CLANDRO_PKG_SRCDIR"

	ln -sf pyproject{-qt5,}.toml

	local h="$CLANDRO_PREFIX/include/Qsci/qsciglobal.h"
	local _CFGTEST_QSCI
	_CFGTEST_QSCI=$(( $(sed -En 's/^#define\s+QSCINTILLA_VERSION\s+([^\s]+).*/\1/p' "${h}") ))
	_CFGTEST_QSCI+=" "
	_CFGTEST_QSCI+=$(sed -En 's/^#define\s+QSCINTILLA_VERSION_STR\s+"([^"]+)".*/\1/p' "${h}")

	local _cxx=$(basename $CXX)
	local _bindir=$CLANDRO_PKG_BUILDDIR/_wrapper/bin
	mkdir -p ${_bindir}
	sed -e 's|@CXX@|'"$(command -v $CXX)"'|g' \
		-e 's|@CFGTEST_QSCI@|'"${_CFGTEST_QSCI}"'|g' \
		-e 's|@CLANDRO_PREFIX@|'"${CLANDRO_PREFIX}"'|g' \
		-e 's|@PYTHON_VERSION@|'"${CLANDRO_PYTHON_VERSION}"'|g' \
		$CLANDRO_PKG_BUILDER_DIR/cxx-wrapper > ${_bindir}/${_cxx}
	chmod 0700 ${_bindir}/${_cxx}
	export PATH=${_bindir}:$PATH
}

clandro_step_make() {
	python ${CLANDRO_PYTHON_CROSSENV_PREFIX}/build/bin/sip-build \
		--jobs ${CLANDRO_PKG_MAKE_PROCESSES} \
		${CLANDRO_PKG_EXTRA_MAKE_ARGS}
}

clandro_step_make_install() {
	make -C build install
}
