CLANDRO_PKG_HOMEPAGE=https://www.winehq.org/
CLANDRO_PKG_DESCRIPTION="A compatibility layer for running Windows programs"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_LICENSE_FILE="LICENSE, LICENSE.OLD, COPYING.LIB"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="11.0"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://dl.winehq.org/wine/source/${CLANDRO_PKG_VERSION%%.*}.0/wine-$CLANDRO_PKG_VERSION.tar.xz
CLANDRO_PKG_SHA256=c07a6857933c1fc60dff5448d79f39c92481c1e9db5aa628db9d0358446e0701
CLANDRO_PKG_DEPENDS="fontconfig, freetype, krb5, libandroid-spawn, libc++, libgmp, libgnutls, libxcb, libxcomposite, libxcursor, libxfixes, libxrender, opengl, pulseaudio, sdl2 | sdl2-compat, vulkan-loader, xorg-xrandr"
CLANDRO_PKG_ANTI_BUILD_DEPENDS="sdl2-compat, vulkan-loader"
CLANDRO_PKG_BUILD_DEPENDS="libandroid-spawn-static, vulkan-loader-generic"
CLANDRO_PKG_NO_STATICSPLIT=true
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS="
--without-x
--disable-tests
"

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_header_linux_userfaultfd_h=no
enable_wineandroid_drv=no
enable_tools=yes
--prefix=$CLANDRO_PREFIX/opt/wine-stable
--exec-prefix=$CLANDRO_PREFIX/opt/wine-stable
--includedir=$CLANDRO_PREFIX/opt/wine-stable/include
--libdir=$CLANDRO_PREFIX/opt/wine-stable/lib
--with-wine-tools=$CLANDRO_PKG_HOSTBUILD_DIR
--enable-nls
--disable-tests
--without-alsa
--without-capi
--without-coreaudio
--without-cups
--without-dbus
--with-fontconfig
--with-freetype
--without-gettext
--with-gettextpo=no
--without-gphoto
--with-gnutls
--without-gstreamer
--without-inotify
--with-krb5
--with-mingw
--without-netapi
--without-opencl
--with-opengl
--without-osmesa
--without-oss
--without-pcap
--with-pthread
--with-pulse
--without-sane
--with-sdl
--without-udev
--without-unwind
--without-usb
--without-v4l2
--with-vulkan
--with-xcomposite
--with-xcursor
--with-xfixes
--without-xinerama
--with-xinput
--with-xinput2
--with-xrandr
--with-xrender
--without-xshape
--without-xshm
--without-xxf86vm
"

# Enable win64 on 64-bit arches.
if [ "$CLANDRO_ARCH_BITS" = 64 ]; then
	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" --enable-win64"
fi

# Enable new WoW64 support on x86_64.
if [ "$CLANDRO_ARCH" = "x86_64" ]; then
	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" --enable-archs=i386,x86_64"
fi

CLANDRO_PKG_EXCLUDED_ARCHES="arm"

_setup_llvm_mingw_toolchain() {
	# LLVM-mingw's version number must not be the same as the NDK's.
	local _llvm_mingw_version=16
	local _version="20230614"
	local _url="https://github.com/mstorsjo/llvm-mingw/releases/download/$_version/llvm-mingw-$_version-ucrt-ubuntu-20.04-x86_64.tar.xz"
	local _path="$CLANDRO_PKG_CACHEDIR/$(basename $_url)"
	local _sha256sum=9ae925f9b205a92318010a396170e69f74be179ff549200e8122d3845ca243b8
	clandro_download $_url $_path $_sha256sum
	local _extract_path="$CLANDRO_PKG_CACHEDIR/llvm-mingw-toolchain-$_llvm_mingw_version"
	if [ ! -d "$_extract_path" ]; then
		mkdir -p "$_extract_path"-tmp
		tar -C "$_extract_path"-tmp --strip-component=1 -xf "$_path"
		mv "$_extract_path"-tmp "$_extract_path"
	fi
	export PATH="$PATH:$_extract_path/bin"
}

clandro_step_host_build() {
	# Setup llvm-mingw toolchain
	_setup_llvm_mingw_toolchain

	# Make host wine-tools
	"$CLANDRO_PKG_SRCDIR/configure" ${CLANDRO_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS}
	make -j "$CLANDRO_PKG_MAKE_PROCESSES" __tooldeps__ nls/all
}

clandro_step_pre_configure() {
	# Setup llvm-mingw toolchain
	_setup_llvm_mingw_toolchain

	# Fix overoptimization
	CPPFLAGS="${CPPFLAGS/-Oz/}"
	CFLAGS="${CFLAGS/-Oz/}"
	CXXFLAGS="${CXXFLAGS/-Oz/}"

	# Disable hardening
	CPPFLAGS="${CPPFLAGS/-fstack-protector-strong/}"
	CFLAGS="${CFLAGS/-fstack-protector-strong/}"
	CXXFLAGS="${CXXFLAGS/-fstack-protector-strong/}"
	LDFLAGS="${LDFLAGS/-Wl,-z,relro,-z,now/}"

	LDFLAGS+=" -landroid-spawn"

	# https://github.com/termux-user-repository/tur/commit/9388bf3599bba33d7bd052cab0679fe9cd5917d2#commitcomment-176464300
	LDFLAGS+=" -Wl,--rosegment"

	if [ "$CLANDRO_ARCH" = "x86_64" ]; then
		mkdir -p "$CLANDRO_PKG_TMPDIR/bin"
		cat <<- EOF > "$CLANDRO_PKG_TMPDIR/bin/x86_64-linux-android-clang"
			#!/bin/bash
			set -- "\${@/-mabi=ms/}"
			exec $CLANDRO_STANDALONE_TOOLCHAIN/bin/x86_64-linux-android-clang "\$@"
		EOF
		chmod +x "$CLANDRO_PKG_TMPDIR/bin/x86_64-linux-android-clang"
		export PATH="$CLANDRO_PKG_TMPDIR/bin:$PATH"
	fi
}

clandro_step_make() {
	make -j $CLANDRO_PKG_MAKE_PROCESSES
}

clandro_step_make_install() {
	make -j $CLANDRO_PKG_MAKE_PROCESSES install

	# Create wine-stable script
	mkdir -p $CLANDRO_PREFIX/bin
	cat << EOF > $CLANDRO_PREFIX/bin/wine-stable
#!$CLANDRO_PREFIX/bin/env sh

exec $CLANDRO_PREFIX/opt/wine-stable/bin/wine "\$@"

EOF
	chmod +x $CLANDRO_PREFIX/bin/wine-stable
}
