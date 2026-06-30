CLANDRO_PKG_HOMEPAGE=https://www.mesa3d.org
CLANDRO_PKG_DESCRIPTION="An open-source implementation of the OpenGL specification"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_LICENSE_FILE="docs/license.rst"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="26.0.6"
CLANDRO_PKG_SRCURL=https://archive.mesa3d.org/mesa-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=1d3c3b8a8363b8cc354175bb4a684ad8b035211cc1d6fa17aeb9b9623c513f89
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libandroid-shmem, libc++, libdrm, libglvnd, libllvm (<< $CLANDRO_LLVM_NEXT_MAJOR_VERSION), libwayland, libx11, libxext, libxfixes, libxshmfence, libxxf86vm, ncurses, vulkan-loader, zlib, zstd"
CLANDRO_PKG_SUGGESTS="mesa-dev"
CLANDRO_PKG_BUILD_DEPENDS="libclc, libwayland-protocols, libxrandr, llvm, llvm-tools, mlir, spirv-tools, xorgproto"
CLANDRO_PKG_BREAKS="osmesa, osmesa-demos"
CLANDRO_PKG_CONFLICTS="libmesa, ndk-sysroot (<= 25b), osmesa"
CLANDRO_PKG_REPLACES="libmesa, osmesa"

# FIXME: Set `shared-llvm` to disabled if possible
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--cmake-prefix-path $CLANDRO_PREFIX
-Dgbm=enabled
-Dopengl=true
-Degl=enabled
-Degl-native-platform=x11
-Dgles1=disabled
-Dgles2=enabled
-Dglx=dri
-Dllvm=enabled
-Dshared-llvm=enabled
-Dplatforms=x11,wayland
-Dgallium-drivers=llvmpipe,softpipe,virgl,zink
-Dgallium-rusticl=true
-Dglvnd=enabled
-Dxmlconfig=disabled
"

clandro_step_post_get_source() {
	# Do not use meson wrap projects
	rm -rf subprojects
}

clandro_step_pre_configure() {
	if [ "$CLANDRO_PKG_API_LEVEL" -lt 29 ]; then
		# ELF TLS is supported starting with API level 29.
		patch --silent -p1 < "$CLANDRO_PKG_BUILDER_DIR/0011-lld-undefined-version.diff"
	fi

	clandro_setup_cmake
	clandro_setup_rust

	: "${CARGO_HOME:=${HOME}/.cargo}"
	export CARGO_HOME

	cargo install --force --locked bindgen-cli
	if [[ "${CLANDRO_ON_DEVICE_BUILD}" == "false" ]]; then
		export BINDGEN_EXTRA_CLANG_ARGS="--sysroot ${CLANDRO_STANDALONE_TOOLCHAIN}/sysroot"
		case "${CLANDRO_ARCH}" in
		arm) BINDGEN_EXTRA_CLANG_ARGS+=" --target=arm-linux-androideabi${CLANDRO_PKG_API_LEVEL}" ;;
		*) BINDGEN_EXTRA_CLANG_ARGS+=" --target=${CLANDRO_ARCH}-linux-android${CLANDRO_PKG_API_LEVEL}" ;;
		esac
	fi

	CPPFLAGS+=" -D__USE_GNU"
	LDFLAGS+=" -landroid-shmem"

	_WRAPPER_BIN=$CLANDRO_PKG_BUILDDIR/_wrapper/bin
	mkdir -p $_WRAPPER_BIN
	if [ "$CLANDRO_ON_DEVICE_BUILD" = "false" ]; then
		sed 's|@CMAKE@|'"$(command -v cmake)"'|g' \
			$CLANDRO_PKG_BUILDER_DIR/cmake-wrapper.in \
			> $_WRAPPER_BIN/cmake
		chmod 0700 $_WRAPPER_BIN/cmake
		clandro_setup_wayland_cross_pkg_config_wrapper
	fi
	export LLVM_CONFIG="${CLANDRO_PREFIX}/bin/llvm-config"
	export PATH="${_WRAPPER_BIN}:${CARGO_HOME}/bin:${PATH}"

	local _vk_drivers="swrast"
	if [ $CLANDRO_ARCH = "arm" ] || [ $CLANDRO_ARCH = "aarch64" ]; then
		_vk_drivers+=",freedreno"
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -Dfreedreno-kmds=msm,kgsl"
	fi
	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -Dvulkan-drivers=$_vk_drivers"
}

clandro_step_post_configure() {
	rm -f $_WRAPPER_BIN/cmake
}

clandro_step_post_make_install() {
	# Avoid hard links
	local f1
	for f1 in $CLANDRO_PREFIX/lib/dri/*; do
		if [ ! -f "${f1}" ]; then
			continue
		fi
		local f2
		for f2 in $CLANDRO_PREFIX/lib/dri/*; do
			if [ -f "${f2}" ] && [ "${f1}" != "${f2}" ]; then
				local s1=$(stat -c "%i" "${f1}")
				local s2=$(stat -c "%i" "${f2}")
				if [ "${s1}" = "${s2}" ]; then
					ln -sfr "${f1}" "${f2}"
				fi
			fi
		done
	done

	# Create symlinks
	ln -sf libEGL_mesa.so ${CLANDRO_PREFIX}/lib/libEGL_mesa.so.0
	ln -sf libGLX_mesa.so ${CLANDRO_PREFIX}/lib/libGLX_mesa.so.0
	ln -sf libRusticlOpenCL.so ${CLANDRO_PREFIX}/lib/libRusticlOpenCL.so.1

	unset BINDGEN_EXTRA_CLANG_ARGS LLVM_CONFIG
}
