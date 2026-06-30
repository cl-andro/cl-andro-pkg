CLANDRO_PKG_HOMEPAGE=https://liquidsdr.org/
CLANDRO_PKG_DESCRIPTION="Software-defined radio digital signal processing library"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.7.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/jgaeddert/liquid-dsp/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=33c42ebc2e6088570421e282c6332e899705d42b4f73ebd1212e6a11da714dd4
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="fftw"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	autoreconf -fi
}

clandro_step_post_massage() {
	shopt -s nullglob
	local f
	for f in lib/libliquid.a.*; do
		clandro_error_exit "File ${f} should not be contained herein."
	done
	shopt -u nullglob
}
