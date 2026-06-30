CLANDRO_PKG_HOMEPAGE=https://github.com/vcrhonek/hwdata
CLANDRO_PKG_DESCRIPTION="Database of hardware identification and configuration data"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.407"
CLANDRO_PKG_SRCURL=https://github.com/vcrhonek/hwdata/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=6a88f6f5cb510fbfaa9c49488348b7fcd7aa209b0a331f24dfebb1c8c339568b
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--datadir=${CLANDRO_PREFIX}/share
--disable-blacklist
"

clandro_step_pre_configure() {
	mv Makefile{,.unused}
}

clandro_step_post_configure() {
	mv Makefile{.unused,}
}
