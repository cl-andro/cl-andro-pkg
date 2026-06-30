CLANDRO_PKG_HOMEPAGE=https://www.gnu.org/software/cpio/
CLANDRO_PKG_DESCRIPTION="CPIO implementation from the GNU project"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.15"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://mirrors.kernel.org/gnu/cpio/cpio-$CLANDRO_PKG_VERSION.tar.bz2
CLANDRO_PKG_SHA256=937610b97c329a1ec9268553fb780037bcfff0dcffe9725ebc4fd9c1aa9075db
CLANDRO_PKG_DEPENDS="tar"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--with-rmt=$CLANDRO_PREFIX/libexec/rmt"

clandro_step_pre_configure() {
	autoreconf -fi
}
