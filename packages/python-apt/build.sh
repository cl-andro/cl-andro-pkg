CLANDRO_PKG_HOMEPAGE=https://apt-team.pages.debian.net/python-apt/
CLANDRO_PKG_DESCRIPTION="Python bindings for APT"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.1.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://ftp.debian.org/debian/pool/main/p/python-apt/python-apt_${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=daf46b0ed85061ccee64c3aa3004c695b33047f9f62f0de7863966c287731d5a
CLANDRO_PKG_DEPENDS="apt, libandroid-support, libc++, python"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_PYTHON_COMMON_BUILD_DEPS="wheel"

clandro_step_pre_configure() {
	export DEBVER="${CLANDRO_PKG_VERSION#*:}"
}
