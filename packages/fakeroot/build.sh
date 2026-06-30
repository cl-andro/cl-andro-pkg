CLANDRO_PKG_HOMEPAGE=https://packages.qa.debian.org/f/fakeroot.html
CLANDRO_PKG_DESCRIPTION="Tool for simulating superuser privileges (with tcp ipc)"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.38.1"
CLANDRO_PKG_SRCURL=https://deb.debian.org/debian/pool/main/f/fakeroot/fakeroot_${CLANDRO_PKG_VERSION}.orig.tar.gz
CLANDRO_PKG_SHA256=37c5063942efe2e2aeefd6e71ae2690bcb9b7d512c53bc6409b54d0730cbdac1
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--with-ipc=tcp"
CLANDRO_PKG_BUILD_DEPENDS="libcap"

clandro_step_pre_configure() {
	autoreconf -vfi

	CPPFLAGS+=" -D_ID_T"
}

clandro_step_post_make_install() {
	ln -sfr "${CLANDRO_PREFIX}/lib/libfakeroot-0.so" "${CLANDRO_PREFIX}/lib/libfakeroot.so"
}

clandro_step_create_debscripts() {
	{
		echo "#!$CLANDRO_PREFIX/bin/sh"
		echo "echo"
		echo "echo Fakeroot does not give you any real root permissions. This utility is primarily intended to be used for development purposes."
		echo "echo More info about usage at https://wiki.debian.org/FakeRoot."
		echo "echo"
		echo "echo Programs requiring real root permissions will not run under fakeroot. Do not post bug reports about this."
		echo "echo"
	} > ./postinst
}
