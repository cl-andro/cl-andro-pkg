CLANDRO_PKG_HOMEPAGE=https://www.radare.org/
CLANDRO_PKG_DESCRIPTION="UNIX-like reverse engineering framework and command-line toolset"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.1.4"
CLANDRO_PKG_SRCURL=https://github.com/radareorg/radare2/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=e025d623aa253e20b050164e65f140e437c110812a7b4c8b1b1342f692dfb452
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libuv"
CLANDRO_PKG_BREAKS="radare2-dev"
CLANDRO_PKG_REPLACES="radare2-dev"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--with-compiler=termux-host"

clandro_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $CLANDRO_PREFIX.
	if $CLANDRO_ON_DEVICE_BUILD; then
		clandro_error_exit "Package '$CLANDRO_PKG_NAME' is not safe for on-device builds."
	fi

	# Unset CPPFLAGS to avoid -I$CLANDRO_PREFIX/include. This is because
	# radare2 build will put its own -I flags after ours, which causes
	# problems due to name clashes (binutils header files).
	unset CPPFLAGS

	# If this variable is not set, then build will fail on linking with 'pthread'
	export ANDROID=1

	export OBJCOPY=$CLANDRO_HOST_PLATFORM-objcopy

	# Remove old libs which may mess with new build:
	rm -f $CLANDRO_PREFIX/lib/libr_*
}
