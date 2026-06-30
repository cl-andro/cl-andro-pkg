CLANDRO_PKG_HOMEPAGE=https://gitlab.gnome.org/GNOME/libxml2/-/wikis/home
CLANDRO_PKG_DESCRIPTION="Library for parsing XML documents"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.15.3"
CLANDRO_PKG_SRCURL="https://download.gnome.org/sources/libxml2/${CLANDRO_PKG_VERSION%.*}/libxml2-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=78262a6e7ac170d6528ebfe2efccdf220191a5af6a6cd61ea4a9a9a5042c7a07
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_SETUP_PYTHON=true
# disabled due to compiler warnings
#	-Dthread-alloc=enabled
#	-Dtls=enabled
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
	-Ddocs=enabled
	-Dhttp=enabled
	-Dicu=enabled
	-Dlegacy=enabled
"
# Python bindings
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+="
	-Dpython=enabled
"
# `xmllint` history support
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+="
	-Dhistory=enabled
	-Dreadline=enabled
"
CLANDRO_PKG_RM_AFTER_INSTALL="
share/doc/libxml2/html
share/doc/libxml2/xmlcatalog.html
share/doc/libxml2/xmllint.html
"
CLANDRO_PKG_DEPENDS="libandroid-glob, libiconv, libicu, zlib"
CLANDRO_PKG_BUILD_DEPENDS="doxygen, python, readline"
CLANDRO_PKG_BREAKS="libxml2-dev"
CLANDRO_PKG_REPLACES="libxml2-dev"

clandro_step_host_build() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		clandro_download_ubuntu_packages doxygen libclang-cpp18 libclang1-18 libfmt9 libxapian30
	fi
}

clandro_step_configure() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		export LD_LIBRARY_PATH="$CLANDRO_PKG_HOSTBUILD_DIR/ubuntu_packages/usr/lib/x86_64-linux-gnu"
		export PATH="$CLANDRO_PKG_HOSTBUILD_DIR/ubuntu_packages/usr/bin:$PATH"
	fi

	LDFLAGS+=" -landroid-glob"
	# This directory is usually made by doxygen
	# and python/generator.py expects it to be there.
	mkdir -p "$CLANDRO_PKG_BUILDDIR/python/doc/xml"
	# # SOVERSION suffix is needed for SONAME of shared libs to avoid conflict
	# # with system ones (in /system/lib64 or /system/lib):
	export CLANDRO_MESON_ENABLE_SOVERSION=1
	clandro_step_configure_meson
}

clandro_step_post_massage() {
	# Check if SONAME is properly set:
	if ! readelf -d lib/libxml2.so | grep -q '(SONAME).*\[libxml2\.so\.'; then
		clandro_error_exit "SONAME for libxml2.so is not properly set."
	fi

	# If this has been bumped, remember to rebuild all reverse dependencies of libxml2!
	# `./scripts/bin/revbump --dependencies libxml2` can find them for you.
	local _SOVERSION=16
	if [[ ! -e "lib/libxml2.so.${_SOVERSION}" ]]; then
		echo "ERROR - Expected: lib/libxml2.so.${_SOVERSION}" >&2
		echo "ERROR - Found   : $(find lib/libxml2* -regex '.*so\.[0-9]+')" >&2
		clandro_error_exit "Not proceeding with update."
	fi
}
