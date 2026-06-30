CLANDRO_PKG_HOMEPAGE=https://www.mltframework.org/
CLANDRO_PKG_DESCRIPTION="Multimedia Framework. Author, manage, and run multitrack audio/video compositions."
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_VERSION="7.38.0"
CLANDRO_PKG_SRCURL=https://github.com/mltframework/mlt/releases/download/v${CLANDRO_PKG_VERSION}/mlt-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=b8f0a23c89e9250edc5038d745537c382367bf2ad3dad5d5c7cd13b0fe1c4144
CLANDRO_PKG_DEPENDS="alsa-lib, ffmpeg, fftw, fontconfig, frei0r-plugins, gdk-pixbuf, glib, jack, movit, libebur128, libepoxy, libexif, libsamplerate, libvidstab, libvorbis, libx11, libxml2, qt6-qt5compat, qt6-qtbase, qt6-qtsvg, opengl, pango, python, rubberband, sdl, sdl2 | sdl2-compat, sox, zlib"
CLANDRO_PKG_BUILD_DEPENDS="ladspa-sdk, libarchive, swig"
CLANDRO_PKG_ANTI_BUILD_DEPENDS="sdl2-compat"
CLANDRO_PKG_SUGGESTS="$CLANDRO_PKG_BUILD_DEPENDS"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_FORCE_CMAKE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_INSTALL_LIBDIR=$CLANDRO__PREFIX__LIB_SUBDIR
-DMOD_GLAXNIMATE_QT6=ON
-DMOD_QT6=ON
-DSWIG_PYTHON=ON
"

clandro_step_pre_configure() {
	clandro_setup_python_pip
	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+="
		-DCMAKE_CXX_COMPILER_CLANG_SCAN_DEPS=${CLANDRO_STANDALONE_TOOLCHAIN}/bin/clang-scan-deps
	"

	# Fix linker script error
	LDFLAGS+=" -Wl,--undefined-version"

	# Link openmp library statically
	LDFLAGS+=" -fopenmp -static-openmp"
}
