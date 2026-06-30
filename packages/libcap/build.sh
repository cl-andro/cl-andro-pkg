CLANDRO_PKG_HOMEPAGE=https://sites.google.com/site/fullycapable/
CLANDRO_PKG_DESCRIPTION="POSIX 1003.1e capabilities"
CLANDRO_PKG_LICENSE="BSD 3-Clause, GPL-2.0"
CLANDRO_PKG_LICENSE_FILE="License"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.69
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://kernel.org/pub/linux/libs/security/linux-privs/libcap2/libcap-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=f311f8f3dad84699d0566d1d6f7ec943a9298b28f714cae3c931dfd57492d7eb
CLANDRO_PKG_DEPENDS="attr"
CLANDRO_PKG_BREAKS="libcap-dev"
CLANDRO_PKG_REPLACES="libcap-dev"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make() {
	make CC="$CC -Wl,-rpath=$CLANDRO_PREFIX/lib -Wl,--enable-new-dtags" OBJCOPY=llvm-objcopy PREFIX="$CLANDRO_PREFIX" PTHREADS=no PAM_CAP=no
}

clandro_step_make_install() {
	make CC="$CC -Wl,-rpath=$CLANDRO_PREFIX/lib -Wl,--enable-new-dtags" OBJCOPY=llvm-objcopy prefix="$CLANDRO_PREFIX" RAISE_SETFCAP=no lib=/lib PTHREADS=no install PAM_CAP=no
}
