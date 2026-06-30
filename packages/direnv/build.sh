CLANDRO_PKG_HOMEPAGE=https://github.com/direnv/direnv
CLANDRO_PKG_DESCRIPTION="Environment switcher for shell"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.37.1"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/direnv/direnv/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=4142fbb661f3218913fac08d327c415e87b3e66bd0953185294ff8f3228ead24
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	clandro_setup_golang
}
