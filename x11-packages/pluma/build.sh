CLANDRO_PKG_HOMEPAGE=https://mate-desktop.org/
CLANDRO_PKG_DESCRIPTION="Powerful text editor for MATE"
CLANDRO_PKG_LICENSE="GPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.28.1"
CLANDRO_PKG_SRCURL="https://github.com/mate-desktop/pluma/releases/download/v$CLANDRO_PKG_VERSION/pluma-$CLANDRO_PKG_VERSION.tar.xz"
CLANDRO_PKG_SHA256=27137ff1bb1c53a90d2308b8a6b203e5d07f13a644a0d950f3ead7bb9cf1e241
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="iso-codes, mate-desktop, zenity, gtksourceview4, glib, gobject-introspection, libpeas, gettext, enchant, libsm"
CLANDRO_PKG_SUGGESTS="pygobject"
CLANDRO_PKG_BUILD_DEPENDS="autoconf-archive, mate-common"
# the python plugins do not work because of a libpeas-related dependency conflict
# if upstream fixes that in the future, enable python in libpeas to resolve this
# (enabling python in libpeas will not resolve this
# until upstream pluma and/or libpeas and/or python-gobject fixes this problem)
# (setting --disable-python does not seem to hide the broken python plugins from the user,
# so there is no point to disabling python in pluma)
# More information:
# https://gitlab.archlinux.org/archlinux/packaging/packages/libpeas/-/commit/75310ec6c665e4104044b996e26b34c4ab169b2d
# https://gitlab.archlinux.org/archlinux/packaging/packages/pygobject/-/issues/3
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--enable-python
"

clandro_step_pre_configure() {
	clandro_setup_gir
	clandro_setup_glib_cross_pkg_config_wrapper

	autoreconf -fi
}
