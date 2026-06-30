CLANDRO_PKG_HOMEPAGE=https://developer.gnome.org/glib/
CLANDRO_PKG_DESCRIPTION="Library providing core building blocks for libraries and applications written in C"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.88.1"
CLANDRO_PKG_SRCURL="https://download.gnome.org/sources/glib/${CLANDRO_PKG_VERSION%.*}/glib-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=51ab804c56f6eab3e5045c774d1290ac5e4c923d4f9a3d8e33123bee45c1840e
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libandroid-support, libffi, libiconv, pcre2, resolv-conf, zlib, python"
CLANDRO_PKG_SETUP_PYTHON=true
CLANDRO_PKG_BREAKS="glib-dev, glib-bin"
CLANDRO_PKG_REPLACES="glib-dev, glib-bin"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dintrospection=enabled
-Druntime_dir=$CLANDRO_PREFIX/var/run
-Dlibmount=disabled
-Dman-pages=enabled
-Dtests=false
"
CLANDRO_PKG_RM_AFTER_INSTALL="
bin/glib-gettextize
bin/gtester-report
lib/locale
share/gdb/auto-load
share/glib-2.0/gdb
share/glib-2.0/gettext
share/gtk-doc
"
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS="
-Ddefault_library=static
-Dintrospection=disabled
-Dlibmount=disabled
-Dtests=false
--prefix ${CLANDRO_PREFIX}/opt/${CLANDRO_PKG_NAME}/cross
"
CLANDRO_PKG_NO_SHEBANG_FIX_FILES="
opt/glib/cross/bin/gdbus-codegen
opt/glib/cross/bin/glib-genmarshal
opt/glib/cross/bin/glib-gettextize
opt/glib/cross/bin/glib-mkenums
opt/glib/cross/bin/gtester-report
"

clandro_step_host_build() {
	if [[ "${CLANDRO_ON_DEVICE_BUILD}" == "true" ]]; then return; fi

	# XXX: clandro_setup_meson is not expected to be called in host build
	AR=;CC=;CFLAGS=;CPPFLAGS=;CXX=;CXXFLAGS=;LD=;LDFLAGS=;PKG_CONFIG=;STRIP=
	clandro_setup_meson
	unset AR CC CFLAGS CPPFLAGS CXX CXXFLAGS LD LDFLAGS PKG_CONFIG STRIP

	${CLANDRO_MESON} setup ${CLANDRO_PKG_SRCDIR} . \
		${CLANDRO_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS}
	ninja -j "${CLANDRO_PKG_MAKE_PROCESSES}" install

	# clandro_step_massage strip does not cover opt dir
	find "${CLANDRO_PREFIX}/opt" \
		-path "*/glib/cross/bin/*" \
		-type f -print0 | \
		xargs -0 -r file | grep -E "ELF .+ (executable|shared object)" | \
		cut -d":" -f1 | xargs -r strip --strip-unneeded --preserve-dates
}

