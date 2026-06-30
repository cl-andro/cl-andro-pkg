CLANDRO_PKG_HOMEPAGE=https://sites.google.com/site/tstyblo/wmctrl/
CLANDRO_PKG_DESCRIPTION="A UNIX/Linux command line tool to interact with an EWMH/NetWM compatible X Window Manager"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.07
CLANDRO_PKG_REVISION=2
# Origiginal source is unavailable so I am replacing it with debian's dump to make sure it will be rebuilt fine
#CLANDRO_PKG_SRCURL=https://sites.google.com/site/tstyblo/wmctrl/wmctrl-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SRCURL=http://deb.debian.org/debian/pool/main/w/wmctrl/wmctrl_1.07.orig.tar.gz
CLANDRO_PKG_SHA256=d78a1efdb62f18674298ad039c5cbdb1edb6e8e149bb3a8e3a01a4750aa3cca9
CLANDRO_PKG_DEPENDS="glib, libx11, libxmu"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--mandir=$CLANDRO_PREFIX/share/man
"
