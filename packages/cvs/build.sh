CLANDRO_PKG_HOMEPAGE=https://www.nongnu.org/cvs/
CLANDRO_PKG_DESCRIPTION="Concurrent Versions System"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1:1.12.13"
CLANDRO_PKG_REVISION=5
CLANDRO_PKG_SRCURL="https://github.com/termux/distfiles/releases/download/2021.01.04/cvs-${CLANDRO_PKG_VERSION:2}+real-26.tar.xz"
CLANDRO_PKG_SHA256=0eda91f5e8091b676c90b2a171f24f9293acb552f4e4f77b590ae8d92a547256
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_DEPENDS="zlib, libandroid-support"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
cvs_cv_func_printf_ptr=yes
ac_cv_header_syslog_h=no
--disable-server
--with-external-zlib
--with-editor=$CLANDRO_PREFIX/bin/editor
"
CLANDRO_PKG_RM_AFTER_INSTALL="bin/cvsbug share/man/man8/cvsbug.8"

clandro_step_pre_configure() {
	export CFLAGS+=" -Wno-error=deprecated-non-prototype -D__USE_GNU=1"
}
