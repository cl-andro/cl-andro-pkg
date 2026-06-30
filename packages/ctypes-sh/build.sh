CLANDRO_PKG_HOMEPAGE=https://github.com/taviso/ctypes.sh
CLANDRO_PKG_DESCRIPTION="A foreign function interface for bash"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.2
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://github.com/taviso/ctypes.sh/releases/download/v${CLANDRO_PKG_VERSION}/ctypes-sh-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=8896334f5fa88f656057bff807ec6921c8f76fc6de801d996d2057fcb18b3a68
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="bash, libelf, libdw, libffi, zlib"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	autoreconf -vif
}
