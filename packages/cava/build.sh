# Contributor: @Neo-Oli
CLANDRO_PKG_HOMEPAGE=https://github.com/karlstav/cava
CLANDRO_PKG_DESCRIPTION="Console-based Audio Visualizer. Works with MPD and Pulseaudio"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="Oliver Schmidhauser @Neo-Oli"
CLANDRO_PKG_VERSION="0.10.7"
CLANDRO_PKG_SRCURL=https://github.com/karlstav/cava/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=43f994f7e609fab843af868d8a7bc21471ac62c5a4724ef97693201eac42e70a
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="fftw, libiniparser, ncurses, pulseaudio"
CLANDRO_PKG_BUILD_DEPENDS="libtool"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	./autogen.sh
}
