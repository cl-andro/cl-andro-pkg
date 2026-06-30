CLANDRO_PKG_HOMEPAGE=https://github.com/neutrinolabs/xrdp
CLANDRO_PKG_DESCRIPTION="An open source remote desktop protocol (RDP) server"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.10.6"
CLANDRO_PKG_SRCURL=https://github.com/neutrinolabs/xrdp/releases/download/v${CLANDRO_PKG_VERSION}/xrdp-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=dfc21d5d603b642cf583987b36706b685bf05fd3aaaaacefb8f57c5f4a448677
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libandroid-shmem, libcrypt, libx11, libxfixes, libxrandr, openssl, procps, tigervnc"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-pam
--enable-static
--enable-strict-locations
--with-socketdir=$CLANDRO_PREFIX/tmp/.xrdp
"

CLANDRO_PKG_CONFFILES="
etc/xrdp/cert.pem
etc/xrdp/key.pem
etc/xrdp/km-00000405.ini
etc/xrdp/km-00000406.ini
etc/xrdp/km-00000407.ini
etc/xrdp/km-00000409.ini
etc/xrdp/km-0000040a.ini
etc/xrdp/km-0000040b.ini
etc/xrdp/km-0000040c.ini
etc/xrdp/km-00000410.ini
etc/xrdp/km-00000411.ini
etc/xrdp/km-00000412.ini
etc/xrdp/km-00000414.ini
etc/xrdp/km-00000415.ini
etc/xrdp/km-00000416.ini
etc/xrdp/km-00000419.ini
etc/xrdp/km-0000041d.ini
etc/xrdp/km-00000807.ini
etc/xrdp/km-00000809.ini
etc/xrdp/km-0000080a.ini
etc/xrdp/km-0000080c.ini
etc/xrdp/km-00000813.ini
etc/xrdp/km-00000816.ini
etc/xrdp/km-0000100c.ini
etc/xrdp/km-00010409.ini
etc/xrdp/km-19360409.ini
etc/xrdp/pulse/default.pa
etc/xrdp/reconnectwm.sh
etc/xrdp/sesman.ini
etc/xrdp/startwm.sh
etc/xrdp/xrdp.ini
etc/xrdp/xrdp_keyboard.ini
"

CLANDRO_PKG_RM_AFTER_INSTALL="
etc/default
etc/init.d
etc/xrdp/cert.pem
etc/xrdp/key.pem
"

clandro_step_pre_configure() {
	LDFLAGS+=" -Wl,-rpath=${CLANDRO_PREFIX}/lib/xrdp -Wl,--enable-new-dtags"
	export LIBS="-landroid-shmem"
}

clandro_step_create_debscripts() {
	{
		echo "#!${CLANDRO_PREFIX}/bin/sh"
		echo "if [ ! -e \"${CLANDRO_PREFIX}/etc/xrdp/rsakeys.ini\" ]; then"
		echo "    xrdp-keygen xrdp \"${CLANDRO_PREFIX}/etc/xrdp/rsakeys.ini\""
		echo "fi"
	} > ./postinst
	chmod 755 postinst
}
