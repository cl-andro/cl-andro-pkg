CLANDRO_PKG_HOMEPAGE=https://www.freedesktop.org/wiki/Software/PulseAudio
CLANDRO_PKG_DESCRIPTION="A featureful, general-purpose sound server"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_SRCURL=git+https://github.com/pulseaudio/pulseaudio
CLANDRO_PKG_VERSION="17.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_DEPENDS="dbus, libandroid-execinfo, libandroid-glob, libc++, libltdl, libsndfile, libsoxr, libwebrtc-audio-processing, speexdsp"
CLANDRO_PKG_BREAKS="libpulseaudio-dev, libpulseaudio"
CLANDRO_PKG_REPLACES="libpulseaudio-dev, libpulseaudio"
# glib is only a runtime dependency of pulseaudio-glib subpackage
CLANDRO_PKG_BUILD_DEPENDS="libtool, glib, check"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="-D alsa=disabled
-D x11=disabled
-D gtk=disabled
-D openssl=disabled
-D gsettings=disabled
-D doxygen=false
-D database=simple"
CLANDRO_PKG_CONFFILES="etc/pulse/client.conf etc/pulse/daemon.conf etc/pulse/default.pa etc/pulse/system.pa"

clandro_step_pre_configure() {
	# Our aaudio sink module needs libaaudio.so from a later android api version:
	if [ $CLANDRO_PKG_API_LEVEL -lt 26 ]; then
		local _libdir="$CLANDRO_PKG_TMPDIR/libaaudio"
		rm -rf "${_libdir}"
		mkdir -p "${_libdir}"
		cp "$CLANDRO_STANDALONE_TOOLCHAIN/sysroot/usr/lib/$CLANDRO_HOST_PLATFORM/26/libaaudio.so" \
			"${_libdir}"
		LDFLAGS+=" -L${_libdir}"
	fi

	mkdir $CLANDRO_PKG_SRCDIR/src/modules/sles
	cp $CLANDRO_PKG_BUILDER_DIR/module-sles-sink.c $CLANDRO_PKG_SRCDIR/src/modules/sles
	cp $CLANDRO_PKG_BUILDER_DIR/module-sles-source.c $CLANDRO_PKG_SRCDIR/src/modules/sles
	mkdir $CLANDRO_PKG_SRCDIR/src/modules/aaudio
	cp $CLANDRO_PKG_BUILDER_DIR/module-aaudio-sink.c $CLANDRO_PKG_SRCDIR/src/modules/aaudio

	export LIBS="-landroid-glob -landroid-execinfo"

	local _libgcc="$($CC -print-libgcc-file-name)"
	LIBS+=" -L$(dirname $_libgcc) -l:$(basename $_libgcc)"

	# https://github.com/termux/termux-packages/issues/18977
	# https://github.com/termux/termux-packages/issues/18810
	export LDFLAGS+=" -Wl,--undefined-version"
}

clandro_step_post_make_install() {
	# Some binaries link against these:
	cd $CLANDRO_PREFIX/lib
	for lib in pulseaudio/{,modules/}lib*.so*; do
		ln -v -s -f "$lib" "$(basename "$lib")"
	done

	# Pulseaudio fails to start when it cannot detect any sound hardware
	# so disable hardware detection.
	sed -i $CLANDRO_PREFIX/etc/pulse/default.pa \
		-e '/^load-module module-detect$/s/^/#/'
	echo "load-module module-sles-sink" >> $CLANDRO_PREFIX/etc/pulse/default.pa
	echo "#load-module module-aaudio-sink" >> $CLANDRO_PREFIX/etc/pulse/default.pa
}

clandro_step_post_massage() {
	# Some programs, e.g. Firefox, try to dlopen(3) `libpulse.so.0`.
	cd ${CLANDRO_PKG_MASSAGEDIR}/${CLANDRO_PREFIX}/lib || exit 1
	if [ ! -e "./libpulse.so.0" ]; then
		ln -sf libpulse.so libpulse.so.0
	fi
}
