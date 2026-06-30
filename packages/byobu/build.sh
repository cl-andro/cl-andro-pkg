CLANDRO_PKG_HOMEPAGE=https://www.byobu.org/
CLANDRO_PKG_DESCRIPTION="Byobu is a GPLv3 open source text-based window manager and terminal multiplexer"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.15"
CLANDRO_PKG_SRCURL="https://github.com/dustinkirkland/byobu/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=2d670627aeb068447654b78fd83901ea4b0d08df59f6fa0721d61cb1fc2f56ae
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_DEPENDS="gawk, tmux"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true

clandro_step_pre_configure() {
	autoreconf -fiv
}
