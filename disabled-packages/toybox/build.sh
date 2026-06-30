CLANDRO_PKG_HOMEPAGE=https://landley.net/toybox/
CLANDRO_PKG_DESCRIPTION="Common Linux command line utilities"
CLANDRO_PKG_LICENSE="BSD"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.7.3
CLANDRO_PKG_SRCURL=https://landley.net/toybox/downloads/toybox-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=e6469b508224e0d2e4564dda05c4bb47aef5c28bf29d6c983bcdc6e3a0cd29d6
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_configure() {
	make defconfig
}
