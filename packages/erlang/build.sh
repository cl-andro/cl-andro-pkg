CLANDRO_PKG_HOMEPAGE=https://www.erlang.org/
CLANDRO_PKG_DESCRIPTION="General-purpose concurrent functional programming language"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="28.5"
CLANDRO_PKG_SRCURL=https://github.com/erlang/otp/archive/refs/tags/OTP-$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=7d0a43be4ee5c3965509c0c20cf0b28afa0ab9573f0cc49631f2858165335a5a
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP='^OTP-[\d.]+$'
CLANDRO_PKG_DEPENDS="libc++, openssl, ncurses, zlib"
CLANDRO_PKG_NO_STATICSPLIT=true
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--without-javac
--with-ssl=${CLANDRO_PREFIX}
--with-termcap
erl_xcomp_sysroot=${CLANDRO_PREFIX}
"
# for some reason, these do not work properly, and are duplicates
# of ones patched to work which are installed into $CLANDRO_PREFIX/share/man/man1
CLANDRO_PKG_RM_AFTER_INSTALL="
lib/erlang/man
"
# were present in erlang 26
# were not present in erlang 27 through erlang 28.2
# reappeared in erlang 28.3
# https://github.com/erlang/otp/pull/10237
# conflict with zlib
# conflict with perl
# conflict with libowfat
# conflict with manpages
CLANDRO_PKG_RM_AFTER_INSTALL+="
share/man/man3/zlib.3
share/man/man3/re.3
share/man/man3/array.3
share/man/man3/inet.3
share/man/man3/queue.3
share/man/man3/rand.3
share/man/man3/random.3
share/man/man3/rpc.3
share/man/man3/string.3
"
# will overwrite man pages of perl and zlib
CLANDRO_PKG_ON_DEVICE_BUILD_NOT_SUPPORTED=true

clandro_step_post_get_source() {
	# We need a host build every time, because we dont know the full output of host build and have no idea to cache it.
	rm -Rf "$CLANDRO_PKG_HOSTBUILD_DIR"
}

clandro_step_host_build() {
	cd $CLANDRO_PKG_BUILDDIR
	# Erlang cross compile reference: https://github.com/erlang/otp/blob/master/HOWTO/INSTALL-CROSS.md#building-a-bootstrap-system
	# Build erlang bootstrap system.
	# the prefix must be set to $CLANDRO_PREFIX here to install the documentation where desired
	# without making a mess.
	./configure --prefix="$CLANDRO_PREFIX" --without-javac --with-termcap
	make -j $CLANDRO_PKG_MAKE_PROCESSES
	make RELSYS_MANDIR="$CLANDRO_PREFIX/share/man" install-docs
}

clandro_step_pre_configure() {
	# Add --build flag for erlang cross build
	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" --build=$(./erts/autoconf/config.guess)"

	# https://android.googlesource.com/platform/bionic/+/master/docs/32-bit-abi.md#is-32_bit-on-lp32-y2038
	if [ $CLANDRO_ARCH_BITS = 32 ]; then
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" --disable-year2038"
	fi

	# Use a wrapper CC to move `-I@CLANDRO_PREFIX@/include` to the last include param
	mkdir -p $CLANDRO_PKG_TMPDIR/_fake_bin
	sed -e "s|@CLANDRO_PREFIX@|${CLANDRO_PREFIX}|g" \
		-e "s|@COMPILER@|$(command -v ${CC})|g" \
		"$CLANDRO_PKG_BUILDER_DIR"/wrapper.py.in \
		> $CLANDRO_PKG_TMPDIR/_fake_bin/"$(basename ${CC})"
	chmod +x $CLANDRO_PKG_TMPDIR/_fake_bin/"$(basename ${CC})"
	export PATH="$CLANDRO_PKG_TMPDIR/_fake_bin:$PATH"
}
