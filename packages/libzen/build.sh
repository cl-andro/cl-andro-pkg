CLANDRO_PKG_HOMEPAGE=https://mediaarea.net/en/MediaInfo
CLANDRO_PKG_DESCRIPTION="ZenLib C++ utility library"
CLANDRO_PKG_LICENSE="ZLIB"
CLANDRO_PKG_LICENSE_FILE="../../../License.txt"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.4.41
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://mediaarea.net/download/source/libzen/${CLANDRO_PKG_VERSION}/libzen_${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=aad6c25bffcc695828e4d36700243a19a0d9503fbe57d38a2fbfa302fb34df2f
CLANDRO_PKG_DEPENDS="libandroid-support, libc++"
CLANDRO_PKG_BUILD_DEPENDS="libandroid-glob"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--enable-shared --enable-static"

clandro_step_pre_configure() {
	CLANDRO_PKG_SRCDIR="${CLANDRO_PKG_SRCDIR}/Project/GNU/Library"
	CLANDRO_PKG_BUILDDIR="${CLANDRO_PKG_SRCDIR}"
	cd "${CLANDRO_PKG_SRCDIR}" || return
	./autogen.sh

	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}
