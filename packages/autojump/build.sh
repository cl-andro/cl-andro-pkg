CLANDRO_PKG_HOMEPAGE=https://github.com/wting/autojump
CLANDRO_PKG_DESCRIPTION="A faster way to navigate your filesystem"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="22.5.3"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL="https://github.com/wting/autojump/archive/refs/tags/release-v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=00daf3698e17ac3ac788d529877c03ee80c3790472a85d0ed063ac3a354c37b1
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_METHOD=repology
CLANDRO_PKG_DEPENDS="python"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make() {
	:
}

clandro_step_make_install() {
	SHELL=/bin/bash ./install.py --system
}
