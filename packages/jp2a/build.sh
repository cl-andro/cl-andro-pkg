CLANDRO_PKG_HOMEPAGE=https://github.com/Talinx/jp2a/
CLANDRO_PKG_DESCRIPTION="A simple JPEG to ASCII converter"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.3.3"
CLANDRO_PKG_SRCURL=https://github.com/Talinx/jp2a/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=8c62f02051f0aa588b592ff8cc7d9ca799b312e47274044d46e70fe038018fd1
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libcurl, libexif, libjpeg-turbo, libpng, libwebp, ncurses"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
bashcompdir=${CLANDRO_PREFIX}/share/bash-completion/completions
"

clandro_step_pre_configure() {
	autoreconf -vi
}
