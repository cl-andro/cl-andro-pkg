CLANDRO_PKG_HOMEPAGE=https://github.com/coin-or/Osi
CLANDRO_PKG_DESCRIPTION="An abstract base class to a generic linear programming (LP) solver"
CLANDRO_PKG_LICENSE="EPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1:0.108.8
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/coin-or/Osi/archive/refs/tags/releases/${CLANDRO_PKG_VERSION#*:}.tar.gz
CLANDRO_PKG_SHA256=8b01a49190cb260d4ce95aa7e3948a56c0917b106f138ec0a8544fadca71cf6a
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_METHOD=repology
CLANDRO_PKG_DEPENDS="libc++, libcoinor-utils"

clandro_step_pre_configure() {
	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}
