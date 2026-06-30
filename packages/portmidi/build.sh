CLANDRO_PKG_HOMEPAGE=https://github.com/PortMidi/portmidi
CLANDRO_PKG_DESCRIPTION="A cross-platform MIDI input/output library"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.0.7"
CLANDRO_PKG_SRCURL=https://github.com/PortMidi/portmidi/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=43fa65b4ed7ebaa68b0028a538ba8b2ca4dc9b86a7e22ec48842070e010f823f
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DLINUX_DEFINES=PMNULL
"

clandro_step_post_massage() {
	cd ${CLANDRO_PKG_MASSAGEDIR}/${CLANDRO_PREFIX}/lib || exit 1
	if [ ! -e "./libporttime.so" ]; then
		ln -sf libportmidi.so libporttime.so
	fi
}
