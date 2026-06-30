CLANDRO_PKG_HOMEPAGE=https://cmake-python-distributions.readthedocs.io/
CLANDRO_PKG_DESCRIPTION="Python wrapper for CMake"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.3.2"
CLANDRO_PKG_SRCURL="https://github.com/scikit-build/cmake-python-distributions/archive/refs/tags/$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=f2f259a3c2887b05abd29e50d0e7b356a4f36b1bac1829dbb041810b8dca4f71
CLANDRO_PKG_DEPENDS="cmake, cmake-curses-gui, python, python-pip"
CLANDRO_PKG_SETUP_PYTHON=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_configure() {
	clandro_setup_cmake
	# prevent any downloading or compiling of CMake source code,
	# but allow the normal installation of all other files
	mkdir -p empty
	echo 'cmake_minimum_required(VERSION 4.0)' > CMakeLists.txt
	echo 'install(DIRECTORY empty DESTINATION "${CMAKE_INSTALL_PREFIX}")' >> CMakeLists.txt
}
