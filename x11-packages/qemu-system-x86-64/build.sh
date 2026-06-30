CLANDRO_PKG_HOMEPAGE=https://www.qemu.org
CLANDRO_PKG_DESCRIPTION="A generic and open source machine emulator and virtualizer"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1:10.2.1"
CLANDRO_PKG_SRCURL="https://download.qemu.org/qemu-${CLANDRO_PKG_VERSION:2}.tar.xz"
CLANDRO_PKG_SHA256=a3717477d8e2c84d630bfffbc20f6cd3293eb45aa1e6dac6d0cc27689991c9e1
CLANDRO_PKG_DEPENDS="alsa-lib, dtc, gdk-pixbuf, glib, jack2, gtk3, libbz2, libcairo, libcurl, libdw, libepoxy, libgmp, libgnutls, libiconv, libjpeg-turbo, liblzo, libnettle, libnfs, libpixman, libpng, libslirp, libspice-server, libssh, libusb, libusbredir, libx11, mesa, ncurses, pulseaudio, qemu-common, resolv-conf, sdl2 | sdl2-compat, sdl2-image, virglrenderer, zlib, zstd"
# Required by configuration script, but I can't find any binary that uses it.
CLANDRO_PKG_BUILD_DEPENDS="libtasn1"
CLANDRO_PKG_ANTI_BUILD_DEPENDS="sdl2-compat"
# Remove files already present in qemu-utils and qemu-common.
CLANDRO_PKG_RM_AFTER_INSTALL="
bin/elf2dmp
bin/qemu-edid
bin/qemu-ga
bin/qemu-img
bin/qemu-io
bin/qemu-nbd
bin/qemu-pr-helper
bin/qemu-storage-daemon
include/*
libexec/qemu-bridge-helper
libexec/virtfs-proxy-helper
share/applications
share/doc
share/icons
share/man/man1/qemu-img.1*
share/man/man1/qemu-storage-daemon.1*
share/man/man1/qemu.1*
share/man/man1/virtfs-proxy-helper.1*
share/man/man7
share/man/man8/qemu-ga.8*
share/man/man8/qemu-nbd.8*
share/man/man8/qemu-pr-helper.8*
share/qemu
"

CLANDRO_PKG_CONFLICTS="qemu-system-x86_64, qemu-system-x86_64-headless, qemu-system-x86-64-headless"
CLANDRO_PKG_REPLACES="qemu-system-x86_64, qemu-system-x86_64-headless, qemu-system-x86-64-headless"
CLANDRO_PKG_PROVIDES="qemu-system-x86_64"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	# Workaround for https://github.com/termux/termux-packages/issues/12261.
	if [ $CLANDRO_ARCH = "aarch64" ]; then
		rm -f $CLANDRO_PKG_BUILDDIR/_lib
		mkdir -p $CLANDRO_PKG_BUILDDIR/_lib

		cd $CLANDRO_PKG_BUILDDIR
		mkdir -p _setjmp-aarch64
		pushd _setjmp-aarch64
		mkdir -p private
		local s
		for s in $CLANDRO_PKG_BUILDER_DIR/setjmp-aarch64/{setjmp.S,private-*.h}; do
			local f=$(basename ${s})
			cp ${s} ./${f/-//}
		done
		$CC $CFLAGS $CPPFLAGS -I. setjmp.S -c
		$AR cru $CLANDRO_PKG_BUILDDIR/_lib/libandroid-setjmp.a setjmp.o
		popd

		LDFLAGS+=" -L$CLANDRO_PKG_BUILDDIR/_lib -l:libandroid-setjmp.a"
	fi
}

clandro_step_configure() {
	clandro_setup_ninja

	if [ "$CLANDRO_ARCH" = "i686" ]; then
		LDFLAGS+=" -latomic"
	fi

	local QEMU_TARGETS=""

	# System emulation.
	if [[ "$CLANDRO_ARCH_BITS" == "64" ]]; then
		QEMU_TARGETS+="aarch64-softmmu,"
	fi
	QEMU_TARGETS+="arm-softmmu,"
	QEMU_TARGETS+="i386-softmmu,"
	QEMU_TARGETS+="m68k-softmmu,"
	if [[ "$CLANDRO_ARCH_BITS" == "64" ]]; then
		QEMU_TARGETS+="ppc64-softmmu,"
	fi
	QEMU_TARGETS+="ppc-softmmu,"
	if [[ "$CLANDRO_ARCH_BITS" == "64" ]]; then
		QEMU_TARGETS+="riscv32-softmmu,"
		QEMU_TARGETS+="riscv64-softmmu,"
		QEMU_TARGETS+="x86_64-softmmu"
	else
		QEMU_TARGETS+="riscv32-softmmu"
	fi

	CFLAGS+=" $CPPFLAGS"
	CXXFLAGS+=" $CPPFLAGS"
	LDFLAGS+=" -landroid-shmem -llog"

	# Note: using --disable-stack-protector since stack protector
	# flags already passed by build scripts but we do not want to
	# override them with what QEMU configure provides.
	./configure \
		--prefix="$CLANDRO_PREFIX" \
		--cross-prefix="${CLANDRO_HOST_PLATFORM}-" \
		--host-cc="gcc" \
		--cc="$CC" \
		--cxx="$CXX" \
		--objcc="$CC" \
		--disable-stack-protector \
		--smbd="$CLANDRO_PREFIX/bin/smbd" \
		--enable-coroutine-pool \
		--audio-drv-list=pa,sdl \
		--enable-trace-backends=nop \
		--disable-guest-agent \
		--enable-gnutls \
		--enable-nettle \
		--enable-sdl \
		--enable-sdl-image \
		--enable-gtk \
		--enable-opengl \
		--enable-virglrenderer \
		--disable-vte \
		--enable-curses \
		--enable-iconv \
		--enable-vnc \
		--disable-vnc-sasl \
		--enable-vnc-jpeg \
		--enable-png \
		--disable-xen \
		--disable-xen-pci-passthrough \
		--enable-virtfs \
		--enable-curl \
		--enable-fdt=system \
		--enable-kvm \
		--disable-hvf \
		--disable-whpx \
		--disable-libnfs \
		--enable-lzo \
		--disable-snappy \
		--enable-bzip2 \
		--disable-lzfse \
		--disable-seccomp \
		--enable-libssh \
		--enable-bochs \
		--enable-cloop \
		--enable-dmg \
		--enable-parallels \
		--enable-qed \
		--enable-slirp \
		--enable-spice \
		--enable-libusb \
		--enable-usb-redir \
		--disable-vhost-user \
		--disable-vhost-user-blk-server \
		--target-list="$QEMU_TARGETS"
}

clandro_step_post_make_install() {
	local i
	for i in aarch64 arm i386 m68k ppc ppc64 riscv32 riscv64 x86_64; do
		ln -sfr \
			"${CLANDRO_PREFIX}"/share/man/man1/qemu.1 \
			"${CLANDRO_PREFIX}"/share/man/man1/qemu-system-${i}.1
	done
}
