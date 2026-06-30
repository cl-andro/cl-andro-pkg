CLANDRO_PKG_HOMEPAGE=https://github.com/opencv/opencv-python
CLANDRO_PKG_DESCRIPTION="Python wrapper for Python bindings for OpenCV"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="92"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_REPOLOGY_METADATA_VERSION="$(. "$CLANDRO_SCRIPTDIR/x11-packages/opencv/build.sh"; echo "$CLANDRO_PKG_VERSION").${CLANDRO_PKG_VERSION}"
CLANDRO_PKG_SRCURL="https://github.com/opencv/opencv-python/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=049293f56726a3ebb01bb7508b973e14e62752a4a0e067ac6af4e371d6aa30d3
CLANDRO_PKG_DEPENDS="opencv, opencv-python, python, python-pip"
CLANDRO_PKG_PYTHON_COMMON_BUILD_DEPS="scikit-build"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	clandro_setup_cmake

	# prevent any downloading or compiling of opencv source code,
	# but allow the normal installation of all other files
	echo '' > pyproject.toml
	mkdir -p opencv/empty
	echo 'cmake_minimum_required(VERSION 4.0)' > opencv/CMakeLists.txt
	echo 'install(DIRECTORY empty DESTINATION "${CMAKE_INSTALL_PREFIX}")' >> opencv/CMakeLists.txt

	# force version.py to generate
	patch="$CLANDRO_PKG_BUILDER_DIR/find_version.py.diff"
	echo "Applying patch: $(basename "$patch")"
	test -f "$patch" && sed \
		-e "s%\@CLANDRO_PREFIX\@%${CLANDRO_PREFIX}%g" \
		-e "s%\@CLANDRO_PKG_VERSION\@%${CLANDRO_PKG_VERSION}%g" \
		"$patch" | patch --silent -p1
}

clandro_step_post_make_install() {
	# also provide the opencv-contrib-python variant because Termux opencv also has the extra modules,
	# but some python projects might attempt to import either 'opencv-python' or 'opencv-contrib-python'.
	# which have different names
	export ENABLE_CONTRIB=1
	pip install --no-deps . --prefix "$CLANDRO_PREFIX"
}
