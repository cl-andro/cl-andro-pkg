CLANDRO_PKG_HOMEPAGE=http://qpdf.sourceforge.net
CLANDRO_PKG_DESCRIPTION="Content-Preserving PDF Transformation System"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="12.3.2"
CLANDRO_PKG_SRCURL=https://github.com/qpdf/qpdf/releases/download/v$CLANDRO_PKG_VERSION/qpdf-$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=6cba2f9f2cd887d905faeb99e0e51a307b217920d1bbf3e9cfbb2e8178a2deda
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
CLANDRO_PKG_DEPENDS="libc++, libjpeg-turbo, zlib"
CLANDRO_PKG_BREAKS="qpdf-dev"
CLANDRO_PKG_REPLACES="qpdf-dev"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_STATIC_LIBS=OFF
-DRANDOM_DEVICE=/dev/urandom
"

clandro_step_pre_configure() {
	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}
