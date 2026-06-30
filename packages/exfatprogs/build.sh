CLANDRO_PKG_HOMEPAGE="https://github.com/exfatprogs/exfatprogs"
CLANDRO_PKG_DESCRIPTION="exFAT filesystem userspace utilities"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.3.2"
CLANDRO_PKG_SRCURL="https://github.com/exfatprogs/exfatprogs/releases/download/${CLANDRO_PKG_VERSION}/exfatprogs-${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=0c5d445947df781f90ba6bfddbd323bd6324c78a51fe75380a6ce2238c3cbcce
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	CFLAGS+=" -D_FILE_OFFSET_BITS=64"
	CPPFLAGS+=" -D_FILE_OFFSET_BITS=64"
}
