CLANDRO_PKG_HOMEPAGE=https://opencv.org/
CLANDRO_PKG_DESCRIPTION="Open Source Computer Vision Library"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.13.0"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=(
	"https://github.com/opencv/opencv/archive/refs/tags/${CLANDRO_PKG_VERSION}/opencv-${CLANDRO_PKG_VERSION}.tar.gz"
	"https://github.com/opencv/opencv_contrib/archive/refs/tags/${CLANDRO_PKG_VERSION}/opencv_contrib-${CLANDRO_PKG_VERSION}.tar.gz"
)
CLANDRO_PKG_SHA256=(
	1d40ca017ea51c533cf9fd5cbde5b5fe7ae248291ddf2af99d4c17cf8e13017d
	1e0077a4fd2960a7d2f4c9e49d6ba7bb891cac2d1be36d7e8e47aa97a9d1039b
)
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="abseil-cpp, ffmpeg, libc++, libjpeg-turbo, libopenblas, libpng, libprotobuf, libtiff, libwebp, openjpeg, openjpeg-tools, qt6-qtbase, qt6-qt5compat, zlib"
CLANDRO_PKG_BUILD_DEPENDS="python-numpy-static"
CLANDRO_PKG_PYTHON_COMMON_BUILD_DEPS="Cython, wheel"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_INSTALL_LIBDIR=$CLANDRO__PREFIX__LIB_SUBDIR
-DCMAKE_INSTALL_INCLUDEDIR=$CLANDRO__PREFIX__INCLUDE_SUBDIR
-DANDROID_NO_TERMUX=OFF
-DWITH_GSTREAMER=OFF
-DWITH_OPENEXR=OFF
-DWITH_QT=6
-DBUILD_PERF_TESTS=OFF
-DBUILD_PROTOBUF=OFF
-DBUILD_TESTS=OFF
-DPROTOBUF_UPDATE_FILES=ON
-DOPENCV_EXTRA_MODULES_PATH=$CLANDRO_PKG_SRCDIR/opencv_contrib-$CLANDRO_PKG_VERSION/modules \
-DOPENCV_GENERATE_PKGCONFIG=ON
-DOPENCV_SKIP_CMAKE_CXX_STANDARD=ON
"

clandro_step_pre_configure() {
	clandro_setup_protobuf

	if [ "$CLANDRO_ON_DEVICE_BUILD" = "false" ]; then
		# By default cmake will pick $CLANDRO_PREFIX/bin/protoc, we should avoid it when cross-compiling
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DPROTOBUF_PROTOC_EXECUTABLE=$(command -v protoc)"
	fi

	# Keep this the same version which abseil-cpp requires
	CXXFLAGS+=" -std=c++17"
	LDFLAGS+=" $($CLANDRO_SCRIPTDIR/packages/libprotobuf/interface_link_libraries.sh)"
	LDFLAGS+=" -llog"

	find "$CLANDRO_PKG_SRCDIR" -name CMakeLists.txt -o -name '*.cmake' | \
		xargs -n 1 sed -i \
		-e 's/\([^A-Za-z0-9_]ANDROID\)\([^A-Za-z0-9_]\)/\1_NO_TERMUX\2/g' \
		-e 's/\([^A-Za-z0-9_]ANDROID\)$/\1_NO_TERMUX/g'

	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+="
		-DPYTHON_DEFAULT_EXECUTABLE=python
		-DPYTHON3_INCLUDE_PATH=$CLANDRO_PREFIX/include/python${CLANDRO_PYTHON_VERSION}
		-DPYTHON3_NUMPY_INCLUDE_DIRS=$CLANDRO_PYTHON_HOME/site-packages/numpy/_core/include
		"
}
