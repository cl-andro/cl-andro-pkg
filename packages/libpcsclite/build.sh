CLANDRO_PKG_HOMEPAGE=https://pcsclite.apdu.fr/
CLANDRO_PKG_DESCRIPTION="Middleware to access a smart card using SCard API (PC/SC)."
CLANDRO_PKG_LICENSE="BSD 3-Clause, GPL-3.0, BSD 2-Clause, ISC"
CLANDRO_PKG_LICENSE_FILE="COPYING, GPL-3.0.txt"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.4.1"
CLANDRO_PKG_SRCURL=https://github.com/LudovicRousseau/PCSC/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=e7b6737f68c3b9a763fb0b0370d899cea091cced9d762ca8a6032c959576d5be
CLANDRO_PKG_DEPENDS="python"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BREAKS="libpcsclite-dev"
CLANDRO_PKG_REPLACES="libpcsclite-dev"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dpolkit=false
-Dusbdropdir=$CLANDRO_PREFIX/lib/pcsc/drivers
-Dipcdir=$CLANDRO_PREFIX/var/run
-Dlibsystemd=false
-Dlibudev=false
"

clandro_step_create_debscripts() {
	# "pcscd fails to start if this folder does not exist"
	echo "#!$CLANDRO_PREFIX/bin/sh" > postinst
	echo "mkdir -p $CLANDRO_PREFIX/lib/pcsc/drivers" >> postinst
}
