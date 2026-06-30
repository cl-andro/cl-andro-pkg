CLANDRO_PKG_HOMEPAGE=https://tinyproxy.github.io/
CLANDRO_PKG_DESCRIPTION="Light-weight HTTP proxy daemon for POSIX operating systems"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.11.3"
CLANDRO_PKG_SRCURL=https://github.com/tinyproxy/tinyproxy/releases/download/${CLANDRO_PKG_VERSION}/tinyproxy-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=f05644fdf1211ba13754a354bebed909b5b39371b12cce8563c46929a75bedf6
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--disable-regexcheck"

clandro_step_pre_configure() {
	CPPFLAGS+=" -DLINE_MAX=_POSIX2_LINE_MAX"
}

clandro_step_post_massage() {
	mkdir -p "${CLANDRO_PKG_MASSAGEDIR}/${CLANDRO_PREFIX}/var/log/${CLANDRO_PKG_NAME}"
	mkdir -p "${CLANDRO_PKG_MASSAGEDIR}/${CLANDRO_PREFIX}/var/run/${CLANDRO_PKG_NAME}"
}
