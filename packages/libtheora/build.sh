CLANDRO_PKG_HOMEPAGE=https://www.theora.org/
CLANDRO_PKG_DESCRIPTION="An open video codec developed by the Xiph.org"
CLANDRO_PKG_LICENSE="BSD"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.2.0
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://downloads.xiph.org/releases/theora/libtheora-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=279327339903b544c28a92aeada7d0dcfd0397b59c2f368cc698ac56f515906e
CLANDRO_PKG_DEPENDS="libogg, libvorbis"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--disable-examples"

clandro_step_pre_configure() {
	# prior to libtheora 1.2.0, its assembly optimizations were not enabled by configure on 32-bit ARM Android
	# now, they are being automatically enabled on 32-bit ARM Android, but fail to build
	# and seem to be non-position-independent assembly because trying to fix them by reproducing and
	# fixing their errors on 32-bit GNU/Linux Clang until build succeeds there,
	# eventually leads to this when compiling the same code for 32-bit ARM Android:
	# ld.lld: error: relocation R_ARM_ABS32 cannot be used against local symbol; recompile with -fPIC
	# issue tracked upstream here: https://gitlab.xiph.org/xiph/theora/-/issues/2340
	if [[ "$CLANDRO_ARCH" == "arm" ]]; then
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" --disable-asm"
	fi
}
