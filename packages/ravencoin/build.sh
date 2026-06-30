CLANDRO_PKG_HOMEPAGE=https://ravencoin.org/
CLANDRO_PKG_DESCRIPTION="A peer-to-peer blockchain, handling the efficient creation and transfer of assets from one party to another"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.6.1"
CLANDRO_PKG_REVISION=9
CLANDRO_PKG_SRCURL="https://github.com/RavenProject/Ravencoin/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=42e8444e9e21eecfed1a546dffe6f2418271e890038a7d9d9a856b376a6284e8
CLANDRO_PKG_DEPENDS="boost, libc++, libevent, libzmq, miniupnpc, openssl"
CLANDRO_PKG_BUILD_DEPENDS="boost-headers, libdb"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-tests
--disable-wallet
--with-boost=$CLANDRO_PREFIX/lib
--with-boost-libdir=$CLANDRO_PREFIX/lib
"

clandro_step_pre_configure() {
	autoreconf -fi

	# make sure that when this file no longer exists, this block is removed.
	# (context: the Ubuntu 24.04 builder image has autoconf-archive 20220903-3,
	# and this conflicts with the use of 'autoreconf -fi'
	# in packages which are being built against boost 1.89)
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		local file=/usr/share/aclocal/ax_boost_system.m4
		if [[ ! -f "$file" ]]; then
			clandro_error_exit "$file no longer exists. Please edit $CLANDRO_PKG_NAME's build.sh to remove this block."
		fi
		# remove this line too after the above check fails
		# (it willl no longer be necessary when the above check fails):
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" ax_cv_boost_system=yes --without-boost-system"
	fi

	local _libgcc_file="$($CC -print-libgcc-file-name)"
	local _libgcc_path="$(dirname $_libgcc_file)"
	local _libgcc_name="$(basename $_libgcc_file)"
	LDFLAGS+=" -L$_libgcc_path -l:$_libgcc_name"
}
