# X11 package
CLANDRO_PKG_HOMEPAGE=https://xorg.freedesktop.org/
CLANDRO_PKG_DESCRIPTION="X11 client-side library"
CLANDRO_PKG_LICENSE="MIT, X11"
CLANDRO_PKG_LICENSE_FILE="COPYING"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.8.13"
CLANDRO_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/lib/libX11-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=69606f485c2c07c14ef64f75b7bb326d48587af33795d9ab3e607c0b5f94f11c
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libandroid-support, libxcb"
CLANDRO_PKG_BUILD_DEPENDS="xorgproto, xorg-util-macros, xtrans"
CLANDRO_PKG_RECOMMENDS="xorg-xauth"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_path_RAWCPP=/usr/bin/cpp
--enable-malloc0returnsnull
"

clandro_step_post_massage() {
	# Regression test for broken XLC_LOCALE files. Do not remove.
	local f
	for f in share/X11/locale/*/XLC_LOCALE; do
		if [ ! -f "${f}" ]; then
			clandro_error_exit "File not found: ${f}"
		fi
		if LC_ALL=C grep -E 'ct_encoding.*;\s*$' "${f}"; then
			clandro_error_exit "Broken XLC_LOCALE file found: ${f}"
		fi
	done

	# Seems like some programs in the wild try to dlopen(3) `libX11.so.6`.
	cd ${CLANDRO_PKG_MASSAGEDIR}/${CLANDRO_PREFIX}/lib || exit 1
	if [ ! -e "./libX11.so.6" ]; then
		ln -sf libX11.so libX11.so.6
	fi
}
