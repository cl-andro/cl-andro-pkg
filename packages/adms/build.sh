CLANDRO_PKG_HOMEPAGE="https://github.com/qucs/adms"
CLANDRO_PKG_DESCRIPTION="A code generator for the Verilog-AMS language"
CLANDRO_PKG_GROUPS="science"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.3.7"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://github.com/Qucs/ADMS/archive/refs/tags/release-$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=0d24f645d7ce0daa447af1b0cff1123047f3b73cc41cf403650f469721f95173
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--enable-maintainer-mode
--enable-shared
--disable-static
"

clandro_step_pre_configure() {
	./bootstrap.sh
}
