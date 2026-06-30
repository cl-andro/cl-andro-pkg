CLANDRO_PKG_HOMEPAGE=https://github.com/termux/clandro-apt-repo
CLANDRO_PKG_DESCRIPTION="Script to create Termux apt repositories"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.5"
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_SRCURL="https://github.com/termux/clandro-apt-repo/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=22c2ad46e548a9b73179da072b798cbbe6767f2dcc99cc476fa88641f8595434
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
# llvm for ar:
CLANDRO_PKG_DEPENDS="llvm, python, tar"

clandro_step_pre_configure() {
	clandro_setup_python_pip
}
