CLANDRO_PKG_HOMEPAGE=http://eigen.tuxfamily.org
CLANDRO_PKG_DESCRIPTION="Eigen is a C++ template library for linear algebra: matrices, vectors, numerical solvers, and related algorithms"
CLANDRO_PKG_LICENSE="MPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=3.4.0
CLANDRO_PKG_SHA256=8586084f71f9bde545ee7fa6d00288b264a2b7ac3607b974e54d13e7162c1c72
CLANDRO_PKG_SRCURL=https://gitlab.com/libeigen/eigen/-/archive/${CLANDRO_PKG_VERSION}/eigen-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_BREAKS="eigen-dev"
CLANDRO_PKG_REPLACES="eigen-dev"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="-DCMAKE_BUILD_TYPE=Release"
CLANDRO_PKG_GROUPS="science"
