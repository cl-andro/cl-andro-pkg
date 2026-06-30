CLANDRO_PKG_HOMEPAGE=https://pocoproject.org/
CLANDRO_PKG_DESCRIPTION="A comprehensive set of C++ libraries that cover all modern-day programming needs"
CLANDRO_PKG_LICENSE="BSL-1.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.15.2"
CLANDRO_PKG_SRCURL=https://github.com/pocoproject/poco/archive/refs/tags/poco-${CLANDRO_PKG_VERSION}-release.tar.gz
CLANDRO_PKG_SHA256=aed7f94b3ea6a0d22f3bebaa368c76def029a5a45c9b3ea105e19e84e3530b3f
CLANDRO_PKG_DEPENDS="libandroid-posix-semaphore, libc++, libexpat, libsqlite, openssl, pcre2, utf8proc, zlib"
CLANDRO_PKG_BUILD_DEPENDS="libpng"
CLANDRO_PKG_FORCE_CMAKE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="-DPOCO_UNBUNDLED=ON"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP='\d+\.\d+\.\d+(?=-release)'

clandro_step_pre_configure() {
	LDFLAGS+=" -landroid-posix-semaphore"
}
