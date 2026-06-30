CLANDRO_PKG_HOMEPAGE=https://github.com/yshui/picom
CLANDRO_PKG_DESCRIPTION="A lightweight compositor for X11"
CLANDRO_PKG_LICENSE="MIT, MPL-2.0"
CLANDRO_PKG_LICENSE_FILE="COPYING, LICENSES/MIT, LICENSES/MPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="13"
CLANDRO_PKG_SRCURL=https://github.com/yshui/picom/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=db9791a54255742c924ef82a6a882042636d61de0fa61bc14c5e56279cf5791c
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="dbus, libconfig, libepoxy, libev, libpixman, libx11, libxcb, opengl, pcre2, xcb-util-image, xcb-util-renderutil"
CLANDRO_PKG_BUILD_DEPENDS="uthash, xorgproto"
CLANDRO_PKG_CONFFILES="
etc/xdg/picom.conf
"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dwith_docs=true
"

clandro_step_pre_configure() {
	sed -i "s/^\(host_system *= *\).*/\1'linux'/" src/meson.build
}

clandro_step_post_make_install() {
	install -Dm600 "${CLANDRO_PKG_SRCDIR}"/picom.sample.conf "${CLANDRO_PREFIX}"/etc/xdg/picom.conf
}
