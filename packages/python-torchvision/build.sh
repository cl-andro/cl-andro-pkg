CLANDRO_PKG_HOMEPAGE=https://github.com/pytorch/vision
CLANDRO_PKG_DESCRIPTION="Datasets, Transforms and Models specific to Computer Vision"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.26.0"
CLANDRO_PKG_SRCURL="https://github.com/pytorch/vision/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=fb95b6b78b3801c4d4d6332f7a5a0b6c624588e1b39e0d6fa145227b0c749403
CLANDRO_PKG_DEPENDS="libc++, ffmpeg, python, python-numpy, python-pillow, python-pip, python-torch, libjpeg-turbo, libpng, libwebp, zlib"
CLANDRO_PKG_SETUP_PYTHON=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	CXXFLAGS+=" -I${CLANDRO_PYTHON_HOME}/site-packages/torch/include"
	CXXFLAGS+=" -I${CLANDRO_PYTHON_HOME}/site-packages/torch/include/torch/csrc/api/include"
	CXXFLAGS+=" -DUSE_PYTHON"
	LDFLAGS+=" -ltorch_cpu -ltorch_python -lc10"

	# setting this $BUILD_PREFIX variable, which wasn't previously set, causes
	# libwebp to be detected and libjpeg to be detected,
	# and assists with detecting ffmpeg
	export BUILD_PREFIX="$CLANDRO_PREFIX"
	export BUILD_VERSION=$CLANDRO_PKG_VERSION

	# this causes ffmpeg to be detected during cross-compilation,
	# enabling the "video decoder extensions"
	sed -i "s|shutil.which(\"ffmpeg\")|\"$CLANDRO_PREFIX/bin/ffmpeg\"|" setup.py
}

clandro_step_configure() {
	:
}

clandro_step_make_install() {
	pip -v install --no-build-isolation --no-deps --prefix "$CLANDRO_PREFIX" "$CLANDRO_PKG_SRCDIR"
}
