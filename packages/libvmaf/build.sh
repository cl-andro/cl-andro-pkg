CLANDRO_PKG_HOMEPAGE=https://github.com/Netflix/vmaf
CLANDRO_PKG_DESCRIPTION="A perceptual video quality assessment algorithm developed by Netflix"
CLANDRO_PKG_LICENSE="custom"
CLANDRO_PKG_LICENSE_FILE="../LICENSE"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.1.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/Netflix/vmaf/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=80090e29d7fd0db472ddc663513f5be89bc936815e62b767e630c1d627279fe2
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++"

clandro_step_pre_configure() {
	CLANDRO_PKG_SRCDIR="$CLANDRO_PKG_SRCDIR/libvmaf"
	# https://github.com/Netflix/vmaf/issues/1481
	if [[ "$CLANDRO_ARCH" == "i686" ]]; then
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="-Denable_asm=false"
	fi
}
