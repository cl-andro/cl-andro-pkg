CLANDRO_PKG_HOMEPAGE=https://github.com/python-greenlet/greenlet
CLANDRO_PKG_DESCRIPTION="Lightweight coroutines for in-process concurrent programming"
# Licenses: MIT, PSF-2.0
CLANDRO_PKG_LICENSE="custom"
CLANDRO_PKG_LICENSE_FILE="LICENSE, LICENSE.PSF"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.5.0"
CLANDRO_PKG_SRCURL=https://github.com/python-greenlet/greenlet/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=777c6671610b06ad8549224eeb7e913662d98dfa5cd4a804fbb6b2c2a839be73
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_DEPENDS="libc++, python, python-pip"
CLANDRO_PKG_PYTHON_COMMON_BUILD_DEPS="wheel"
CLANDRO_PKG_BUILD_IN_SRC=true
