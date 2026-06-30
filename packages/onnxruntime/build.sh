CLANDRO_PKG_HOMEPAGE=https://onnxruntime.ai/
CLANDRO_PKG_DESCRIPTION="Cross-platform, high performance ML inferencing and training accelerator"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.26.0"
CLANDRO_PKG_SRCURL=git+https://github.com/microsoft/onnxruntime
CLANDRO_PKG_DEPENDS="abseil-cpp, libc++, protobuf, libre2"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_PYTHON_COMMON_BUILD_DEPS="wheel, build, packaging"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="latest-release-tag"

# if -Donnxruntime_BUILD_SHARED_LIB=ON is not used,
# this build error occurs:
# install(EXPORT "onnxruntimeTargets" ...) includes target "onnxruntime"
# which requires target "XNNPACK" that is not in any export set.
# as of version 1.23.2
# if -Donnxruntime_BUILD_UNIT_TESTS=OFF is not used,
# this build error occurs for 32-bit targets:
# src/onnxruntime/test/shared_lib/custom_op_utils.cc:657:43: error:
# implicit conversion loses integer precision: 'int64_t' (aka 'long long')
# to 'size_type' (aka 'unsigned int') [-Werror,-Wshorten-64-to-32]
# as of version 1.23.2
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_INSTALL_LIBDIR=$CLANDRO__PREFIX__LIB_SUBDIR
-DCMAKE_INSTALL_INCLUDEDIR=$CLANDRO__PREFIX__INCLUDE_SUBDIR
-DCMAKE_POLICY_VERSION_MINIMUM=3.5
-Donnxruntime_ENABLE_PYTHON=ON
-Donnxruntime_BUILD_SHARED_LIB=ON
-DPYBIND11_USE_CROSSCOMPILING=TRUE
-Donnxruntime_USE_NNAPI_BUILTIN=ON
-Donnxruntime_USE_XNNPACK=ON
-Donnxruntime_BUILD_UNIT_TESTS=OFF
"

clandro_step_pre_configure() {
	CPPFLAGS+=" -Wno-unused-variable"

	clandro_setup_cmake
	clandro_setup_ninja
	clandro_setup_protobuf

	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DPYTHON_EXECUTABLE=$(command -v python3)"
	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DONNX_CUSTOM_PROTOC_EXECUTABLE=$(command -v protoc)"
	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DPython_NumPy_INCLUDE_DIR=$CLANDRO_PYTHON_HOME/site-packages/numpy/_core/include"
}

clandro_step_configure() {
	local CLANDRO_PKG_SRCDIR_SAVE="$CLANDRO_PKG_SRCDIR"
	CLANDRO_PKG_SRCDIR+="/cmake"
	clandro_step_configure_cmake
	CLANDRO_PKG_SRCDIR="$CLANDRO_PKG_SRCDIR_SAVE"
}

clandro_step_make() {
	cmake --build .
	python -m build --wheel --no-isolation
}

clandro_step_make_install() {
	cmake --install "$CLANDRO_PKG_SRCDIR"
	# for reverse dependency crow-translate to find onnxruntime
	ln -sf libonnxruntime.pc "$CLANDRO_PREFIX/lib/pkgconfig/onnxruntime.pc"

	local _pyver="${CLANDRO_PYTHON_VERSION//./}"
	local _wheel="onnxruntime-${CLANDRO_PKG_VERSION}-cp${_pyver}-cp${_pyver}-android_${CLANDRO_ARCH}.whl"
	pip install --force-reinstall --no-deps --prefix="$CLANDRO_PREFIX" "$CLANDRO_PKG_SRCDIR/dist/${_wheel}"
}

clandro_step_post_make_install() {
	# for some reason in python 3.13, these are no longer getting installed automatically
	install -Dm644 onnxruntime_pybind11_state.so \
		-t "$CLANDRO_PYTHON_HOME/site-packages/onnxruntime/capi"
	ln -sf "$CLANDRO_PREFIX/lib/libonnxruntime.so" \
		"$CLANDRO_PYTHON_HOME/site-packages/onnxruntime/capi/libonnxruntime.so"
	ln -sf "$CLANDRO_PREFIX/lib/libonnxruntime_providers_shared.so" \
		"$CLANDRO_PYTHON_HOME/site-packages/onnxruntime/capi/libonnxruntime_providers_shared.so"
}
