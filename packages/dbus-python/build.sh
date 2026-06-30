CLANDRO_PKG_HOMEPAGE=https://dbus.freedesktop.org/doc/dbus-python/
CLANDRO_PKG_DESCRIPTION="Python bindings for D-Bus"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.4.0"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://gitlab.freedesktop.org/dbus/dbus-python/-/archive/dbus-python-${CLANDRO_PKG_VERSION}/dbus-python-dbus-python-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=da4ee9bbb9eb901d463a7cc9f99dfdbe6c751c8b48b29b78d378985a3c9656ad
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE=newest-tag
CLANDRO_PKG_DEPENDS="dbus, glib, python"
CLANDRO_PKG_PYTHON_COMMON_BUILD_DEPS="wheel"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dpython=python
"

clandro_step_pre_configure() {
	# Force using Meson
	rm -f configure
}
