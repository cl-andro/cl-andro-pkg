CLANDRO_PKG_HOMEPAGE=https://gnome.pages.gitlab.gnome.org/tinysparql
CLANDRO_PKG_DESCRIPTION="Desktop-neutral metadata-based search framework"
CLANDRO_PKG_LICENSE="LGPL-2.1-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.10.1"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://github.com/GNOME/tinysparql/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=37a987a4b59dd20b671eb21791a8d37d3c6d1172906f70edcee7889547986956
CLANDRO_PKG_DEPENDS="libicu, dbus, pygobject, python, json-glib, libxml2, sqlite"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, icu-devtools, libsoup3, asciidoc, xorgproto, valac, gettext, libstemmer, binutils"
CLANDRO_PKG_PYTHON_COMMON_BUILD_DEPS="docutils, setuptools"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Ddocs=false
-Dbash_completion=false
-Dsystemd_user_services=false
-Dintrospection=disabled
-Dvapi=disabled
-Dtests=false
-Doverride_sqlite_version_check=true
"

clandro_step_post_get_source() {
	rm -f subprojects/*.wrap
}

clandro_step_pre_configure() {
	clandro_setup_glib_cross_pkg_config_wrapper
}
