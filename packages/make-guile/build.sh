CLANDRO_PKG_HOMEPAGE=https://www.gnu.org/software/make/
CLANDRO_PKG_DESCRIPTION="Tool to control the generation of non-source files from source files"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
# Update both make and make-guile to the same version in one PR.
CLANDRO_PKG_VERSION=4.4.1
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://mirrors.kernel.org/gnu/make/make-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=dd16fb1d67bfab79a72f5e8390735c49e3e8e70b4945a15ab1f81ddb78658fb3
CLANDRO_PKG_DEPENDS="guile"
CLANDRO_PKG_BREAKS="make-dev"
CLANDRO_PKG_REPLACES="make-dev"
# Prevent linking against libelf:
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_lib_elf_elf_begin=no"
# Prevent linking against libiconv:
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" am_cv_func_iconv=no"

# make-guile:
CLANDRO_PKG_CONFLICTS="make"
CLANDRO_PKG_PROVIDES="make"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" --with-guile"

clandro_step_pre_configure() {
	if [ "$CLANDRO_ARCH" = arm ]; then
		# Fix issue with make on arm hanging at least under cmake:
		# https://github.com/termux/termux-packages/issues/2983
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_func_pselect=no"
	fi
}

clandro_step_make() {
	# Allow to bootstrap make if building on device without make installed.
	if $CLANDRO_ON_DEVICE_BUILD && [ -z "$(command -v make)" ]; then
		./build.sh
	else
		make -j $CLANDRO_PKG_MAKE_PROCESSES
	fi
}

clandro_step_make_install() {
	if $CLANDRO_ON_DEVICE_BUILD && [ -z "$(command -v make)" ]; then
		./make -j 1 install
	else
		make -j 1 install
	fi
}
