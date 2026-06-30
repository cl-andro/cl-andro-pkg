CLANDRO_PKG_HOMEPAGE=https://www.qt.io/
CLANDRO_PKG_DESCRIPTION="Integrated Development Environment for Qt"
CLANDRO_PKG_LICENSE="GPL-3.0-only"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="19.0.1"
CLANDRO_PKG_SRCURL="https://download.qt.io/official_releases/qtcreator/${CLANDRO_PKG_VERSION%.*}/${CLANDRO_PKG_VERSION}/qt-creator-opensource-src-${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=38051c52b8673cc152e07c2c6faed0b3cd6f4f9ce39b7fbb8041396db47f831d
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="clang, glib, libandroid-execinfo, libarchive, libelf, libllvm, libsecret, opengl, python, qt6-qtbase, qt6-qtcharts, qt6-qtdeclarative, qt6-qttools, qt6-qtsvg, libyaml-cpp, zstd"
CLANDRO_PKG_BUILD_DEPENDS="libllvm-static, qt6-qtbase-cross-tools, qt6-qtcharts-cross-tools, qt6-qtdeclarative-cross-tools, qt6-qttools-cross-tools, qt6-qtsvg-cross-tools"
CLANDRO_PKG_RECOMMENDS="gdb, git, make, cmake, mlocate"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_NO_STATICSPLIT=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DCMAKE_INSTALL_LIBDIR=lib
-DCMAKE_INSTALL_INCLUDEDIR=include
-DBUILD_WITH_PCH=OFF
"

clandro_step_pre_configure() {
	clandro_setup_golang

	LDFLAGS+=" -landroid-execinfo"

	# add the directories of all .so files found in the package
	# to the library run paths of all executables in the package
	# the 'qtcreator.sh' script sets LD_LIBRARY_PATH automatically so does not
	# seem to need this, but setting these makes the 'qtcreator' binary
	# possible to launch directly without errors.
	LDFLAGS+=" -Wl,-rpath=$CLANDRO_PREFIX/lib/qtcreator"
	LDFLAGS+=" -Wl,-rpath=$CLANDRO_PREFIX/lib/qtcreator/plugins"
	LDFLAGS+=" -Wl,-rpath=$CLANDRO_PREFIX/lib/qtcreator/plugins/qmldesigner"
}
