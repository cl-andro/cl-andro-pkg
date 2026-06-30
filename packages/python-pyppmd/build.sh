CLANDRO_PKG_HOMEPAGE=https://github.com/miurahr/pyppmd
CLANDRO_PKG_DESCRIPTION="PPM compression/decompression library"
CLANDRO_PKG_LICENSE="LGPL-2.1-only"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.3.1"
CLANDRO_PKG_SRCURL="https://github.com/miurahr/pyppmd/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=ca5328cfff8be532fe834f1844c281b503f3b069e6ccb6232971eaf82474dbd3
CLANDRO_PKG_DEPENDS="python, python-pip"
CLANDRO_PKG_PYTHON_COMMON_BUILD_DEPS="build, installer"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE=newest-tag

clandro_step_pre_configure() {
	rm CMakeLists.txt
}
