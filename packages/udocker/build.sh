CLANDRO_PKG_HOMEPAGE=https://indigo-dc.github.io/udocker
CLANDRO_PKG_DESCRIPTION="A basic user tool to execute simple docker containers in batch or interactive systems without root privileges."
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.3.17"
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_SRCURL="https://github.com/indigo-dc/udocker/archive/refs/tags/$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=76713c1e8ea3f0f412144fda51b38a6e309d1fe29e85de8f678626d42e9e04a1
CLANDRO_PKG_DEPENDS="curl, proot, python, resolv-conf"
CLANDRO_PKG_PYTHON_CROSS_BUILD_DEPS="wheel"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--prefix=$CLANDRO_PREFIX"
