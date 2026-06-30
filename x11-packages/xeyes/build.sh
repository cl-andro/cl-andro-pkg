CLANDRO_PKG_HOMEPAGE=https://gitlab.freedesktop.org/xorg/app/xeyes
CLANDRO_PKG_DESCRIPTION="A follow the mouse X demo"
CLANDRO_PKG_LICENSE="X11"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.3.1
CLANDRO_PKG_SRCURL=https://gitlab.freedesktop.org/xorg/app/xeyes/-/archive/xeyes-${CLANDRO_PKG_VERSION}/xeyes-xeyes-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=6ba53dbe17ff644c325dc28a7faab5125dd6b8d780d3709b874180c5dfd9cbb2
CLANDRO_PKG_DEPENDS="libx11, libxcb, libxext, libxi, libxmu, libxrender, libxt"
CLANDRO_PKG_BUILD_DEPENDS="libxfixes, xorg-util-macros"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE=newest-tag

clandro_step_pre_configure() {
	autoreconf -fi
}
