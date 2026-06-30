CLANDRO_PKG_HOMEPAGE=https://handbrake.fr/
CLANDRO_PKG_DESCRIPTION="A GPL-licensed, multiplatform, multithreaded video transcoder"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_LICENSE_FILE="COPYING, LICENSE"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.11.1"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/HandBrake/HandBrake/releases/download/${CLANDRO_PKG_VERSION}/HandBrake-${CLANDRO_PKG_VERSION}-source.tar.bz2
CLANDRO_PKG_SHA256=4ff6a8a57c9b1cea51025306e313eee423b0fa1a8b7799aeaa8d4d7c457a7310
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="ffmpeg, gdk-pixbuf, gst-plugins-base, gstreamer, gtk4, libass, libbluray, libcairo, libdav1d, libdvdnav, libdvdread, libiconv, libjansson, libjpeg-turbo, libtheora, libvorbis, libvpx, libx264, libx265, libxml2, pango"
CLANDRO_PKG_BUILD_DEPENDS="liba52, libspeex, libzimg, svt-av1"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--force
--prefix $CLANDRO_PREFIX
--arch $CLANDRO_ARCH
--disable-numa
--disable-nvenc
"
# HandBrake binaries linked against fdk-aac are not redistributable.
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" --disable-fdk-aac"

clandro_step_pre_configure() {
	# handbrake configure attempts to detect meson and cmake,
	# then during the build it runs more nested configures using
	# meson and cmake build files, then if the GUI is enabled
	# it attempts to detect and run glib-compile-resources
	clandro_setup_meson
	clandro_setup_cmake
	clandro_setup_glib_cross_pkg_config_wrapper

	# get only meson.py in cache directory
	sed -i "s|'meson'|'${CLANDRO_MESON##* }'|g" make/configure.py

	# override GTK.CONFIGURE.cross at the end of the gtk/module.defs file
	# because the existing instance of --cross-file in the middle of the file
	# is inside a condition that fails to activate when $CLANDRO_ARCH is x86_64
	echo >> gtk/module.defs
	echo "GTK.CONFIGURE.cross = --cross-file=$CLANDRO_MESON_CROSSFILE" >> gtk/module.defs

	LDFLAGS+=" -liconv -lx265"
}

clandro_step_configure() {
	$CLANDRO_PKG_SRCDIR/configure $CLANDRO_PKG_EXTRA_CONFIGURE_ARGS
}
