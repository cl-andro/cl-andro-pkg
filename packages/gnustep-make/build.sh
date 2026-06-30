CLANDRO_PKG_HOMEPAGE=https://www.gnustep.org
CLANDRO_PKG_DESCRIPTION="The GNUstep makefile package"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.9.3"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/gnustep/tools-make/archive/refs/tags/make-${CLANDRO_PKG_VERSION//./_}.tar.gz
CLANDRO_PKG_SHA256=aad12caecb0398b099f3b8b0282cecc3f01a9f371200641b2e1e535ae6ee2543
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP='(?<=make-)\d+\_\d+\_\d+'
CLANDRO_PKG_DEPENDS="libobjc2"

clandro_step_pre_configure() {
	export OBJCXX="$CXX"
}
