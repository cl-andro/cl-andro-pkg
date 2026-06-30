CLANDRO_PKG_HOMEPAGE=https://github.com/linuxmint/cinnamon
CLANDRO_PKG_DESCRIPTION="Cinnamon shell"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.6.8"
CLANDRO_PKG_SRCURL="https://github.com/linuxmint/cinnamon/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=adbc892191a4f4e24346100deaeca12cea0d2c8e07061ec86fe963633b278b64
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+(?!-)"
CLANDRO_PKG_DEPENDS="atk, cinnamon-control-center, cinnamon-menus, cinnamon-session, cinnamon-settings-daemon, cjs, clutter, clutter-gtk, cogl, dbus, gcr, gdk-pixbuf, gettext, glib, gnome-backgrounds, gobject-introspection, gsound, gtk3, ibus, libadapta, libx11, libxml2, mint-themes, mint-y-icon-theme, muffin, nemo, opengl, pango, python-pillow, python-pip, python-xapp, sassc, xapp"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, glib-cross, intltool, python-libsass"
CLANDRO_PKG_PYTHON_RUNTIME_DEPS="pytz, tinycss2, requests"
CLANDRO_PKG_SUGGESTS="gnome-terminal, gnome-screenshot"
CLANDRO_PKG_PYTHON_CROSS_BUILD_DEPS="pysass"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Ddocs=false
-Dbuild_recorder=false
-Dnm_agent=disabled
-Dpy3modules_dir="$CLANDRO_PYTHON_HOME/site-packages"
-Dwayland=false
-Dpolkit=false
"

clandro_step_post_get_source() {
	find "$CLANDRO_PKG_SRCDIR" -type f | \
		xargs -n 1 sed -i \
		-e "s|/usr|$CLANDRO_PREFIX|g" \
		-e "s|#!$CLANDRO_PREFIX|#!/usr|g"
}

clandro_step_pre_configure() {
	clandro_setup_gir
	clandro_setup_glib_cross_pkg_config_wrapper

	export CLANDRO_MESON_ENABLE_SOVERSION=1

	# allow use of GNU/Linux pysass (CLANDRO_PKG_PYTHON_CROSS_BUILD_DEPS="pysass") during cross-compilation
	# but bionic-libc pysass (CLANDRO_PKG_BUILD_DEPENDS="python-sass") during on-device build
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		export PYTHONPATH="${CLANDRO_PYTHON_CROSSENV_PREFIX}/cross/lib/python${CLANDRO_PYTHON_VERSION}/site-packages"
	fi
}

clandro_step_post_make_install() {
	# disabling this sections because they will not work in termux
	mv $CLANDRO_PREFIX/share/cinnamon/cinnamon-settings/modules/cs_user.py $CLANDRO_PREFIX//share/cinnamon/cinnamon-settings/modules/cs_user.py.bak
	rm -rf $CLANDRO_PREFIX/share/cinnamon/applets/user@cinnamon.org
	rm -rf $CLANDRO_PREFIX/share/cinnamon/applets/network@cinnamon.org
	rm -rf $CLANDRO_PREFIX/share/cinnamon/applets/printers@cinnamon.org

	########################################################################
	# Based on :- https://src.fedoraproject.org/rpms/cinnamon/tree/rawhide #
	########################################################################
	# Install gschema overrides
	schemas_dir="$CLANDRO_PREFIX/share/glib-2.0/schemas"
	mkdir -p "$schemas_dir"
	install -Dm644 "$CLANDRO_PKG_BUILDER_DIR/10_cinnamon-common.gschema.override" "$schemas_dir/10_cinnamon-common.gschema.override"
	cat <<-EOF > "$schemas_dir/10_cinnamon-wallpaper.gschema.override"
		[org.cinnamon.desktop.background]
		picture-uri='file://$CLANDRO_PREFIX/share/backgrounds/gnome/adwaita-d.jpg'
	EOF
	# Install style file
	styles_dir="$CLANDRO_PREFIX/share/cinnamon/styles.d"
	mkdir -p "$styles_dir"
	install -Dm644 "$CLANDRO_PKG_BUILDER_DIR/22_termux.styles" "$styles_dir/22_termux.styles"
}
