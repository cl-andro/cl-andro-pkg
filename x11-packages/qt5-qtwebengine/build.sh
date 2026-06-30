CLANDRO_PKG_HOMEPAGE=https://github.com/qt/qtwebengine
CLANDRO_PKG_DESCRIPTION="Qt 5 Web Engine Library"
CLANDRO_PKG_LICENSE="LGPL-3.0, GPL-2.0, GPL-3.0, BSD 3-Clause"
CLANDRO_PKG_LICENSE_FILE="LICENSE.LGPL3, LICENSE.GPL2, LICENSE.GPL3, LICENSE.Chromium"
CLANDRO_PKG_MAINTAINER="@licy183"
CLANDRO_PKG_VERSION="5.15.19"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=git+https://github.com/qt/qtwebengine
CLANDRO_PKG_GIT_BRANCH=v$CLANDRO_PKG_VERSION-lts
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_DEPENDS="dbus, fontconfig, libc++, libexpat, libjpeg-turbo, libminizip, libnspr, libnss, libopus, libpng, libsnappy, libvpx, libwebp, libx11, libxkbfile, qt5-qtbase, qt5-qtdeclarative, zlib"
CLANDRO_PKG_BUILD_DEPENDS="libdrm, qt5-qtbase-cross-tools, qt5-qtdeclarative-cross-tools"
CLANDRO_PKG_NO_STATICSPLIT=true
CLANDRO_PKG_HOSTBUILD=true

clandro_step_host_build() {
	# Generate ffmpeg headers for i686
	mkdir -p fake-bin
	ln -s "$CLANDRO_HOST_LLVM_BASE_DIR/bin/clang" fake-bin/clang
	ln -s "$CLANDRO_HOST_LLVM_BASE_DIR/bin/clang++" fake-bin/clang++

	# Remove python3 compatibility file preventing using newer python3 versions:
	rm $CLANDRO_PKG_SRCDIR/src/3rdparty/chromium/third_party/ffmpeg/chromium/scripts/enum.py

	PATH="$PWD/fake-bin:$PATH" python3 $CLANDRO_PKG_SRCDIR/src/3rdparty/chromium/third_party/ffmpeg/chromium/scripts/build_ffmpeg.py --config-only linux noasm-ia32
}

clandro_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $CLANDRO_PREFIX.
	if $CLANDRO_ON_DEVICE_BUILD; then
		clandro_error_exit "Package '$CLANDRO_PKG_NAME' is not safe for on-device builds."
	fi
}

clandro_step_configure() {
	cd $CLANDRO_PKG_SRCDIR
	clandro_setup_ninja
	clandro_setup_nodejs

	# https://gitweb.gentoo.org/repo/gentoo.git/commit/?id=adb049350a5d4b15b5ee19739d9f2baed83f6acf
	export LDFLAGS+=" -Wl,--undefined-version"

	# Remove termux's dummy pkg-config
	local _host_pkg_config="$(cat $(command -v pkg-config) | grep exec | awk '{print $2}')"
	rm -rf $CLANDRO_PKG_TMPDIR/host-pkg-config-bin
	mkdir -p $CLANDRO_PKG_TMPDIR/host-pkg-config-bin
	ln -s $_host_pkg_config $CLANDRO_PKG_TMPDIR/host-pkg-config-bin/pkg-config
	ln -s $(command -v pkg-config) $CLANDRO_PKG_TMPDIR/host-pkg-config-bin/$CLANDRO_HOST_PLATFORM-pkg-config
	export PATH="$CLANDRO_PKG_TMPDIR/host-pkg-config-bin:$PATH"

	# Create dummy sysroot
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

	# Dummy pthread, rt and resolve
	# TODO: Patch the building system and do not dummy `librt.so`.
	echo "INPUT(-llog -liconv -landroid-shmem)" > "$CLANDRO_PREFIX/lib/librt.so"
	echo '!<arch>' > "$CLANDRO_PREFIX/lib/libpthread.a"
	echo '!<arch>' > "$CLANDRO_PREFIX/lib/libresolv.a"

	# Copy ffmpeg headers for i686. They are generated without asm.
	rm -rf src/3rdparty/chromium/third_party/ffmpeg/chromium/config/{Chrome,Chromium}/linux-noasm/ia32
	mkdir -p src/3rdparty/chromium/third_party/ffmpeg/chromium/config/{Chrome,Chromium}/linux-noasm/ia32
	cp -Rfv $CLANDRO_PKG_HOSTBUILD_DIR/build.ia32.linux-noasm/Chrome/* src/3rdparty/chromium/third_party/ffmpeg/chromium/config/Chrome/linux-noasm/ia32
	cp -Rfv $CLANDRO_PKG_HOSTBUILD_DIR/build.ia32.linux-noasm/Chromium/* src/3rdparty/chromium/third_party/ffmpeg/chromium/config/Chromium/linux-noasm/ia32
	cp -fv src/3rdparty/chromium/third_party/ffmpeg/chromium/config/Chrome/linux-noasm/{x64,ia32}/libavutil/ffversion.h
	cp -fv src/3rdparty/chromium/third_party/ffmpeg/chromium/config/Chromium/linux-noasm/{x64,ia32}/libavutil/ffversion.h

	# Do not run ninja -v, unless NINJAFLAGS is set
	: ${NINJAFLAGS:=" "}
	export NINJAFLAGS

	cd $CLANDRO_PKG_BUILDDIR/

	"${CLANDRO_PREFIX}/opt/qt/cross/bin/qmake" \
		$CLANDRO_PKG_SRCDIR \
		QT_CONFIG-=no-pkg-config \
		DUMMY_SYSROOT=$CLANDRO_PKG_TMPDIR/sysroot \
		PKG_CONFIG_SYSROOT_DIR= \
		PKG_CONFIG_LIBDIR=$PKG_CONFIG_LIBDIR \
		PKG_CONFIG_EXECUTABLE=$(command -v pkg-config)
}

clandro_step_post_make_install() {
	#######################################################
	##
	##  Fixes & cleanup.
	##
	#######################################################

	## Drop QMAKE_PRL_BUILD_DIR because reference the build dir.
	find "${CLANDRO_PREFIX}/lib" -type f -name "libQt5WebEngine*.prl" \
		-exec sed -i -e '/^QMAKE_PRL_BUILD_DIR/d' "{}" \;

	## Remove *.la files.
	find "${CLANDRO_PREFIX}/lib" -iname \*.la -delete

	# Remove dummy files
	rm $CLANDRO_PREFIX/lib/lib{{pthread,resolv}.a,rt.so}
}

clandro_step_post_massage() {
	# Replace version for cmake
	local _QT_BASE_VERSION=$(. $CLANDRO_SCRIPTDIR/x11-packages/qt5-qtbase/build.sh; echo $CLANDRO_PKG_VERSION)
	sed -e "s|$CLANDRO_PKG_VERSION\ |$_QT_BASE_VERSION |" -i lib/cmake/*/*Config.cmake
}
