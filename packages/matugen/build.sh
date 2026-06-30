CLANDRO_PKG_HOMEPAGE=https://github.com/InioX/matugen
CLANDRO_PKG_DESCRIPTION="A material you color generation tool with templates"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.1.0"
CLANDRO_PKG_SRCURL=https://github.com/InioX/matugen/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=b46507be24d01a6233597077512501f21075fe4ce19b60b410354f439f569ddf
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	clandro_setup_rust
}
