CLANDRO_PKG_HOMEPAGE=https://pytorch.org/
CLANDRO_PKG_DESCRIPTION="Tensors and Dynamic neural networks in Python"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.11.0"
CLANDRO_PKG_SRCURL=git+https://github.com/pytorch/pytorch
CLANDRO_PKG_UPDATE_TAG_TYPE="latest-release-tag"
CLANDRO_PKG_DEPENDS="abseil-cpp, libandroid-execinfo, libc++, libopenblas, libprotobuf, python, python-numpy, python-pip"
CLANDRO_PKG_BUILD_DEPENDS="vulkan-headers, vulkan-loader-android"
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_PYTHON_COMMON_BUILD_DEPS="wheel, pyyaml, typing_extensions"
CLANDRO_PKG_PYTHON_CROSS_BUILD_DEPS="numpy"
# USE_DISTRIBUTED=ON fixes
# ModuleNotFoundError: No module named 'torch._C._distributed_c10d'; 'torch._C' is not a package
# in
# python -c "from torch.distributed._tensor import DTensor"
#
# MI_NO_OPT_ARCH=ON fixes #29202 with architecture specific optimizations disabled
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_POLICY_VERSION_MINIMUM=3.5
-DANDROID_NO_TERMUX=OFF
-DBUILD_CUSTOM_PROTOBUF=OFF
-DBUILD_PYTHON=ON
-DBUILD_TEST=OFF
-DCMAKE_BUILD_TYPE=Release
-DCMAKE_INSTALL_PREFIX=${CLANDRO_PKG_SRCDIR}/torch
-DCMAKE_PREFIX_PATH=${CLANDRO_PYTHON_HOME}/site-packages
-DPython_NumPy_INCLUDE_DIR=${CLANDRO_PYTHON_HOME}/site-packages/numpy/_core/include
-DNATIVE_BUILD_DIR=${CLANDRO_PKG_HOSTBUILD_DIR}
-DTORCH_BUILD_VERSION=${CLANDRO_PKG_VERSION}
-DONNX_USE_PROTOBUF_SHARED_LIBS=ON
-DUSE_NUMPY=ON
-DUSE_CUDA=OFF
-DUSE_FAKELOWP=OFF
-DUSE_FBGEMM=OFF
-DUSE_ITT=OFF
-DUSE_MAGMA=OFF
-DUSE_NCCL=OFF
-DUSE_NNPACK=OFF
-DCXX_AVX512_FOUND=OFF
-DCXX_AVX2_FOUND=OFF
-DUSE_VULKAN=ON
-DUSE_DISTRIBUTED=ON
-DANDROID_NDK=${NDK}
-DANDROID_NDK_HOST_SYSTEM_NAME=linux-$HOSTTYPE
-DCMAKE_POLICY_VERSION_MINIMUM=3.5
-DMI_NO_OPT_ARCH=ON
"

CLANDRO_PKG_RM_AFTER_INSTALL="
lib/pkgconfig
lib/cmake/fmt
lib/libfmt.a
include/fmt
"

clandro_step_host_build() {
	clandro_setup_cmake
	cmake "$CLANDRO_PKG_SRCDIR/third_party/sleef"
	make -j "$CLANDRO_PKG_MAKE_PROCESSES" mkrename mkrename_gnuabi mkmasked_gnuabi mkalias mkdisp
}

clandro_step_pre_configure() {
	LDFLAGS+=" -fopenmp -static-openmp"

	export PYTHONPATH="${PYTHONPATH}:${CLANDRO_PKG_SRCDIR}"
	find "$CLANDRO_PKG_SRCDIR" -name CMakeLists.txt -o -name '*.cmake' ! -name 'VulkanCodegen*' | \
		xargs -n 1 sed -i \
		-e 's/\([^A-Za-z0-9_]ANDROID\)\([^A-Za-z0-9_]\)/\1_NO_TERMUX\2/g' \
		-e 's/\([^A-Za-z0-9_]ANDROID\)$/\1_NO_TERMUX/g'

	clandro_setup_protobuf

	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+="
	-DPython_EXECUTABLE=$(command -v python3)
	-DPROTOBUF_PROTOC_EXECUTABLE=$(command -v protoc)
	-DCAFFE2_CUSTOM_PROTOC_EXECUTABLE=$(command -v protoc)
	"

	# /home/builder/.termux-build/python-torch/src/torch/csrc/jit/codegen/onednn/graph_helper.h:3:10: fatal error: 'oneapi/dnnl/dnnl_graph.hpp' file not found
	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+="
	-DUSE_MKLDNN=OFF
	"

	ln -sf "$CLANDRO_PKG_BUILDDIR" build
}

clandro_step_make_install() {
	export PYTORCH_BUILD_VERSION=${CLANDRO_PKG_VERSION}
	export PYTORCH_BUILD_NUMBER=0
	pip -v install --no-deps --no-build-isolation --prefix $CLANDRO_PREFIX "$CLANDRO_PKG_SRCDIR"
	ln -sfr ${CLANDRO_PYTHON_HOME}/site-packages/torch/lib/*.so ${CLANDRO_PREFIX}/lib
}
