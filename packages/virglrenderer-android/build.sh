CLANDRO_PKG_HOMEPAGE=https://virgil3d.github.io/
CLANDRO_PKG_DESCRIPTION="A virtual 3D GPU for use inside qemu virtual machines over OpenGLES libraries on Android"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@licy183"
CLANDRO_PKG_VERSION="1.3.0"
_LIBEPOXY_VERSION="1.5.10"

CLANDRO_PKG_SRCURL=(
	https://gitlab.freedesktop.org/virgl/virglrenderer/-/archive/virglrenderer-${CLANDRO_PKG_VERSION}/virglrenderer-virglrenderer-${CLANDRO_PKG_VERSION}.tar.gz
	https://github.com/anholt/libepoxy/archive/refs/tags/${_LIBEPOXY_VERSION}.tar.gz
)
CLANDRO_PKG_SHA256=(
	56170f8caa1bb642a2624b649e3bcca095ec2834814e5c308efc8a85a709e4ce
	a7ced37f4102b745ac86d6a70a9da399cc139ff168ba6b8002b4d8d43c900c15
)
CLANDRO_PKG_DEPENDS="angle-android"
CLANDRO_PKG_HOSTBUILD=true

clandro_step_post_get_source() {
	mv libepoxy-${_LIBEPOXY_VERSION} libepoxy
}

clandro_step_host_build() {
	# This package should use the Android NDK toolchain to compile, not
	# our custom toolchain, so I'd like to compile it in the hostbuild step.
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		export PATH="$NDK/toolchains/llvm/prebuilt/linux-x86_64/bin:$PATH"
		export CCTERMUX_HOST_PLATFORM="$CLANDRO_HOST_PLATFORM$CLANDRO_PKG_API_LEVEL"
		if [[ "$CLANDRO_ARCH" == "arm" ]]; then
			CCTERMUX_HOST_PLATFORM="armv7a-linux-androideabi$CLANDRO_PKG_API_LEVEL"
		fi
	fi

	local _INSTALL_PREFIX=$CLANDRO_PREFIX/opt/$CLANDRO_PKG_NAME

	PKG_CONFIG="$CLANDRO_PKG_TMPDIR/host-build-pkg-config"
	local _HOST_PKGCONFIG=$(command -v pkg-config)
	cat > $PKG_CONFIG <<-HERE
		#!/bin/sh
		export PKG_CONFIG_DIR=
		export PKG_CONFIG_LIBDIR=$_INSTALL_PREFIX/lib/pkgconfig
		exec $_HOST_PKGCONFIG "\$@"
	HERE
	chmod +x $PKG_CONFIG

	AR=$(command -v llvm-ar)
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		CC=$(command -v "$CCTERMUX_HOST_PLATFORM-clang")
		CXX=$(command -v "$CCTERMUX_HOST_PLATFORM-clang++")
	else
		CC=$(command -v "$CLANDRO_HOST_PLATFORM-clang")
		CXX=$(command -v "$CLANDRO_HOST_PLATFORM-clang++")
	fi
	LD=$(command -v ld.lld)
	CFLAGS=""
	CPPFLAGS=""
	CXXFLAGS=""
	LDFLAGS="-Wl,-rpath=$_INSTALL_PREFIX/lib"
	STRIP=$(command -v llvm-strip)
	clandro_setup_meson

	# Compile libepoxy
	mkdir -p libepoxy-build
	$CLANDRO_MESON $CLANDRO_PKG_SRCDIR/libepoxy libepoxy-build \
		--cross-file $CLANDRO_MESON_CROSSFILE \
		--prefix=$_INSTALL_PREFIX \
		--libdir lib \
		-Degl=yes -Dglx=no -Dx11=false
	ninja -C libepoxy-build install -j $CLANDRO_PKG_MAKE_PROCESSES

	# Compile virglrenderer
	mkdir -p virglrenderer-build
	$CLANDRO_MESON $CLANDRO_PKG_SRCDIR virglrenderer-build \
		--cross-file $CLANDRO_MESON_CROSSFILE \
		--prefix=$_INSTALL_PREFIX \
		--libdir lib \
		-Dplatforms=egl
	ninja -C virglrenderer-build install -j $CLANDRO_PKG_MAKE_PROCESSES

	# Move our virglrenderer binary to regular bin directory.
	mv $_INSTALL_PREFIX/bin/virgl_test_server $CLANDRO_PREFIX/bin/virgl_test_server_android

	# Cleanup.
	rm -rf $_INSTALL_PREFIX/{bin,include,lib/pkgconfig}
}

clandro_step_configure() {
	# Remove this marker all the time, as this package is architecture-specific
	rm -rf $CLANDRO_HOSTBUILD_MARKER
}

clandro_step_make() {
	:
}

clandro_step_make_install() {
	:
}

clandro_step_install_license() {
	mkdir -p $CLANDRO_PREFIX/share/doc/$CLANDRO_PKG_NAME
	cp $CLANDRO_PKG_SRCDIR/COPYING $CLANDRO_PREFIX/share/doc/$CLANDRO_PKG_NAME/COPYING-virglrenderer
	cp $CLANDRO_PKG_SRCDIR/libepoxy/COPYING $CLANDRO_PREFIX/share/doc/$CLANDRO_PKG_NAME/COPYING-libepoxy
	cp $CLANDRO_PKG_BUILDER_DIR/COPYING-gl4es $CLANDRO_PREFIX/share/doc/$CLANDRO_PKG_NAME/COPYING-gl4es
}
