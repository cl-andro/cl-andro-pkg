CLANDRO_PKG_HOMEPAGE=https://www.freedesktop.org/software/pulseaudio/webrtc-audio-processing/
CLANDRO_PKG_DESCRIPTION="A library containing the AudioProcessing module from the WebRTC project"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.3
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_SRCURL=https://www.freedesktop.org/software/pulseaudio/webrtc-audio-processing/webrtc-audio-processing-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=95552fc17faa0202133707bbb3727e8c2cf64d4266fe31bfdb2298d769c1db75
CLANDRO_PKG_DEPENDS="libc++, abseil-cpp"

clandro_step_pre_configure() {
	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}
