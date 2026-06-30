CLANDRO_PKG_HOMEPAGE=http://www.gnu.org/software/guile/
CLANDRO_PKG_DESCRIPTION="Portable, embeddable Scheme implementation written in C"
CLANDRO_PKG_LICENSE="LGPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=3.0.11
CLANDRO_PKG_REVISION=1
# Tip: Guile official source code contains hardlinks and cannot be built by default if "$CLANDRO_ON_DEVICE_BUILD" == "true".
# To build if "$CLANDRO_ON_DEVICE_BUILD" == "true", follow a guide like this to prepare for it:
# https://unix.stackexchange.com/questions/265024/unpacking-tarball-with-hard-links-on-a-file-system-that-doesnt-support-hard-lin
CLANDRO_PKG_SRCURL=https://mirrors.kernel.org/gnu/guile/guile-$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=3c9c16972a73bb792752f2e4f1cce7212d7638d5494b5f7e8e19f3819dbf3a19
CLANDRO_PKG_DEPENDS="libandroid-spawn, libandroid-support, libffi, libgc, libgmp, libiconv, libunistring, ncurses, readline"
CLANDRO_PKG_BUILD_DEPENDS="libtool"
CLANDRO_PKG_BREAKS="guile-dev"
CLANDRO_PKG_REPLACES="guile-dev"
CLANDRO_PKG_CONFLICTS="guile18"
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_BUILD_IN_SRC=true

# https://github.com/termux/termux-packages/issues/14806
CLANDRO_PKG_NO_STRIP=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
LIBS=-landroid-spawn
ac_cv_func_posix_spawn=yes
ac_cv_func_posix_spawnp=yes
gl_cv_func_posix_spawn_works=yes
gl_cv_func_posix_spawnp_secure_exec=yes
ac_cv_type_complex_double=no
ac_cv_search_clock_getcpuclockid=false
ac_cv_func_GC_move_disappearing_link=yes
ac_cv_func_GC_is_heap_ptr=yes
"

_load_ubuntu_packages() {
	export HOSTBUILD_ROOTFS="${CLANDRO_PKG_HOSTBUILD_DIR}/ubuntu_packages"
	if [[ "$CLANDRO_ARCH_BITS" == "32" ]]; then
		export HOSTBUILD_ARCH="i386"
		export HOSTBUILD_ARCH_LIBDIR="/usr/lib/i386-linux-gnu"
		export HOSTBUILD_ARCH_INCLUDEDIR="/usr/include/i386-linux-gnu"
	else
		export HOSTBUILD_ARCH="amd64"
		export HOSTBUILD_ARCH_LIBDIR="/usr/lib/x86_64-linux-gnu"
		export HOSTBUILD_ARCH_INCLUDEDIR="/usr/include/x86_64-linux-gnu"
	fi
	export LD_LIBRARY_PATH="${HOSTBUILD_ROOTFS}${HOSTBUILD_ARCH_LIBDIR}"
	LD_LIBRARY_PATH+=":${HOSTBUILD_ROOTFS}/usr/lib"
}

clandro_step_host_build() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "true" ]]; then
		return
	fi

	_load_ubuntu_packages

	local -a ubuntu_packages=(
		"libffi-dev"
		"libffi8"
		"libgc-dev"
		"libgc1"
		"libgmp-dev"
		"libgmp10"
		"libgpm2"
		"libncurses-dev"
		"libncurses6"
		"libncursesw6"
		"libreadline-dev"
		"libreadline8t64"
		"libtinfo6"
		"libunistring-dev"
		"libunistring5"
	)

	DESTINATION="$HOSTBUILD_ROOTFS" \
	ARCHITECTURE="$HOSTBUILD_ARCH" \
	clandro_download_ubuntu_packages "${ubuntu_packages[@]}"

	find "${HOSTBUILD_ROOTFS}" -type f -name '*.pc' -print0 | \
		xargs -0 -n 1 sed -i -e "s|/usr|${HOSTBUILD_ROOTFS}/usr|g"

	export CFLAGS="-I${HOSTBUILD_ARCH_INCLUDEDIR} -I${HOSTBUILD_ROOTFS}${HOSTBUILD_ARCH_INCLUDEDIR}"
	export LDFLAGS="-L${HOSTBUILD_ARCH_LIBDIR} -L${HOSTBUILD_ROOTFS}${HOSTBUILD_ARCH_LIBDIR}"

	local HOSTBUILD_EXTRA_CONFIGURE_ARGS_32=""
	if [[ "$CLANDRO_ARCH_BITS" == "32" ]]; then
		export CFLAGS+=" -m32"
		HOSTBUILD_EXTRA_CONFIGURE_ARGS_32="--host=i386-linux-gnu"
	fi

	../src/configure --prefix="$HOSTBUILD_ROOTFS/usr" $HOSTBUILD_EXTRA_CONFIGURE_ARGS_32
	make -j "$CLANDRO_PKG_MAKE_PROCESSES"
	make install
}

clandro_step_pre_configure() {
	# Value of PKG_CONFIG becomes hardcoded in bin/*-config
	export PKG_CONFIG=pkg-config

	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "true" ]]; then
		return
	fi

	# always remove this because the hostbuild may be for a different architecture
	rm -rf "$CLANDRO_HOSTBUILD_MARKER"

	_load_ubuntu_packages

	export GUILE_FOR_BUILD="$HOSTBUILD_ROOTFS/usr/bin/guile"

	export CC_FOR_BUILD="gcc -m${CLANDRO_ARCH_BITS}"
}

clandro_step_post_configure() {
	cp "$CLANDRO_PKG_BUILDER_DIR/malloc.h" "$CLANDRO_PKG_BUILDDIR/lib/"
}
