# cl-andro (alamgir-zk) — ported from termux
CLANDRO_PKG_HOMEPAGE=https://github.com/raboof/nethogs
CLANDRO_PKG_DESCRIPTION="Net top tool grouping bandwidth per process"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.8.7
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/raboof/nethogs/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=957d6afcc220dfbba44c819162f44818051c5b4fb793c47ba98294393986617d
CLANDRO_PKG_DEPENDS="libc++, ncurses, libpcap"
CLANDRO_PKG_EXTRA_MAKE_ARGS="nethogs"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_post_get_source() {
	mv pyproject.toml{,.unused}
	mv setup.py{,.unused}
}

clandro_step_pre_configure() {
	CPPFLAGS+=" -Dindex=strchr -Drindex=strrchr -Dquad_t=int64_t"
}
