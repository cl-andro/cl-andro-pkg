CLANDRO_PKG_HOMEPAGE=https://github.com/FluidSynth/fluidsynth
CLANDRO_PKG_DESCRIPTION="Software synthesizer based on the SoundFont 2 specifications"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.5.4"
CLANDRO_PKG_SRCURL=https://github.com/FluidSynth/fluidsynth/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=72f5720328fe44e2e5c67813885f0a6b4b004d048bd2eeeb0c0064074ebff530
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="dbus, glib, libc++, libsndfile, pulseaudio, readline"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DLIB_INSTALL_DIR=${CLANDRO_PREFIX}/lib
"

clandro_step_pre_configure() {
	LDFLAGS+=" -l:libomp.a"
}
