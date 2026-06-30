CLANDRO_PKG_HOMEPAGE=https://github.com/Netflix/dynomite
CLANDRO_PKG_DESCRIPTION="A thin, distributed dynamo layer for different storage engines and protocols"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.6.22
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://github.com/Netflix/dynomite/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=9c3c60d95b39939f3ce596776febe8aa00ae8614ba85aa767e74d41e302e704a
CLANDRO_PKG_DEPENDS="libyaml, openssl"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_epoll_works=yes
ac_cv_evports_works=no
ac_cv_header_execinfo_h=no
ac_cv_kqueue_works=no
"
clandro_step_pre_configure() {
	autoreconf -fi

	LDFLAGS+=" -Wl,-z,muldefs"
}
