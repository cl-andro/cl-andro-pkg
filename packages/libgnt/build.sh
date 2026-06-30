CLANDRO_PKG_HOMEPAGE=https://keep.imfreedom.org/libgnt/libgnt
CLANDRO_PKG_DESCRIPTION="An ncurses toolkit for creating text-mode graphical user interfaces in a fast and easy way"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.14.4"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://downloads.sourceforge.net/project/pidgin/libgnt/${CLANDRO_PKG_VERSION}/libgnt-${CLANDRO_PKG_VERSION}-dev.tar.xz
CLANDRO_PKG_SHA256=195933a9a731d3575791b881ba5cc0ad2a715e1e9c4c23ccaaa2a17e164c96ec
CLANDRO_PKG_DEPENDS="glib, libxml2, ncurses, ncurses-ui-libs"
CLANDRO_PKG_BUILD_DEPENDS="glib-cross"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="-Ddoc=false -Dpython2=false"

clandro_step_pre_configure() {
	clandro_setup_glib_cross_pkg_config_wrapper
}
