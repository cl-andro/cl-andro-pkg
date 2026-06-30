CLANDRO_PKG_HOMEPAGE=https://www.gnu.org/software/binutils/
CLANDRO_PKG_DESCRIPTION="A GNU collection of binary utilities"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
# `lua-language-server` links against libbfd,
# remember to rebuild it when updating `binutils`.
CLANDRO_PKG_VERSION="2.46.0"
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL="https://mirrors.kernel.org/gnu/binutils/binutils-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=d75a94f4d73e7a4086f7513e67e439e8fcdcbb726ffe63f4661744e6256b2cf2
CLANDRO_PKG_DEPENDS="libc++, zlib, zstd"
CLANDRO_PKG_BREAKS="binutils (<< 2.46), binutils-bin, binutils-libs, binutils-dev"
CLANDRO_PKG_REPLACES="binutils (<< 2.46), binutils-bin, binutils-libs, binutils-dev"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-gprofng
--enable-plugins
--disable-werror
--with-system-zlib
--enable-new-dtags
"
CLANDRO_PKG_EXTRA_MAKE_ARGS="tooldir=$CLANDRO_PREFIX"
CLANDRO_PKG_RM_AFTER_INSTALL="share/man/man1/windmc.1 share/man/man1/windres.1"
CLANDRO_PKG_NO_STATICSPLIT=true
# will overwrite llvm binutils and llvm ld
CLANDRO_PKG_ON_DEVICE_BUILD_NOT_SUPPORTED=true
CLANDRO_PKG_GROUPS="base-devel"

# For binutils-cross:
# Since NDK r27, debug sections of libraries from the bundled sysroot are
# compressed with zstd. It is necessary to enable the zstd support for ld.bfd.
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS="
--prefix=$CLANDRO_PREFIX/opt/binutils/cross
--target=$CLANDRO_HOST_PLATFORM
--enable-shared
--disable-static
--disable-nls
--with-system-zlib
--with-zstd
--disable-gprofng
ZSTD_LIBS=-l:libzstd.a
"

clandro_step_post_get_source() {
	# Remove the marker every time, as binutils is architecture-specific.
	rm -rf "$CLANDRO_HOSTBUILD_MARKER"

	# https://gitlab.archlinux.org/archlinux/packaging/packages/binutils/-/blob/2.46-1/PKGBUILD#L76-77
	# Turn off development mode (-Werror, gas run-time checks, date in sonames)
	sed -i '/^development=/s/true/false/' "$CLANDRO_PKG_SRCDIR/bfd/development.sh"

}

clandro_step_host_build() {
	# shellcheck disable=SC2086
	"$CLANDRO_PKG_SRCDIR/configure" $CLANDRO_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS
	make -j "$CLANDRO_PKG_MAKE_PROCESSES"
	make install
	make install-strip
}

# Avoid linking against libfl.so from flex if available:
export LEXLIB=

clandro_step_pre_configure() {
	export CPPFLAGS="$CPPFLAGS -Wno-c++11-narrowing"

	LIB_PATH="${CLANDRO_PREFIX}/lib:/system/lib"
	if (( CLANDRO_ARCH_BITS == 64 )); then
		LIB_PATH+="64"
	fi

	export LIB_PATH
}

clandro_step_post_make_install() {
	rm "${CLANDRO_PREFIX}/bin/ld"
	mv "${CLANDRO_PREFIX}/share/man/man1/ld.1" \
		"${CLANDRO_PREFIX}/share/man/man1/ld.bfd.1"
	local -a _BINUTILS_CONFLICTING_WITH_LLVM=(
		"ar"
		"addr2line"
		"c++filt"
		"nm"
		"objcopy"
		"objdump"
		"ranlib"
		"readelf"
		"size"
		"strings"
		"strip"
	)
	local binutil
	for binutil in "${_BINUTILS_CONFLICTING_WITH_LLVM[@]}"; do
		mv "${CLANDRO_PREFIX}/bin/${binutil}" \
			"${CLANDRO_PREFIX}/bin/g${binutil}"
		mv "${CLANDRO_PREFIX}/share/man/man1/${binutil}.1" \
			"${CLANDRO_PREFIX}/share/man/man1/g${binutil}.1"
	done
}
