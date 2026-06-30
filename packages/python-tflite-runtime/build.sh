CLANDRO_PKG_HOMEPAGE=https://www.tensorflow.org/lite
CLANDRO_PKG_DESCRIPTION="TensorFlow Lite Python bindings"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.20.0"
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=git+https://github.com/tensorflow/tensorflow
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="python, python-numpy, python-pip"
CLANDRO_PKG_UPDATE_TAG_TYPE="latest-release-tag"
CLANDRO_PKG_PYTHON_COMMON_BUILD_DEPS="setuptools, wheel, pybind11"
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_POLICY_VERSION_MINIMUM=3.5
-DTFLITE_HOST_TOOLS_DIR=$CLANDRO_PKG_HOSTBUILD_DIR
"

clandro_step_host_build() {
	clandro_setup_cmake

	cmake -DCMAKE_POLICY_VERSION_MINIMUM=3.5 "$CLANDRO_PKG_SRCDIR"/tensorflow/lite
	cmake --build . --verbose -j $CLANDRO_PKG_MAKE_PROCESSES -t flatbuffers-flatc
}

clandro_step_pre_configure() {
	clandro_setup_cmake
	clandro_setup_ninja

	# Copied from tensorflow/lite/tools/pip_package/build_pip_package_with_cmake.sh
	export TENSORFLOW_DIR="$CLANDRO_PKG_SRCDIR"
	local TENSORFLOW_LITE_DIR="$TENSORFLOW_DIR/tensorflow/lite"
	local TENSORFLOW_VERSION=$(grep "TF_VERSION = " "${TENSORFLOW_DIR}/tensorflow/tf_version.bzl" | cut -d= -f2 | sed 's/[ "-]//g')
	IFS='.' read -r -a array <<< "$TENSORFLOW_VERSION"
	local TF_MAJOR=${array[0]}
	local TF_MINOR=${array[1]}
	local TF_PATCH=${array[2]}
	local TF_CXX_FLAGS="-DTF_MAJOR_VERSION=${TF_MAJOR} -DTF_MINOR_VERSION=${TF_MINOR} -DTF_PATCH_VERSION=${TF_PATCH} -DTF_VERSION_SUFFIX=''"
	export PACKAGE_VERSION="$TENSORFLOW_VERSION"
	export PROJECT_NAME="tflite_runtime"
	TFLITE_BUILD_DIR="$CLANDRO_PKG_BUILDDIR/build-wheel"
	local BUILD_DIR="$TFLITE_BUILD_DIR"
	local PYTHON="$(command -v python)"
	local PYBIND11_INCLUDE=$($PYTHON -c "import pybind11; print (pybind11.get_include())")
	CPPFLAGS+=" -I$CLANDRO_PYTHON_HOME/site-packages/numpy/_core/include"
	CPPFLAGS+=" -I$PYBIND11_INCLUDE"
	CPPFLAGS+=" -I$CLANDRO_PREFIX/include/python$CLANDRO_PYTHON_VERSION"
	CPPFLAGS+=" $TF_CXX_FLAGS"

	# Build source tree
	rm -rf "$BUILD_DIR" && mkdir -p "$BUILD_DIR/tflite_runtime"
	cp -r "$TENSORFLOW_LITE_DIR/tools/pip_package/debian" \
		"$TENSORFLOW_LITE_DIR/tools/pip_package/MANIFEST.in" \
		"$TENSORFLOW_LITE_DIR/python/interpreter_wrapper" \
		"$BUILD_DIR"
	cp  "$TENSORFLOW_LITE_DIR/tools/pip_package/setup_with_binary.py" "$BUILD_DIR/setup.py"
	cp "$TENSORFLOW_LITE_DIR/python/interpreter.py" \
		"$TENSORFLOW_LITE_DIR/python/metrics/metrics_interface.py" \
		"$TENSORFLOW_LITE_DIR/python/metrics/metrics_portable.py" \
		"$BUILD_DIR/tflite_runtime"
	echo "__version__ = '$PACKAGE_VERSION'" >> "$BUILD_DIR/tflite_runtime/__init__.py"
	echo "__git_version__ = '$(git -C "$TENSORFLOW_DIR" describe)'" >> "$BUILD_DIR/tflite_runtime/__init__.py"

	CLANDRO_PKG_SRCDIR_OLD="$CLANDRO_PKG_SRCDIR"
	CLANDRO_PKG_SRCDIR="$CLANDRO_PKG_SRCDIR/tensorflow/lite"
}

clandro_step_post_configure() {
	CLANDRO_PKG_SRCDIR="$CLANDRO_PKG_SRCDIR_OLD"
}

clandro_step_make() {
	# Build python interpreter_wrapper
	cmake --build . -j $CLANDRO_PKG_MAKE_PROCESSES -t _pywrap_tensorflow_interpreter_wrapper
	cp "$CLANDRO_PKG_BUILDDIR/_pywrap_tensorflow_interpreter_wrapper.so" \
		"$TFLITE_BUILD_DIR/tflite_runtime"

	# Build python wheel
	cd "$TFLITE_BUILD_DIR"
	python setup.py bdist_wheel
}

clandro_step_make_install() {
	local _pyver="${CLANDRO_PYTHON_VERSION//./}"
	local _wheel="tflite_runtime-${CLANDRO_PKG_VERSION}-cp${_pyver}-cp${_pyver}-android_${CLANDRO_ARCH}.whl"
	pip install --force-reinstall --no-deps --prefix="$CLANDRO_PREFIX" "$TFLITE_BUILD_DIR/dist/${_wheel}"
}
