CLANDRO_PKG_HOMEPAGE=https://orca.gnome.org/
CLANDRO_PKG_DESCRIPTION="A free, open source, flexible, and extensible screen reader"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="50.1.2"
CLANDRO_PKG_SRCURL=https://download.gnome.org/sources/orca/${CLANDRO_PKG_VERSION%%.*}/orca-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=8592b53df84239ea75ddaa8dec6792c84d2b99fb7b47a5fd9022c6af8ca657a8
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="at-spi2-core, glib, gsettings-desktop-schemas, gst-python, gstreamer, gtk3, libwnck, pango, pyatspi, pygobject, python, python-pip, speechd, xorg-xkbcomp"
CLANDRO_PKG_SETUP_PYTHON=true
CLANDRO_PKG_PYTHON_TARGET_DEPS="dasbus, setproctitle"
CLANDRO_MESON_WHEEL_CROSSFILE="$CLANDRO_PKG_TMPDIR/wheel-cross-file.txt"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--cross-file $CLANDRO_MESON_WHEEL_CROSSFILE
"

clandro_step_pre_configure() {
	if [ "$CLANDRO_ON_DEVICE_BUILD" = "false" ]; then
		local _bin="$CLANDRO_PKG_BUILDDIR/_bin"
		export ITSTOOL="${_bin}/itstool"
		rm -rf "${_bin}"
		mkdir -p "${_bin}"
		cat > "$ITSTOOL" <<-EOF
			#!$(command -v sh)
			unset PYTHONPATH
			exec $(command -v itstool) "\$@"
		EOF
		chmod 0700 "$ITSTOOL"
	fi

	clandro_setup_glib_cross_pkg_config_wrapper
}

clandro_step_configure() {
	clandro_setup_meson

	cp -f $CLANDRO_MESON_CROSSFILE $CLANDRO_MESON_WHEEL_CROSSFILE
	if [ "$CLANDRO_ON_DEVICE_BUILD" = "false" ]; then
		sed -i 's|^\(\[binaries\]\)$|\1\nitstool = '\'$ITSTOOL\''|g' \
			$CLANDRO_MESON_WHEEL_CROSSFILE
	fi

	clandro_step_configure_meson
}
