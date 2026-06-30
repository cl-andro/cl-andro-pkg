CLANDRO_PKG_HOMEPAGE=https://www.gnu.org/software/hello/
CLANDRO_PKG_DESCRIPTION="Prints a friendly greeting"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.12.3"
CLANDRO_PKG_SRCURL=https://mirrors.kernel.org/gnu/hello/hello-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=0d5f60154382fee10b114a1c34e785d8b1f492073ae2d3a6f7b147687b366aa0
CLANDRO_PKG_DEPENDS="libiconv"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	LDFLAGS+=" -liconv"
}
