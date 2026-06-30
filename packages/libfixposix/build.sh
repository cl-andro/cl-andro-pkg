CLANDRO_PKG_HOMEPAGE=https://github.com/sionescu/libfixposix/
CLANDRO_PKG_DESCRIPTION="Thin wrapper over POSIX syscalls"
CLANDRO_PKG_LICENSE="BSL-1.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.5.1
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/sionescu/libfixposix/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=5d9d3d321d4c7302040389c43f966a70d180abb58d1d7df370f39e0d402d50d4
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_have_decl_TIOCSCTTY=yes
ac_cv_prog_PKGCONFIG=yes
"

clandro_step_pre_configure() {
	autoreconf -fi
}
