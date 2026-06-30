CLANDRO_PKG_HOMEPAGE=https://github.com/petervanderdoes/gitflow/
CLANDRO_PKG_DESCRIPTION="Extend git with Vincent Driessen's branching model. The AVH Edition adds more functionality."
CLANDRO_PKG_LICENSE="LGPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.12.3
CLANDRO_PKG_REVISION=9
CLANDRO_PKG_SRCURL=https://github.com/petervanderdoes/gitflow/archive/refs/tags/$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=54e9fd81aa1aa8215c865503dc6377da205653c784d6c97baad3dafd20728e06
CLANDRO_PKG_DEPENDS="dash, git"
CLANDRO_PKG_EXTRA_MAKE_ARGS="prefix=$CLANDRO_PREFIX"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_BUILD_IN_SRC=true
