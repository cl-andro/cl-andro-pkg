CLANDRO_PKG_HOMEPAGE=https://git.linuxtv.org/v4l-utils.git
CLANDRO_PKG_DESCRIPTION="Linux libraries to handle media devices"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.24.1
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://linuxtv.org/downloads/v4l-utils/v4l-utils-${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=cbb7fe8a6307f5ce533a05cded70bb93c3ba06395ab9b6d007eb53b75d805f5b
CLANDRO_PKG_DEPENDS="libandroid-execinfo, libandroid-glob, libjpeg-turbo"
CLANDRO_PKG_BUILD_DEPENDS="argp"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-v4l-utils
--disable-qv4l2
"
