CLANDRO_PKG_HOMEPAGE=https://www.surina.net/soundtouch/
CLANDRO_PKG_DESCRIPTION="An open-source audio processing library for changing the Tempo, Pitch and Playback Rates of audio streams or files"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.3.3
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://www.surina.net/soundtouch/soundtouch-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=43b23dfac2f64a3aff55d64be096ffc7b73842c3f5665caff44975633a975a99
CLANDRO_PKG_DEPENDS="libc++"

clandro_step_pre_configure() {
	autoreconf -fi

	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}
