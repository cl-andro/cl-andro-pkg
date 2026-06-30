CLANDRO_PKG_HOMEPAGE=https://github.com/ibus/ibus
CLANDRO_PKG_DESCRIPTION="Intelligent Input Bus for Linux/Unix"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.5.33"
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_SRCURL="https://github.com/ibus/ibus/releases/download/$CLANDRO_PKG_VERSION/ibus-$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=58941c9b8285891c776b67fb2039eebe0d61d63a51578519febfc5481b91e831
CLANDRO_PKG_DEPENDS="dconf, glib, gobject-introspection, gtk3, gtk4, ibus-data, libdbusmenu, libnotify, libwayland, libx11, libxfixes, libxi, libxkbcommon"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, glib-cross, libdbusmenu-static, unicode-cldr, unicode-data, unicode-emoji"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_SETUP_PYTHON=true

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-tests
--enable-introspection
--disable-vala
--disable-gtk2
--enable-dconf
--enable-gtk4
--disable-memconf
--enable-ui
--disable-python2
--disable-python-library
--disable-systemd-services
--with-emoji-annotation-dir=$CLANDRO_PREFIX/share/unicode-cldr/annotations
--with-unicode-emoji-dir=$CLANDRO_PREFIX/share/unicode-emoji
--with-ucd-dir=$CLANDRO_PREFIX/share/unicode-data
"

clandro_step_pre_configure() {
	clandro_setup_gir
	clandro_setup_glib_cross_pkg_config_wrapper

	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		# Create host pkg-config wrapper
		mkdir -p "$CLANDRO_PKG_TMPDIR"/host-pkg-config
		cat > "$CLANDRO_PKG_TMPDIR"/host-pkg-config/pkg-config <<-EOF
			#!/bin/sh
			unset PKG_CONFIG_DIR
			unset PKG_CONFIG_LIBDIR
			exec /usr/bin/pkg-config "\$@"
		EOF
		chmod +x "$CLANDRO_PKG_TMPDIR"/host-pkg-config/pkg-config
		export PKG_CONFIG_FOR_BUILD="$CLANDRO_PKG_TMPDIR"/host-pkg-config/pkg-config

		DESTINATION="$CLANDRO_PKG_TMPDIR/prefix" \
		clandro_download_ubuntu_packages dconf-cli

		export PATH="$CLANDRO_PKG_TMPDIR/prefix/usr/bin:$PATH"
	fi
}
