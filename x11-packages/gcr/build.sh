CLANDRO_PKG_HOMEPAGE=https://gitlab.gnome.org/GNOME/gcr
CLANDRO_PKG_DESCRIPTION="A library for displaying certificates and crypto UI, accessing key stores"
CLANDRO_PKG_LICENSE="LGPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
# This specific package is for libgcr-3.
CLANDRO_PKG_VERSION="3.41.2"
CLANDRO_PKG_SRCURL=https://download.gnome.org/sources/gcr/${CLANDRO_PKG_VERSION%.*}/gcr-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=bad10f3c553a0e1854649ab59c5b2434da22ca1a54ae6138f1f53961567e1ab7
CLANDRO_PKG_DEPENDS="gdk-pixbuf, glib, gtk3, libcairo, libgcrypt, p11-kit, pango"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, glib-cross, gnupg, valac"
CLANDRO_PKG_RECOMMENDS="gnupg"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dintrospection=true
-Dgtk=true
-Dgtk_doc=false
-Dgpg_path=$CLANDRO_PREFIX/bin/gpg
-Dssh_agent=false
-Dsystemd=disabled
"

clandro_step_pre_configure() {
	clandro_setup_gir

	local bin_dir=$CLANDRO_PKG_BUILDDIR/_dummy/bin
	mkdir -p $bin_dir
	pushd $bin_dir
	local p
	for p in ssh-add ssh-agent; do
		cat <<-EOF > $p
			#!$(command -v sh)
			exit 0
			EOF
		chmod 0700 $p
	done
	popd
	export PATH+=":$bin_dir"
	clandro_setup_glib_cross_pkg_config_wrapper
}

clandro_step_post_massage() {
	local _GUARD_FILES="lib/libgcr-3.so lib/libgck-1.so"
	local f
	for f in ${_GUARD_FILES}; do
		if [ ! -e "${f}" ]; then
			clandro_error_exit "file ${f} not found."
		fi
	done
}
