CLANDRO_PKG_HOMEPAGE=https://www.gnu.org/software/gzip/
CLANDRO_PKG_DESCRIPTION="Standard GNU file compression utilities"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.14
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://mirrors.kernel.org/gnu/gzip/gzip-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=01a7b881bd220bfdf615f97b8718f80bdfd3f6add385b993dcf6efd14e8c0ac6
CLANDRO_PKG_ESSENTIAL=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_path_GREP=grep"
CLANDRO_PKG_GROUPS="base-devel"

clandro_step_pre_configure() {
	if [ $CLANDRO_ARCH = i686 ]; then
		# Avoid text relocations
		export DEFS="NO_ASM"
	fi
}
