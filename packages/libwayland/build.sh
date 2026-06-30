CLANDRO_PKG_HOMEPAGE=https://wayland.freedesktop.org/
CLANDRO_PKG_DESCRIPTION="Wayland protocol library"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.25.0"
CLANDRO_PKG_SRCURL=https://gitlab.freedesktop.org/wayland/wayland/-/releases/${CLANDRO_PKG_VERSION}/downloads/wayland-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=c065f040afdff3177680600f249727e41a1afc22fccf27222f15f5306faa1f03
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libandroid-support, libexpat, libffi, libxml2"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Ddocumentation=false
-Dtests=false
"
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS="
-Ddocumentation=false
-Ddtd_validation=false
-Dlibraries=false
-Dtests=false
--prefix ${CLANDRO_PREFIX}/opt/${CLANDRO_PKG_NAME}/cross
"

clandro_step_post_get_source() {
	# Remove this marker all the time in order to prevent this:
	# No files in subpackage 'libwayland-cross-scanner' when built for
	# all with package 'libwayland', so the subpackage was not created.
	# If unexpected, check to make sure the files are where you expect.
	rm -rf $CLANDRO_HOSTBUILD_MARKER
}

clandro_step_host_build() {
	# Download and unpack and build libexpat for host
	EXPAT_SRC="$CLANDRO_PKG_SRCDIR/expat"
	EXPAT_PREFIX="$CLANDRO_PKG_HOSTBUILD_DIR/expat"
	(. "$CLANDRO_SCRIPTDIR/packages/libexpat/build.sh"; CLANDRO_PKG_SRCDIR="$EXPAT_SRC" clandro_step_get_source )
	(
		cd "$EXPAT_SRC"
		./configure --prefix="$EXPAT_PREFIX" --without-docbook
		make install
	)

	# XXX: clandro_setup_meson is not expected to be called in host build
	export PKG_CONFIG_LIBDIR="$EXPAT_PREFIX/lib/pkgconfig:/usr/lib/x86_64-linux-gnu/pkgconfig"
	AR=;CC=;CFLAGS=;CPPFLAGS=;CXX=;CXXFLAGS=;LD=;LDFLAGS=;PKG_CONFIG=;STRIP=
	clandro_setup_meson
	unset AR CC CFLAGS CPPFLAGS CXX CXXFLAGS LD LDFLAGS PKG_CONFIG STRIP PKG_CONFIG_PATH

	${CLANDRO_MESON} setup ${CLANDRO_PKG_SRCDIR} . \
		${CLANDRO_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS}
	ninja -j "${CLANDRO_PKG_MAKE_PROCESSES}" install
}

clandro_step_pre_configure() {
	clandro_setup_wayland_cross_pkg_config_wrapper
}
