CLANDRO_PKG_HOMEPAGE=https://opencolorio.org
CLANDRO_PKG_DESCRIPTION="A color management framework for visual effects and animation"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.5.1"
CLANDRO_PKG_SRCURL=https://github.com/AcademySoftwareFoundation/OpenColorIO/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=08cb6213ea4edee550ab050509d38204004bee6742c658166b1cf825d0a9381b
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="imath, libc++, libexpat, libminizip-ng, libyaml-cpp, pystring"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dpystring_INCLUDE_DIR=$CLANDRO_PREFIX/lib
-DOCIO_BUILD_PYTHON=OFF
"
# Command-line apps depend on packages in x11 repo (for OpenGL functionality):
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DOCIO_BUILD_APPS=OFF"

clandro_step_pre_configure() {
	# error: constant expression evaluates to -1 which cannot be narrowed to type 'char' [-Wc++11-narrowing]
	# also same is used while building apt
	CXXFLAGS+=" -Wno-c++11-narrowing"
	CXXFLAGS+=" -I$PREFIX/include/pystring"
}
