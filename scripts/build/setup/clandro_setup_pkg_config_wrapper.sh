clandro_setup_pkg_config_wrapper() {
	local _PKG_CONFIG_LIBDIR=$1
	local _WRAPPER_BIN="${CLANDRO_PKG_BUILDDIR}/_wrapper/bin"
	mkdir -p "${_WRAPPER_BIN}"
	if [[ "${CLANDRO_ON_DEVICE_BUILD}" == "false" ]]; then
		sed "s|^export PKG_CONFIG_LIBDIR=|export PKG_CONFIG_LIBDIR=${_PKG_CONFIG_LIBDIR}:|" \
			"${CLANDRO_STANDALONE_TOOLCHAIN}/bin/pkg-config" \
			> "${_WRAPPER_BIN}/pkg-config"
		chmod +x "${_WRAPPER_BIN}/pkg-config"
		export PKG_CONFIG="${_WRAPPER_BIN}/pkg-config"
	fi
	export PATH="${_WRAPPER_BIN}:${PATH}"
}

clandro_setup_glib_cross_pkg_config_wrapper() {
	clandro_setup_pkg_config_wrapper "${CLANDRO_PREFIX}/opt/glib/cross/lib/x86_64-linux-gnu/pkgconfig"
}

clandro_setup_wayland_cross_pkg_config_wrapper() {
	clandro_setup_pkg_config_wrapper "${CLANDRO_PREFIX}/opt/libwayland/cross/lib/x86_64-linux-gnu/pkgconfig"
}
