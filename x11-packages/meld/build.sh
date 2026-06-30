CLANDRO_PKG_HOMEPAGE=https://meldmerge.org/
CLANDRO_PKG_DESCRIPTION="A visual diff and merge tool targeted at developers"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.23.1"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://download.gnome.org/sources/meld/${CLANDRO_PKG_VERSION%.*}/meld-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=73f827924663c7c6b451a74c8385304d99feaa13c81f4e0a171da597c6843574
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
CLANDRO_PKG_DEPENDS="gsettings-desktop-schemas, glib, gtk3, gtksourceview4, libcairo, pango, pycairo, pygobject, python"
CLANDRO_PKG_BUILD_DEPENDS="gettext"
# build dependency only
CLANDRO_PKG_PYTHON_TARGET_DEPS="itstool"
CLANDRO_PKG_PYTHON_RUNTIME_DEPS=false
CLANDRO_MESON_WHEEL_CROSSFILE="$CLANDRO_PKG_TMPDIR/wheel-cross-file.txt"
CLANDRO_PKG_SETUP_PYTHON=true
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--cross-file $CLANDRO_MESON_WHEEL_CROSSFILE
"
clandro_step_pre_configure() {
	clandro_setup_glib_cross_pkg_config_wrapper

	# This is necessary to prevent the error "...libxml2mod.so: cannot open shared object file..." but is insufficient alone
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
}

# This is necessary to prevent the error "...libxml2mod.so: cannot open shared object file..." and depends on the block in clandro_step_pre_configure()
clandro_step_configure() {
	clandro_setup_meson

	cp -f $CLANDRO_MESON_CROSSFILE $CLANDRO_MESON_WHEEL_CROSSFILE
	if [ "$CLANDRO_ON_DEVICE_BUILD" = "false" ]; then
		sed -i 's|^\(\[binaries\]\)$|\1\nitstool = '\'$ITSTOOL\''|g' \
			$CLANDRO_MESON_WHEEL_CROSSFILE
	fi

	clandro_step_configure_meson
}