clandro_step_pre_configure() {
	# always remove this marker because glib-cross' files are installed during clandro_step_host_build(),
	# so the command scripts/run-docker.sh ./build-package.sh -a all gtk3 (without -I, with -a all)
	# would otherwise have .../files/usr/bin/glib-compile-resources: Exec format error
	rm -rf $CLANDRO_HOSTBUILD_MARKER
	# glib checks for __BIONIC__ instead of __ANDROID__:
	CFLAGS+=" -D__BIONIC__=1"
	_PREFIX="$CLANDRO_PKG_TMPDIR/prefix"
	local _WRAPPER_BIN="${CLANDRO_PKG_BUILDDIR}/_wrapper/bin"
	rm -rf "$_PREFIX" "$_WRAPPER_BIN"
	mkdir -p "$_PREFIX" "$_WRAPPER_BIN"

	sed '/^export PKG_CONFIG_LIBDIR=/s|$|:'${_PREFIX}'/lib/pkgconfig|' \
		"${CLANDRO_STANDALONE_TOOLCHAIN}/bin/pkg-config" \
		> "${_WRAPPER_BIN}/pkg-config"
	chmod +x "${_WRAPPER_BIN}/pkg-config"
	export PKG_CONFIG="${_WRAPPER_BIN}/pkg-config"
	export PATH="${_WRAPPER_BIN}:${PATH}"

	# Magic happens here.
	# I borrowed nested building method from https://github.com/termux/termux-packages/blob/1244c75380beefc7f7da9744d55aa88df1640acb/x11-packages/qbittorrent/build.sh#L21-L28
	# and modified clandro_step_configure_meson in runtime to make it use another prefix
	# Also I used advice from here https://github.com/termux/termux-packages/issues/20447#issuecomment-2156066062

	# Running a subshell to not mess with variables
	(
		# Building `glib` with `-Dintrospection=disabled` and installing it to temporary directory
		CLANDRO_PKG_BUILDDIR="$CLANDRO_PKG_TMPDIR/glib-build"
		mkdir -p "$CLANDRO_PKG_BUILDDIR"
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="${CLANDRO_PKG_EXTRA_CONFIGURE_ARGS/"-Dintrospection=enabled"/"-Dintrospection=disabled"}"
		clandro_setup_gir

		cd "$CLANDRO_PKG_BUILDDIR"
		CLANDRO_PREFIX="$_PREFIX" clandro_step_configure
		cd "$CLANDRO_PKG_BUILDDIR"
		clandro_step_make
		cd "$CLANDRO_PKG_BUILDDIR"
		clandro_step_make_install
	)

	# Running a subshell to not mess with variables
	(
		# Building `gobject-introspection` and installing it to temporary directory
		CLANDRO_PKG_BUILDER_DIR="$CLANDRO_SCRIPTDIR/packages/gobject-introspection"
		CLANDRO_PKG_BUILDDIR="$CLANDRO_PKG_TMPDIR/gobject-introspection-build"
		CLANDRO_PKG_SRCDIR="$CLANDRO_PKG_TMPDIR/gobject-introspection-src"
		LDFLAGS+=" -L${_PREFIX}/lib"
		mkdir -p "$CLANDRO_PKG_BUILDDIR" "$CLANDRO_PKG_SRCDIR"
		# Sourcing another build script for nested build
		. "$CLANDRO_PKG_BUILDER_DIR/build.sh"
		cd "$CLANDRO_PKG_CACHEDIR"

		clandro_step_get_source
		clandro_step_get_dependencies_python
		clandro_step_patch_package

		clandro_step_pre_configure

		cd "$CLANDRO_PKG_BUILDDIR"
		CLANDRO_PREFIX="$_PREFIX" clandro_step_configure
		cd "$CLANDRO_PKG_BUILDDIR"
		clandro_step_make
		cd "$CLANDRO_PKG_BUILDDIR"
		clandro_step_make_install
	)

	# Place the GIR files inside the root of the GIR directory (gir/.) of the package
	clandro_setup_gir

	# The package will be built with using gobject-introspection we built before...
	export CLANDRO_MESON_ENABLE_SOVERSION=1
}

clandro_step_post_make_install() {
	local pc_files=$(ls "${CLANDRO_PREFIX}/opt/glib/cross/lib/x86_64-linux-gnu/pkgconfig")
	for pc in ${pc_files}; do
		echo "INFO: Patching cross pkgconfig ${pc}"
		sed "s|\${bindir}|${CLANDRO_PREFIX}/opt/glib/cross/bin|g" \
			"${CLANDRO_PREFIX}/lib/pkgconfig/${pc}" \
			> "${CLANDRO_PREFIX}/opt/glib/cross/lib/x86_64-linux-gnu/pkgconfig/${pc}"
	done
}

clandro_step_post_massage() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION_GUARD_FILES=(
		'lib/libgio-2.0.so.0'
		'lib/libgirepository-2.0.so.0'
		'lib/libglib-2.0.so.0'
		'lib/libgmodule-2.0.so.0'
		'lib/libgobject-2.0.so.0'
		'lib/libgthread-2.0.so.0'
	)

	local f
	for f in "${_SOVERSION_GUARD_FILES[@]}"; do
		[ -e "${f}" ] || clandro_error_exit "SOVERSION guard check failed."
	done
}

clandro_step_create_debscripts() {
	for i in postinst prerm triggers; do
		sed \
			"s|@CLANDRO_PREFIX@|${CLANDRO_PREFIX}|g" \
			"${CLANDRO_PKG_BUILDER_DIR}/hooks/${i}.in" > ./${i}
		chmod 755 ./${i}
	done
	unset i
	if [[ "$CLANDRO_PACKAGE_FORMAT" == "pacman" ]]; then
		echo "post_install" > postupg
	fi
	chmod 644 ./triggers
}
