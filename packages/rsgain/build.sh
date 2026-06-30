CLANDRO_PKG_HOMEPAGE=https://github.com/complexlogic/rsgain
CLANDRO_PKG_DESCRIPTION="A simple audio normalizazion utility"
CLANDRO_PKG_LICENSE="BSD 2-Clause"
CLANDRO_PKG_MAINTAINER="Joshua Kahn <tom@termux.dev> & @clandro"
CLANDRO_PKG_VERSION="3.7"
CLANDRO_PKG_SRCURL=https://github.com/complexlogic/rsgain/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=ef383af1adbc01a6e858b45b67b632168ef7c1ee8c2f8267630cbd0f9bf8498e
CLANDRO_PKG_DEPENDS='taglib, libc++, libinih, libebur128, ffmpeg'
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="-DUSE_STD_FORMAT=ON"
