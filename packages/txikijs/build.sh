CLANDRO_PKG_HOMEPAGE=https://github.com/saghul/txiki.js
CLANDRO_PKG_DESCRIPTION="A small and powerful JavaScript runtime"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1:26.4.0"
CLANDRO_PKG_SRCURL=git+https://github.com/saghul/txiki.js
CLANDRO_PKG_DEPENDS="libandroid-spawn, libc++, libcurl, libffi"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_NATIVE=OFF
-DUSE_EXTERNAL_FFI=ON
-DFFI_INCLUDE_DIR=$CLANDRO_PREFIX/include
-DFFI_LIB=$CLANDRO_PREFIX/lib/libffi.so
"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_HOSTBUILD=true

clandro_step_host_build() {
	rm -rf "$CLANDRO_PKG_HOSTBUILD_DIR"
	cp -r "$CLANDRO_PKG_SRCDIR" "$CLANDRO_PKG_HOSTBUILD_DIR"
	cd "$CLANDRO_PKG_HOSTBUILD_DIR"

	clandro_setup_cmake

	cmake .
	make -j "$CLANDRO_PKG_MAKE_PROCESSES"
}

clandro_step_pre_configure() {
	if [ "$CLANDRO_ARCH" = "aarch64" ]; then
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DWAMR_BUILD_TARGET=AARCH64"
	elif [ "$CLANDRO_ARCH" = "arm" ]; then
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DWAMR_BUILD_TARGET=THUMB"
	elif [ "$CLANDRO_ARCH" = "i686" ]; then
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DWAMR_BUILD_TARGET=X86_32"
	elif [ "$CLANDRO_ARCH" = "x86_64" ]; then
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DWAMR_BUILD_TARGET=X86_64"
	else
		clandro_error_exit "Unsupported arch: $CLANDRO_ARCH"
	fi

	LDFLAGS+=" -landroid-spawn"
}

clandro_step_post_configure() {
	export PATH="$CLANDRO_PKG_HOSTBUILD_DIR:$PATH"
}

clandro_step_make_install() {
	install -Dm700 -t "$CLANDRO_PREFIX/bin" tjs
}
