CLANDRO_PKG_HOMEPAGE=https://www.gnu.org/software/gawk/
CLANDRO_PKG_DESCRIPTION="Programming language designed for text processing"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="5.3.2"
CLANDRO_PKG_SRCURL="https://mirrors.kernel.org/gnu/gawk/gawk-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=f8c3486509de705192138b00ef2c00bbbdd0e84c30d5c07d23fc73a9dc4cc9cc
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_DEPENDS="libandroid-support, libgmp, libmpfr, readline"
CLANDRO_PKG_BREAKS="gawk-dev"
CLANDRO_PKG_REPLACES="gawk-dev"
CLANDRO_PKG_ESSENTIAL=true
CLANDRO_PKG_RM_AFTER_INSTALL="
bin/gawkbug
bin/gawk-${CLANDRO_PKG_VERSION}
share/man/man1/gawkbug.1
"
CLANDRO_PKG_GROUPS="base-devel"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-pma
"
CLANDRO_PKG_ON_DEVICE_BUILD_NOT_SUPPORTED=true

clandro_step_pre_configure() {
	# Remove old symlink to force a fresh timestamp:
	rm -f "$CLANDRO_PREFIX/bin/awk"

	# http://cross-lfs.org/view/CLFS-2.1.0/ppc64-64/temp-system/gawk.html
	cp -v extension/Makefile.in{,.orig}
	sed -e 's/check-recursive all-recursive: check-for-shared-lib-support/check-recursive all-recursive:/' \
		extension/Makefile.in.orig > extension/Makefile.in
}
