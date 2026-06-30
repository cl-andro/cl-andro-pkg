CLANDRO_PKG_HOMEPAGE='https://craigbarnes.gitlab.io/dte/'
CLANDRO_PKG_DESCRIPTION='A small, configurable console text editor'
CLANDRO_PKG_LICENSE='GPL-2.0'
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.11.1"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://gitlab.com/craigbarnes/dte/-/archive/v${CLANDRO_PKG_VERSION}/dte-v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=68c25bc4e8792da33529626e23102cd5fb34186479049f5480fd9f3e9ffb1171
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libandroid-support, libandroid-glob, libiconv"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	export LDLIBS="-landroid-support -landroid-glob -liconv"
}
