CLANDRO_PKG_HOMEPAGE=https://www.mumble.info/
CLANDRO_PKG_DESCRIPTION="Server module for Mumble, an open source voice-chat software"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.5.517"
CLANDRO_PKG_REVISION=16
CLANDRO_PKG_SRCURL=git+https://github.com/mumble-voip/mumble
CLANDRO_PKG_DEPENDS="libc++, libcap, libprotobuf, openssl, qt5-qtbase"
CLANDRO_PKG_BUILD_DEPENDS="boost, boost-headers, qt5-qtbase-cross-tools"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dclient=OFF
-Dice=OFF
-Doverlay=OFF
-Dwarnings-as-errors=OFF
-Dzeroconf=OFF
"
CLANDRO_PKG_RM_AFTER_INSTALL="
etc/systemd
"

clandro_step_pre_configure() {
	clandro_setup_protobuf

	if [ "$CLANDRO_ON_DEVICE_BUILD" = "false" ]; then
		# By default cmake will pick $CLANDRO_PREFIX/bin/protoc, we should avoid it on CI
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -Dprotobuf_generate_PROTOC_EXE=$(command -v protoc)"
	fi

	LDFLAGS+=" -lcap"

	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -Dprotobuf_PROTOC_EXE=$(command -v protoc)"
	sed -i 's/COMMAND\sprotobuf::protoc/COMMAND ${protobuf_PROTOC_EXE}/g' $CLANDRO_PREFIX/lib/cmake/protobuf/protobuf-generate.cmake
}

clandro_step_post_make_install() {
	ln -sfT mumble-server $CLANDRO_PREFIX/bin/murmurd
	install -Dm600 -t $CLANDRO_PREFIX/share/doc/mumble-server/examples \
		$CLANDRO_PKG_SRCDIR/auxiliary_files/mumble-server.ini
	chmod 0700 $CLANDRO_PREFIX/bin/mumble-server-user-wrapper
}

clandro_step_post_massage() {
	rm -f lib/cmake/protobuf/protobuf-generate.cmake
	find . -type d -empty -delete
}
