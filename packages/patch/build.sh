CLANDRO_PKG_HOMEPAGE=https://savannah.gnu.org/projects/patch/
CLANDRO_PKG_DESCRIPTION="GNU patch which applies diff files to create patched files"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.8
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://mirrors.kernel.org/gnu/patch/patch-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=f87cee69eec2b4fcbf60a396b030ad6aa3415f192aa5f7ee84cad5e11f7f5ae3
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--disable-xattr ac_cv_path_ED=$CLANDRO_PREFIX/bin/ed"
CLANDRO_PKG_GROUPS="base-devel"

clandro_step_pre_configure() {
	# https://android.googlesource.com/platform/bionic/+/master/docs/32-bit-abi.md#is-32_bit-on-lp32-y2038
	if [ $CLANDRO_ARCH_BITS = 32 ]; then
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" --disable-year2038"
	fi
}
