CLANDRO_PKG_HOMEPAGE=https://dbus.freedesktop.org
CLANDRO_PKG_DESCRIPTION="Freedesktop.org message bus system"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.16.2"
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL="https://dbus.freedesktop.org/releases/dbus/dbus-$CLANDRO_PKG_VERSION.tar.xz"
CLANDRO_PKG_SHA256=0ba2a1a4b16afe7bceb2c07e9ce99a8c2c3508e5dec290dbb643384bd6beb7e2
CLANDRO_PKG_DEPENDS="libexpat, libx11"
CLANDRO_PKG_BREAKS="dbus-dev"
CLANDRO_PKG_REPLACES="dbus-dev"

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dlibaudit=disabled
-Dsystemd=disabled
-Dmodular_tests=disabled
-Dx11_autolaunch=enabled
-Dtest_socket_dir=$CLANDRO_PREFIX/tmp
-Dsession_socket_dir=$CLANDRO_PREFIX/tmp
"

clandro_step_pre_configure() {
	export LIBS="-llog"
	# Enforce meson building
	rm CMakeLists.txt

	if [[ "$CLANDRO_DEBUG_BUILD" == "true" ]]; then
		# How to get extra-verbose logging:
		# 1. build with -Dverbose_mode=true
		# 2. use export DBUS_VERBOSE=1
		# 3. launch DBus with --nofork, for example:
		#    DBUS_VERBOSE=1 dbus-daemon --system --nofork
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -Dverbose_mode=true"
	fi
}

clandro_step_post_make_install() {
	mkdir -p $CLANDRO_PREFIX/var/run/dbus
	echo "dbus needs this folder to put pid and system_bus_socket" >> $CLANDRO_PREFIX/var/run/dbus/README.dbus
}

clandro_step_create_debscripts() {
	{
		echo "#!${CLANDRO_PREFIX}/bin/sh"
		echo "if [ ! -e ${CLANDRO_PREFIX}/var/lib/dbus/machine-id ]; then"
		echo "mkdir -p ${CLANDRO_PREFIX}/var/lib/dbus"
		echo "dbus-uuidgen > ${CLANDRO_PREFIX}/var/lib/dbus/machine-id"
		echo "fi"
		echo "exit 0"
	} > postinst
}
