CLANDRO_PKG_HOMEPAGE=https://github.com/cl-andro/clandro-auth
CLANDRO_PKG_DESCRIPTION="Password authentication library and utility for Termux"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.5.0
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/cl-andro/clandro-auth/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=00c34dca7c4aeee7bcb6b67039a470fcb83d6e7b5fd7af0e8827f43bbfffcd8c
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_DEPENDS="openssl"
CLANDRO_PKG_BREAKS="clandro-auth-dev"
CLANDRO_PKG_REPLACES="clandro-auth-dev"

clandro_step_pre_configure() {
	CPPFLAGS+=" -DCLANDRO_HOME=\\\"${CLANDRO_ANDROID_HOME}\\\" -DCLANDRO_PREFIX=\\\"${CLANDRO_PREFIX}\\\""
}
