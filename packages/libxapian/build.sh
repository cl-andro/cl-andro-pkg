CLANDRO_PKG_HOMEPAGE=https://xapian.org
CLANDRO_PKG_DESCRIPTION="Xapian search engine library"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.0.0"
CLANDRO_PKG_SRCURL=https://oligarchy.co.uk/xapian/${CLANDRO_PKG_VERSION}/xapian-core-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=6cea3f49952a47224439a40bdb3608f928d121ad8721b9921cc42802d548ecf8
CLANDRO_PKG_AUTO_UPDATE=true
# Note that we cannot /proc/sys/kernel/random/uuid (permission denied on
# new android versions) so need libuuid.
CLANDRO_PKG_DEPENDS="libc++, libuuid, zlib"
CLANDRO_PKG_BREAKS="libxapian-dev"
CLANDRO_PKG_REPLACES="libxapian-dev"
CLANDRO_PKG_RM_AFTER_INSTALL="
share/doc/xapian-core/
"

clandro_step_pre_configure() {
	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}
