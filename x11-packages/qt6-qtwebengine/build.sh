CLANDRO_PKG_HOMEPAGE=https://www.qt.io/
CLANDRO_PKG_DESCRIPTION="Qt 6 WebEngine Library"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@licy183"
CLANDRO_PKG_VERSION="6.11.0"
CLANDRO_PKG_SRCURL="https://download.qt.io/official_releases/qt/${CLANDRO_PKG_VERSION%.*}/${CLANDRO_PKG_VERSION}/submodules/qtwebengine-everywhere-src-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=63b921c8b2dd59152ced9a796676010166df044588ee00ef9429dc2fd2146736
CLANDRO_PKG_DEPENDS="dbus, fontconfig, libc++, libexpat, libjpeg-turbo, libminizip, libnspr, libnss, libopus, libpng, libsnappy, libvpx, libwebp, libx11, libxkbfile, mesa, pulseaudio, qt6-qtbase (>= ${CLANDRO_PKG_VERSION}), qt6-qtdeclarative (>= ${CLANDRO_PKG_VERSION}), qt6-qtwebchannel (>= ${CLANDRO_PKG_VERSION}), zlib"
CLANDRO_PKG_BUILD_DEPENDS="qt6-qtbase-cross-tools, qt6-qtdeclarative-cross-tools"
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_NO_STATICSPLIT=true
CLANDRO_PKG_ON_DEVICE_BUILD_NOT_SUPPORTED=true
# Qt6-Webengine doesn't support cross-compile for i386.
CLANDRO_PKG_EXCLUDED_ARCHES="i686"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_MESSAGE_LOG_LEVEL=STATUS
-DCMAKE_SYSTEM_NAME=Linux
-DTEST_glibc=ON
-DQT_GENERATE_SBOM=OFF
-DQT_FEATURE_webengine_system_alsa=OFF
-DQT_FEATURE_webengine_system_pulseaudio=ON
-DQT_FEATURE_webengine_proprietary_codecs=ON
"

clandro_step_host_build() {
	clandro_setup_cmake
	clandro_setup_ninja

	mkdir -p host-gn-build
	pushd host-gn-build
	cmake \
		-G Ninja \
		-S ${CLANDRO_PKG_SRCDIR}/src/gn \
		-DCMAKE_BUILD_TYPE=MinSizeRel
	ninja -j $CLANDRO_PKG_MAKE_PROCESSES
	popd # host-gn-build
}

clandro_step_configure() {
	clandro_setup_cmake
	clandro_setup_ninja
	clandro_setup_nodejs

	export PATH="$CLANDRO_PKG_HOSTBUILD_DIR/host-gn-build/MinSizeRel:$PATH"

	# Remove termux's dummy pkg-config
	local _host_pkg_config="$(cat $(command -v pkg-config) | grep exec | awk '{print $2}')"
	rm -rf $CLANDRO_PKG_TMPDIR/host-pkg-config-bin
	mkdir -p $CLANDRO_PKG_TMPDIR/host-pkg-config-bin
	ln -s $_host_pkg_config $CLANDRO_PKG_TMPDIR/host-pkg-config-bin/pkg-config
	ln -s $(command -v pkg-config) $CLANDRO_PKG_TMPDIR/host-pkg-config-bin/$CLANDRO_HOST_PLATFORM-pkg-config
	export PATH="$CLANDRO_PKG_TMPDIR/host-pkg-config-bin:$PATH"

	# Create dummy sysroot
	if [ ! -d "$CLANDRO_PKG_CACHEDIR/sysroot-$CLANDRO_ARCH" ]; then
		rm -rf $CLANDRO_PKG_TMPDIR/sysroot
		mkdir -p $CLANDRO_PKG_TMPDIR/sysroot
		pushd $CLANDRO_PKG_TMPDIR/sysroot
		mkdir -p usr/include usr/lib usr/bin
		cp -R $CLANDRO_STANDALONE_TOOLCHAIN/sysroot/usr/include/* usr/include
		cp -R $CLANDRO_STANDALONE_TOOLCHAIN/sysroot/usr/include/$CLANDRO_HOST_PLATFORM/* usr/include
		cp -R $CLANDRO_STANDALONE_TOOLCHAIN/sysroot/usr/lib/$CLANDRO_HOST_PLATFORM/$CLANDRO_PKG_API_LEVEL/* usr/lib/
		cp "$CLANDRO_STANDALONE_TOOLCHAIN/sysroot/usr/lib/$CLANDRO_HOST_PLATFORM/libc++_shared.so" usr/lib/
		cp "$CLANDRO_STANDALONE_TOOLCHAIN/sysroot/usr/lib/$CLANDRO_HOST_PLATFORM/libc++_static.a" usr/lib/
		cp "$CLANDRO_STANDALONE_TOOLCHAIN/sysroot/usr/lib/$CLANDRO_HOST_PLATFORM/libc++abi.a" usr/lib/
		cp -Rf $CLANDRO_PREFIX/include/* usr/include
		cp -Rf $CLANDRO_PREFIX/lib/* usr/lib
		ln -sf /data ./data
		popd
		mv $CLANDRO_PKG_TMPDIR/sysroot $CLANDRO_PKG_CACHEDIR/sysroot-$CLANDRO_ARCH
	fi

	# Dummy pthread, rt and resolve
	# TODO: Patch the building system and do not dummy `librt.so`.
	echo "INPUT(-llog -liconv -landroid-shmem)" > "$CLANDRO_PREFIX/lib/librt.so"
	echo '!<arch>' > "$CLANDRO_PREFIX/lib/libpthread.a"
	echo '!<arch>' > "$CLANDRO_PREFIX/lib/libresolv.a"

	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DDUMMY_SYSROOT=$CLANDRO_PKG_CACHEDIR/sysroot-$CLANDRO_ARCH"

	: ${NINJAFLAGS:=""}
	export NINJAFLAGS

	clandro_step_configure_cmake
}

clandro_step_make_install() {
	cmake \
		--install "${CLANDRO_PKG_BUILDDIR}" \
		--prefix "${CLANDRO_PREFIX}" \
		--verbose

	# Drop QMAKE_PRL_BUILD_DIR because reference the build dir
	find "${CLANDRO_PREFIX}/lib" -type f -name "libQt6Pdf*.prl" \
		-exec sed -i -e '/^QMAKE_PRL_BUILD_DIR/d' "{}" \;
	find "${CLANDRO_PREFIX}/lib" -type f -name "libQt6WebEngine*.prl" \
		-exec sed -i -e '/^QMAKE_PRL_BUILD_DIR/d' "{}" \;

	# Remove *.la files
	find "${CLANDRO_PREFIX}/lib" -iname \*.la -delete
}

clandro_step_post_make_install() {
	# Remove the dummy files
	rm $CLANDRO_PREFIX/lib/lib{{pthread,resolv}.a,rt.so}
}
