CLANDRO_PKG_HOMEPAGE=https://www.riverbankcomputing.com/software/pyqt/
CLANDRO_PKG_DESCRIPTION="Comprehensive Python Bindings for Qt v5"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="5.15.11"
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_SRCURL=https://files.pythonhosted.org/packages/source/P/PyQt5/PyQt5-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=fda45743ebb4a27b4b1a51c6d8ef455c4c1b5d610c90d2934c7802b5c1557c52
CLANDRO_PKG_DEPENDS="libc++, python, qt5-qtbase, qt5-qtdeclarative, qt5-qtlocation, qt5-qtmultimedia, qt5-qtsensors, qt5-qtsvg, qt5-qttools, qt5-qtwebchannel, qt5-qtwebsockets, qt5-qtx11extras, qt5-qtxmlpatterns, python-pip"
CLANDRO_PKG_BUILD_DEPENDS="qt5-qtbase-cross-tools, qt5-qtdeclarative-cross-tools, qt5-qttools-cross-tools"
# sip version 6.13 has this error:
# AttributeError: 'ScopedName' object has no attribute 'types'
# if that error disappears in the future, sip can be unpinned
CLANDRO_PKG_PYTHON_COMMON_BUILD_DEPS="wheel, 'sip>=6.6.2,<6.13.0', 'PyQt-builder>=1.14.1,<2'"
CLANDRO_PKG_PYTHON_TARGET_DEPS="'PyQt5-sip>=12.13,<13'"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_MAKE_ARGS="
--verbose
--scripts-dir=$CLANDRO_PREFIX/bin
--confirm-license
--qmake=$CLANDRO_PREFIX/opt/qt/cross/bin/qmake
"

# ```
# /home/builder/.termux-build/pyqt5/src/sip/QtQuick/qsggeometry.sip:136:30:
# error: use of undeclared identifier 'GL_BYTE'
#			 case GL_BYTE:
#			      ^
# /home/builder/.termux-build/pyqt5/src/sip/QtQuick/qsggeometry.sip:148:30:
# error: use of undeclared identifier 'GL_FLOAT'
#			 case GL_FLOAT:
#			      ^
# /home/builder/.termux-build/pyqt5/src/sip/QtQuick/qsggeometry.sip:152:30:
# error: use of undeclared identifier 'GL_INT'
#			 case GL_INT:
#			      ^
# 3 errors generated.
# ```
CLANDRO_PKG_EXTRA_MAKE_ARGS+=" --disable=QtQuick"

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

	local f
	for f in pylupdate5 pyrcc5 pyuic5; do
		local t="$CLANDRO_PREFIX/bin/${f}"
		rm -f "${t}"
		sed -e 's|@CLANDRO_PREFIX@|'"${CLANDRO_PREFIX}"'|g' \
			"$CLANDRO_PKG_BUILDER_DIR/${f}.in" > "${t}"
		chmod 0700 "${t}"
	done
}
