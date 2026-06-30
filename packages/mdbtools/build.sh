CLANDRO_PKG_HOMEPAGE=https://github.com/mdbtools/mdbtools
CLANDRO_PKG_DESCRIPTION="A set of programs to help you extract data from Microsoft Access files in various settings"
CLANDRO_PKG_LICENSE="GPL-2.0, LGPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.0.1"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/mdbtools/mdbtools/releases/download/v${CLANDRO_PKG_VERSION}/mdbtools-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=ff9c425a88bc20bf9318a332eec50b17e77896eef65a0e69415ccb4e396d1812
CLANDRO_PKG_DEPENDS="glib, libiconv, readline, libiodbc"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--with-iodbc=$CLANDRO_PREFIX"
