CLANDRO_PKG_HOMEPAGE=https://www.softether.org/
CLANDRO_PKG_DESCRIPTION="An open-source cross-platform multi-protocol VPN program"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=(5.2.5188)
CLANDRO_PKG_VERSION+=(1.0.20)
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=(https://github.com/SoftEtherVPN/SoftEtherVPN/releases/download/${CLANDRO_PKG_VERSION}/SoftEtherVPN-${CLANDRO_PKG_VERSION}.tar.xz
                   https://github.com/jedisct1/libsodium/archive/refs/tags/${CLANDRO_PKG_VERSION[1]}-RELEASE.tar.gz)
CLANDRO_PKG_SHA256=(e89278e7edd7e137bd521851b42c2bf9ce4e5cae2489db406588d3388646b147
                   8e5aeca07a723a27bbecc3beef14b0068d37e7fc0e97f51b3f1c82d2a58005c1)
CLANDRO_PKG_DEPENDS="libiconv, libsodium, ncurses, openssl, readline, resolv-conf, zlib"
CLANDRO_PKG_BUILD_DEPENDS="dos2unix"
CLANDRO_PKG_FORCE_CMAKE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_INSTALL_LIBDIR=$CLANDRO__PREFIX__LIB_SUBDIR
-DCMAKE_INSTALL_INCLUDEDIR=$CLANDRO__PREFIX__INCLUDE_SUBDIR
-DHAS_SSE2=OFF
"
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_RM_AFTER_INSTALL="lib/systemd"

clandro_step_post_get_source() {
	mv libsodium-${CLANDRO_PKG_VERSION[1]}-RELEASE libsodium

	# convert CRLF to LF like in libpluto package
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		DOS2UNIX="$CLANDRO_PKG_TMPDIR/dos2unix"
		(. "$CLANDRO_SCRIPTDIR/packages/dos2unix/build.sh"; CLANDRO_PKG_SRCDIR="$DOS2UNIX" clandro_step_get_source)
		pushd "$DOS2UNIX"
		make dos2unix
		popd # DOS2UNIX
		export PATH="$DOS2UNIX:$PATH"
	fi

	find "$CLANDRO_PKG_SRCDIR" -type f -print0 | xargs -0 dos2unix
}

clandro_step_host_build() {
	local _PREFIX_FOR_BUILD=$CLANDRO_PKG_HOSTBUILD_DIR/prefix
	mkdir -p $_PREFIX_FOR_BUILD
	mkdir -p libsodium
	pushd libsodium
	$CLANDRO_PKG_SRCDIR/libsodium/configure --prefix=$_PREFIX_FOR_BUILD
	make -j $CLANDRO_PKG_MAKE_PROCESSES
	make install
	popd

	export PKG_CONFIG_PATH=$_PREFIX_FOR_BUILD/lib/pkgconfig

	clandro_setup_cmake
	cmake $CLANDRO_PKG_SRCDIR
	make -j $CLANDRO_PKG_MAKE_PROCESSES

	unset PKG_CONFIG_PATH
}

clandro_step_post_configure() {
	export PATH=$CLANDRO_PKG_HOSTBUILD_DIR/src/hamcorebuilder:$PATH
}
