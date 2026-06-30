CLANDRO_PKG_HOMEPAGE=https://deadbeef.sourceforge.io/
CLANDRO_PKG_DESCRIPTION="A modular cross-platform audio player"
CLANDRO_PKG_LICENSE="ZLIB, GPL-2.0, LGPL-2.1, BSD 3-Clause, MIT"
CLANDRO_PKG_LICENSE_FILE="COPYING"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.10.2"
CLANDRO_PKG_SRCURL=https://downloads.sourceforge.net/deadbeef/Builds/${CLANDRO_PKG_VERSION}/linux/deadbeef-${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=dd951e83e0069e2f3df18985dd40d2cf9409f502b0ecaaf1ac229d5009a8e698
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="atk, dbus, ffmpeg, gdk-pixbuf, glib, gtk3, harfbuzz, libblocksruntime, libc++, libcairo, libcurl, libdispatch, libflac, libiconv, libjansson, libmad, libogg, libsamplerate, libsndfile, libvorbis, libwavpack, libx11, libzip, libmpg123, opusfile, pango, pulseaudio, zlib"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
ax_cv_c_flags__msse2=no
--disable-ffap
--disable-gtk2
--disable-sid
"

clandro_step_pre_configure() {
	autoreconf -fi

	CPPFLAGS+=" -Wno-implicit-function-declaration -D_FILE_OFFSET_BITS=64"

	# ERROR: ./lib/deadbeef/adplug.so contains undefined symbols: __extendsftf2
	local _libgcc_file="$($CC -print-libgcc-file-name)"
	local _libgcc_path="$(dirname $_libgcc_file)"
	local _libgcc_name="$(basename $_libgcc_file)"
	LDFLAGS+=" -lm -L$_libgcc_path -l:$_libgcc_name"

	rm -rf intl
	mkdir -p intl
	cat > intl/Makefile.in <<-EOF
		all:
		install:
	EOF
}

clandro_step_post_configure() {
	echo '!<arch>' >> intl/libintl.a
}

clandro_step_post_make_install() {
	cd $CLANDRO_PKG_SRCDIR
	local f
	for f in $(find plugins -name COPYING); do
		local d=$(dirname ${f})
		install -Dm600 -T $CLANDRO_PKG_SRCDIR/${f} \
			$CLANDRO_PREFIX/share/doc/$CLANDRO_PKG_NAME/COPYING.${d//\//.}
	done
}
