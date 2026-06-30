CLANDRO_PKG_HOMEPAGE=https://python-pillow.org/
CLANDRO_PKG_DESCRIPTION="Python Imaging Library"
CLANDRO_PKG_LICENSE="custom"
CLANDRO_PKG_LICENSE_FILE="LICENSE"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="12.2.0"
CLANDRO_PKG_SRCURL="https://github.com/python-pillow/Pillow/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=15d08a03e16953813045ad24c5818e2909ef2141a0b97b2bd3bc8ec6f222cadb
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="freetype, libavif, libimagequant, libjpeg-turbo, libraqm, libtiff, libwebp, libxcb, littlecms, openjpeg, python, python-pip, zlib"
CLANDRO_PKG_SETUP_PYTHON=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_post_make_install() {
	if [[ ! -e "$CLANDRO_PYTHON_HOME/site-packages/pillow-$CLANDRO_PKG_VERSION.dist-info" ]]; then
		clandro_error_exit "Package ${CLANDRO_PKG_NAME} doesn't build properly."
	fi
}
