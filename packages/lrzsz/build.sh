CLANDRO_PKG_HOMEPAGE=https://ohse.de/uwe/software/lrzsz.html
CLANDRO_PKG_DESCRIPTION="Tools for zmodem/xmodem/ymodem file transfer"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.12.21-rc1
CLANDRO_PKG_REVISION=2
_COMMIT=8cb2a6a29f6345f84d5e8248e2d3376166ab844f
CLANDRO_PKG_SRCURL=https://github.com/UweOhse/lrzsz/archive/$_COMMIT.tar.gz
CLANDRO_PKG_SHA256=56f79c3eb8f6b140693667802d516824c2e115a83d15e1b4d5adbe1deab7c2e0
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_METHOD=repology
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-syslog
--mandir=$CLANDRO_PREFIX/share/man
"

clandro_step_pre_configure() {
	autoreconf -vfi
}
