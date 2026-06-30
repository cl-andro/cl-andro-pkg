CLANDRO_PKG_HOMEPAGE=https://godotengine.org
CLANDRO_PKG_DESCRIPTION="Advanced cross-platform 2D and 3D game engine"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.6.2"
CLANDRO_PKG_SRCURL="https://github.com/godotengine/godot/archive/refs/tags/$CLANDRO_PKG_VERSION-stable.tar.gz"
CLANDRO_PKG_SHA256=908b759e7517fec65d687b3d468cd639fd8967d25da1522ef8a2087af638b3fe
CLANDRO_PKG_DEPENDS="brotli, ca-certificates, fontconfig, freetype, glu, libandroid-execinfo, libc++, libenet, libgraphite, libjpeg-turbo, libogg, libtheora, libvorbis, libvpx, libwebp, libwslay, libxcursor, libxi, libxinerama, libxkbcommon, libxrandr, mbedtls, miniupnpc, opengl, opusfile, pcre2, python, sdl3, speechd, zlib, zstd"
CLANDRO_PKG_BUILD_DEPENDS="pulseaudio, yasm"
CLANDRO_PKG_PYTHON_COMMON_BUILD_DEPS="scons"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP='\d+\.\d+(\.\d+)?(?=-stable)'
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make() {
	local to_unbundle="" system_libs=""

	to_unbundle+="brotli "
	to_unbundle+="enet "
	to_unbundle+="freetype "
	to_unbundle+="graphite "
	to_unbundle+="libjpeg-turbo "
	to_unbundle+="libogg "
	to_unbundle+="libtheora "
	to_unbundle+="libvorbis "
	to_unbundle+="libvpx "
	to_unbundle+="libwebp "
	to_unbundle+="mbedtls "
	to_unbundle+="miniupnpc "
	to_unbundle+="opus "
	to_unbundle+="pcre2 "
	to_unbundle+="sdl "
	to_unbundle+="wslay "
	to_unbundle+="zlib "
	to_unbundle+="zstd "

	for _lib in $to_unbundle; do
		rm -fr thirdparty/$_lib
		system_libs+="builtin_${_lib//-/_}=no "
	done

	echo "$system_libs"

	local _ARCH
	case $CLANDRO_ARCH in
		aarch64) _ARCH=arm64;;
		arm) _ARCH=arm32;;
		x86_64) _ARCH=x86_64;;
		i686) _ARCH=x86_32;;
	esac

	local debug=""
	if [[ "$CLANDRO_DEBUG_BUILD" == "true" ]]; then
		# godot has a lot of possible weird debug settings,
		# so if CLANDRO_DEBUG_BUILD=true, enable a sane set
		# of two that seem appropriate and compatible with
		# the typical termux package debugging workflow
		debug+="debug_symbols=yes "
		debug+="optimize=debug "
	fi

	export BUILD_NAME=termux
	scons -j$CLANDRO_PKG_MAKE_PROCESSES \
		use_static_cpp=no \
		colored=yes \
		platform=linuxbsd \
		alsa=no \
		execinfo=yes \
		pulseaudio=yes \
		udev=no \
		module_camera_enabled=no \
		arch=$_ARCH \
		system_certs_path=$CLANDRO_PREFIX/etc/tls/cert.pem \
		use_llvm=yes \
		AR="$(command -v $AR)" \
		CC="$(command -v $CC)" \
		CXX="$(command -v $CXX)" \
		OBJCOPY="$(command -v $OBJCOPY)" \
		STRIP="$(command -v $STRIP)" \
		cflags="$CPPFLAGS $CFLAGS" \
		cxxflags="$CPPFLAGS $CXXFLAGS" \
		linkflags="$LDFLAGS -landroid-execinfo -lturbojpeg" \
		CPPPATH="$CLANDRO_PREFIX/include" \
		LIBPATH="$CLANDRO_PREFIX/lib" \
		$system_libs \
		$debug \
		verbose=1

	mv $CLANDRO_PKG_BUILDDIR/bin/godot.linuxbsd.editor.$_ARCH.llvm $CLANDRO_PKG_BUILDDIR/bin/godot.linuxbsd.editor.llvm
}

clandro_step_make_install() {
	install -Dm644 misc/dist/linux/org.godotengine.Godot.desktop $CLANDRO_PREFIX/share/applications/godot.desktop
	install -Dm644 icon.svg $CLANDRO_PREFIX/share/pixmaps/godot.svg
	install -Dm644 LICENSE.txt $CLANDRO_PREFIX/share/licenses/godot/LICENSE
	install -Dm755 $CLANDRO_PKG_BUILDDIR/bin/godot.linuxbsd.editor.llvm $CLANDRO_PREFIX/bin/godot
	install -Dm644 $CLANDRO_PKG_BUILDDIR/misc/dist/linux/godot.6 $CLANDRO_PREFIX/share/man/man6/godot.6
	install -Dm644 $CLANDRO_PKG_BUILDDIR/misc/dist/linux/org.godotengine.Godot.xml $CLANDRO_PREFIX/share/mime/packages/org.godotengine.Godot.xml
}
