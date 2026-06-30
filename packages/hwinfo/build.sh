# cl-andro (alamgir-zk) — ported from termux
CLANDRO_PKG_HOMEPAGE=https://github.com/openSUSE/hwinfo
CLANDRO_PKG_DESCRIPTION="Hardware detection tool from openSUSE"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=22.3
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/openSUSE/hwinfo/archive/refs/tags/$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=4ce5a852a9c58d70f59108382448097ffc4783ff336978ae49ec870ce02e99db
CLANDRO_PKG_DEPENDS="libandroid-shmem, libuuid, libx86emu"
CLANDRO_PKG_BREAKS="hwinfo-dev"
CLANDRO_PKG_REPLACES="hwinfo-dev"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	sed -i -E '/^SUBDIRS\s*=/d' Makefile
	echo -e '\n$(LIBHD):\n\t$(MAKE) -C src' >> Makefile
	echo -e '\t$(CC) -shared $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) \' >> Makefile
	echo -e '\t\t-Wl,--whole-archive $(LIBHD) -Wl,--no-whole-archive \' >> Makefile
	echo -e '\t\t-Wl,-soname=$(LIBHD_SONAME) -o $(LIBHD_SO) $(SO_LIBS)' >> Makefile
}

clandro_step_configure() {
	echo 'touch changelog' > git2log
	LDFLAGS+=" -landroid-shmem"
	export HWINFO_VERSION="$CLANDRO_PKG_VERSION"
	export DESTDIR="$CLANDRO_PREFIX"
}
