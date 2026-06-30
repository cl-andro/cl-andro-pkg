CLANDRO_PKG_HOMEPAGE=https://github.com/pytorch/torchcodec
CLANDRO_PKG_DESCRIPTION="PyTorch media decoding and encoding"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.11.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://github.com/pytorch/torchcodec/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=86d2b65634a31fc64caf0c6492c392e16296aae2e9f41c2d4be33bf267c088d4
CLANDRO_PKG_DEPENDS="ffmpeg, fmt, google-glog, libc++, python, python-pip, python-torch"
CLANDRO_PKG_BUILD_DEPENDS="pybind11"
CLANDRO_PKG_PYTHON_COMMON_BUILD_DEPS="build"

clandro_step_pre_configure() {
	clandro_setup_cmake
	clandro_setup_ninja

	# (This message is based on the equivalent message in Arch Linux package)
	# setup.py requires setting this to use the system ffmpeg libraries
	# https://github.com/pytorch/torchcodec/blob/1acff9c4cffe8b65f77cd892162cd9ed1b2d75e2/setup.py#L176-L189
	# The Termux ffmpeg package is GPL-licensed (--enable-gpl)
	export I_CONFIRM_THIS_IS_NOT_A_LICENSE_VIOLATION=1

	export TORCH_CMAKE_DIR="$CLANDRO_PYTHON_HOME/site-packages/torch/share/cmake/Torch"
	export PYTHON_EXECUTABLE="$(command -v python)"
}

clandro_step_configure() {
	:
}

clandro_step_make_install() {
	pip -v install --no-build-isolation --no-deps --prefix "$CLANDRO_PREFIX" "$CLANDRO_PKG_SRCDIR"
}
