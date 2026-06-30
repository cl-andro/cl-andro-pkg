CLANDRO_PKG_HOMEPAGE=https://jackaudio.org/
CLANDRO_PKG_DESCRIPTION="The JACK low-latency audio server"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_VERSION=1.9.22
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://github.com/jackaudio/jack2/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=1e42b9fc4ad7db7befd414d45ab2f8a159c0b30fcd6eee452be662298766a849
CLANDRO_PKG_DEPENDS="alsa-lib, dbus, libandroid-posix-semaphore, libdb, libexpat, libsamplerate, libopus"
# CLANDRO_PKG_CONFLICTS="pipewire-jack"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_configure() {
	LDFLAGS+=" -landroid-posix-semaphore"
	python3 ./waf configure --alsa --classic --prefix="$CLANDRO_PREFIX" --htmldir=$CLANDRO_PREFIX/share/doc/jack2/html --firewire=no
}

clandro_step_make() {
	python3 ./waf build
}

clandro_step_make_install() {
	python3 ./waf install
}
