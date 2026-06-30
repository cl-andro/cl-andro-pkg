CLANDRO_PKG_HOMEPAGE=https://github.com/AndreRH/hangover
CLANDRO_PKG_DESCRIPTION="A compatibility layer for running Windows programs (Hangover fork)"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_LICENSE_FILE="LICENSE, LICENSE.OLD, COPYING.LIB"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="11.4"
CLANDRO_PKG_SRCURL=(
	"https://github.com/AndreRH/wine/archive/refs/tags/hangover-${CLANDRO_PKG_VERSION/\~/-}.tar.gz"
	"https://github.com/AndreRH/hangover/releases/download/hangover-${CLANDRO_PKG_VERSION/\~/-}/hangover_${CLANDRO_PKG_VERSION/\~/-}_ubuntu2204_jammy_arm64.tar"
)
CLANDRO_PKG_SHA256=(
	e6714947e68ee6c7ab03963752945138b60e98b8e24a41cbe8858cf06eb6946d
	95779011771040c1b3d2aff80f57098dfde8e2902ed64b9a80a87608b7a32389
)
CLANDRO_PKG_DEPENDS="fontconfig, freetype, krb5, libandroid-spawn, libc++, libgmp, libgnutls, libxcb, libxcomposite, libxcursor, libxfixes, libxrender, opengl, pulseaudio, sdl2, vulkan-loader, xorg-xrandr"
CLANDRO_PKG_ANTI_BUILD_DEPENDS="vulkan-loader"
CLANDRO_PKG_BUILD_DEPENDS="libandroid-spawn-static, vulkan-loader-generic"
CLANDRO_PKG_NO_STATICSPLIT=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_EXCLUDED_ARCHES="arm, i686, x86_64"

CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS="
--without-x
--disable-tests
"

# Disable userfaultfd syscall as it is missing on older Android, see #25015
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_header_linux_userfaultfd_h=no
enable_wineandroid_drv=no
enable_tools=yes
--prefix=$CLANDRO_PREFIX/opt/hangover-wine
--exec-prefix=$CLANDRO_PREFIX/opt/hangover-wine
--libdir=$CLANDRO_PREFIX/opt/hangover-wine/lib
--with-wine-tools=$CLANDRO_PKG_HOSTBUILD_DIR
--enable-nls
--disable-tests
--without-alsa
--without-capi
--without-coreaudio
--without-cups
--without-dbus
--without-ffmpeg
--with-fontconfig
--with-freetype
--without-gettext
--with-gettextpo=no
--without-gphoto
--with-gnutls
--without-gstreamer
--without-inotify
--with-krb5
--with-mingw=clang
--without-netapi
--without-opencl
--with-opengl
--without-osmesa
--without-oss
--without-pcap
--without-pcsclite
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
--enable-archs=i386,aarch64,arm64ec
"
# TODO: `--enable-archs=arm` doesn't build with option `--with-mingw=clang`, but
# TODO: `arm64ec` doesn't build with option `--with-mingw` (arm64ec-w64-mingw32-clang)

_setup_llvm_mingw_toolchain() {
	# LLVM-mingw's version number must not be the same as the NDK's.
	local _llvm_mingw_version=21
	local _version="20250319"
	local _url="https://github.com/mstorsjo/llvm-mingw/releases/download/$_version/llvm-mingw-$_version-ucrt-ubuntu-20.04-x86_64.tar.xz"
	local _path="$CLANDRO_PKG_CACHEDIR/$(basename $_url)"
	local _sha256sum=ab2a1489416fa82b3e85e88cb877053ee8a591993408caf076737d8de5ae72ca
	clandro_download $_url $_path $_sha256sum
	local _extract_path="$CLANDRO_PKG_CACHEDIR/llvm-mingw-toolchain-$_llvm_mingw_version"
	if [ ! -d "$_extract_path" ]; then
		mkdir -p "$_extract_path"-tmp
		tar -C "$_extract_path"-tmp --strip-component=1 -xf "$_path"
		mv "$_extract_path"-tmp "$_extract_path"
	fi
	export PATH="$_extract_path/bin:$PATH"
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
}

clandro_step_make() {
	make -j $CLANDRO_PKG_MAKE_PROCESSES
}

clandro_step_make_install() {
	make -j $CLANDRO_PKG_MAKE_PROCESSES install

	# Create hangover-wine script
	mkdir -p $CLANDRO_PREFIX/bin
	cat << EOF > $CLANDRO_PREFIX/bin/hangover-wine
#!$CLANDRO_PREFIX/bin/env sh
exec $CLANDRO_PREFIX/opt/hangover-wine/bin/wine "\$@"
EOF
	chmod +x $CLANDRO_PREFIX/bin/hangover-wine
}

clandro_step_post_make_install() {
	# Install FEX-based dlls
	local _type
	for _type in wowbox64 libwow64fex libarm64ecfex; do
		mkdir -p $_type
		cd $_type
		ar -x "$CLANDRO_PKG_SRCDIR"/hangover-${_type}_${CLANDRO_PKG_VERSION/\~/-}_arm64.deb
		tar xf data.tar.xz
		install -Dm644 usr/lib/wine/aarch64-windows/$_type.dll \
			"$CLANDRO_PREFIX"/opt/hangover-wine/lib/wine/aarch64-windows/$_type.dll
		install -Dm644 usr/share/doc/hangover-$_type/copyright \
			"$CLANDRO_PREFIX"/share/doc/hangover-$_type/copyright
		cd -
	done

	# Install LICENSE file for hangover
	mkdir -p "$CLANDRO_PREFIX"/share/doc/hangover
	rm -f "$CLANDRO_PREFIX"/share/doc/hangover/copyright
	curl -L https://raw.githubusercontent.com/AndreRH/hangover/refs/tags/hangover-${CLANDRO_PKG_VERSION/\~/-}/LICENSE \
		-o "$CLANDRO_PREFIX"/share/doc/hangover/copyright
}
