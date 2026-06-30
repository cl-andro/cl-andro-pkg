CLANDRO_PKG_HOMEPAGE=http://dia-installer.de
CLANDRO_PKG_DESCRIPTION="Diagram editor, compatible with Micrososft Visio"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
_COMMIT=ea793ab3eb2e5dc50e5191d782d222e15de1eccc
CLANDRO_PKG_VERSION="0.97.2-p20260216"
CLANDRO_PKG_SRCURL=git+https://gitlab.gnome.org/GNOME/dia
CLANDRO_PKG_GIT_BRANCH=master
CLANDRO_PKG_SHA256=2c12ff3b8c6575020e7df5c5c6f9307e8b3b748305f899b5011aeadcedf90886
CLANDRO_PKG_REPOLOGY_METADATA_VERSION="${CLANDRO_PKG_VERSION%%-*}"
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_GROUPS="graphics"
CLANDRO_PKG_PROVIDES="xpm-pixbuf"
CLANDRO_PKG_DEPENDS="gdk-pixbuf, glib, graphene, gtk3, libcairo, libxml2, pango, poppler, pygobject"
CLANDRO_PKG_BUILD_DEPENDS="xorgproto, xsltproc"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="-Dtests=false"

clandro_step_post_get_source() {
	git fetch --unshallow
	git checkout "$_COMMIT"

	local pdate="p$(git log -1 --format=%cs | sed 's/-//g')"
	if [[ "$CLANDRO_PKG_VERSION" != *"${pdate}" ]]; then
		echo -n "ERROR: The version string \"$CLANDRO_PKG_VERSION\" is"
		echo -n " different from what is expected to be; should end"
		echo " with \"${pdate}\"."
		return 1
	fi

	local s=$(find . -type f ! -path '*/.git/*' -print0 | xargs -0 sha256sum | LC_ALL=C sort | sha256sum)
	if [[ "${s}" != "${CLANDRO_PKG_SHA256}  "* ]]; then
		clandro_error_exit "Checksum mismatch for source files."
	fi
}

clandro_step_pre_configure() {
	CPPFLAGS+=" -D_BSD_SOURCE"
	CFLAGS+=" -Wno-format-nonliteral"
	clandro_setup_gir
	clandro_setup_glib_cross_pkg_config_wrapper
}
