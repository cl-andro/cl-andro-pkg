CLANDRO_PKG_HOMEPAGE=https://zeromq.org/
CLANDRO_PKG_DESCRIPTION="Fast messaging system built on sockets. C and C++ bindings. aka 0MQ, ZMQ."
CLANDRO_PKG_LICENSE="LGPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.3.5"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://github.com/zeromq/libzmq/releases/download/v${CLANDRO_PKG_VERSION}/zeromq-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=6653ef5910f17954861fe72332e68b03ca6e4d9c7160eb3a8de5a5a913bfab43
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++, libsodium"
CLANDRO_PKG_BREAKS="libzmq-dev"
CLANDRO_PKG_REPLACES="libzmq-dev"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--with-libsodium --disable-libunwind --disable-Werror"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=5

	local e=$(sed -En 's/^LTVER="?([0-9]+):([0-9]+):([0-9]+).*/\1-\3/p' \
				configure.ac)
	if [ ! "${e}" ] || [ "${_SOVERSION}" != "$(( "${e}" ))" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}

clandro_step_pre_configure() {
	./autogen.sh

	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}
