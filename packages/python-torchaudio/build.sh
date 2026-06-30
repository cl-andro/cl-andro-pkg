CLANDRO_PKG_HOMEPAGE=https://github.com/pytorch/audio
CLANDRO_PKG_DESCRIPTION="Data manipulation and transformation for audio signal processing, powered by PyTorch"
CLANDRO_PKG_LICENSE="BSD 2-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.11.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://github.com/pytorch/audio/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=599ec24e7e1eef476ef21f0178e33da00e2434f930ba42e9cc20bf4002220486
CLANDRO_PKG_DEPENDS="libc++, python, python-pip, python-torch, python-torchcodec"
CLANDRO_PKG_PYTHON_COMMON_BUILD_DEPS="wheel, setuptools"
CLANDRO_PKG_PYTHON_CROSS_BUILD_DEPS="numpy, torch"

clandro_step_make_install() {
	pip -v install --no-build-isolation --no-deps --prefix "$CLANDRO_PREFIX" "$CLANDRO_PKG_SRCDIR"
}
