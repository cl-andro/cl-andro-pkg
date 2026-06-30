# Contributor: @rafaelmartins
CLANDRO_PKG_HOMEPAGE=https://blogc.rgm.io/
CLANDRO_PKG_DESCRIPTION="A blog compiler"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.20.1
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/blogc/blogc/releases/download/v$CLANDRO_PKG_VERSION/blogc-$CLANDRO_PKG_VERSION.tar.bz2
CLANDRO_PKG_SHA256=0ecf95acbe9f90fc35986234c4feb8f860637a703cb50c7d0f054344ab9f6709
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--disable-git-receiver --enable-make --enable-runserver --disable-tests --disable-valgrind"
