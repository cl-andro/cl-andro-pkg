CLANDRO_PKG_HOMEPAGE=https://github.com/apache/arrow
CLANDRO_PKG_DESCRIPTION="C++ libraries for Apache Arrow"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="24.0.0"
CLANDRO_PKG_SRCURL="https://github.com/apache/arrow/archive/refs/tags/apache-arrow-${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=94e18d188f26324c4da6bb3a723fec1536ae88b8308bada28d53c0b8d5206b28
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="abseil-cpp, apache-orc, libandroid-execinfo, libc++, liblz4, libprotobuf, libre2, libsnappy, thrift, utf8proc, zlib, zstd"
CLANDRO_PKG_BUILD_DEPENDS="boost, boost-headers, rapidjson"
CLANDRO_PKG_PYTHON_COMMON_BUILD_DEPS="build, 'Cython>=3.1', libcst, numpy, scikit-build-core, setuptools-scm, wheel"
CLANDRO_PKG_BREAKS="libarrow-python (<< ${CLANDRO_PKG_VERSION})"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DARROW_BUILD_STATIC=OFF
-DARROW_CSV=ON
-DARROW_DATASET=ON
-DARROW_HDFS=ON
-DARROW_JEMALLOC=OFF
-DARROW_JSON=ON
-DARROW_ORC=ON
-DARROW_PARQUET=ON
-DARROW_RUNTIME_SIMD_LEVEL=NONE
-DARROW_SIMD_LEVEL=NONE
-DLZ4_HOME=$CLANDRO_PREFIX
-DSNAPPY_HOME=$CLANDRO_PREFIX
-DZLIB_HOME=$CLANDRO_PREFIX
-DZSTD_HOME=$CLANDRO_PREFIX
"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _EXPECTED_SOVERSION=2400

	# From cpp/CMakeLists.txt: ARROW_SO_VERSION = "${ARROW_VERSION_MAJOR} * 100 + ${ARROW_VERSION_MINOR}"
	local _ACTUAL_SOVERSION=$(echo "$CLANDRO_PKG_VERSION" | awk -F'.' '{print $1 * 100 + $2}')
	if [ ! "${_ACTUAL_SOVERSION}" ] || [ "${_EXPECTED_SOVERSION}" != "$(( "${_ACTUAL_SOVERSION}" ))" ]; then
		clandro_error_exit "SOVERSION changed: expected=$_EXPECTED_SOVERSION, actual=$_ACTUAL_SOVERSION"
	fi
}

clandro_step_pre_configure() {
	clandro_setup_protobuf

	CLANDRO_PKG_SRCDIR+="/cpp"

	CPPFLAGS+=" -DPROTOBUF_USE_DLLS"
	LDFLAGS+=" -landroid-execinfo"

	# Fix linker script error for zlib 1.3
	LDFLAGS+=" -Wl,--undefined-version"
}

clandro_step_post_make_install() {
	# clandro_step_pre_configure
	CLANDRO_PKG_SRCDIR+="/../python"
	CLANDRO_PKG_BUILDDIR="$CLANDRO_PKG_SRCDIR"
	cd "$CLANDRO_PKG_BUILDDIR"

	export CMAKE_GENERATOR="Ninja"

	export PYARROW_WITH_DATASET=1
	export PYARROW_WITH_HDFS=1
	export PYARROW_WITH_ORC=1
	export PYARROW_WITH_PARQUET=1

	# clandro_step_configure
	# cmake is not intended to be invoked directly.
	clandro_setup_cmake
	clandro_setup_ninja

	# clandro_step_make
	python -m build -w -n -x \
		-C cmake.args="-DCMAKE_PREFIX_PATH=$CLANDRO_PREFIX/lib/cmake" \
		-C cmake.args="-DNUMPY_INCLUDE_DIRS=$CLANDRO_PYTHON_HOME/site-packages/numpy/_core/include" \
		"$CLANDRO_PKG_SRCDIR"

	# clandro_step_make_install
	local _pyver="${CLANDRO_PYTHON_VERSION//./}"
	local _wheel="pyarrow-${CLANDRO_PKG_VERSION}-cp${_pyver}-cp${_pyver}-android_${CLANDRO_ARCH}.whl"
	cross-pip install --no-deps --prefix="$CLANDRO_PREFIX" "$CLANDRO_PKG_SRCDIR/dist/${_wheel}"
}
