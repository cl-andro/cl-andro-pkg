CLANDRO_PKG_HOMEPAGE=https://ssdeep-project.github.io/ssdeep/
CLANDRO_PKG_DESCRIPTION="A program for computing context triggered piecewise hashes (CTPH)"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.14.1
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://github.com/ssdeep-project/ssdeep/archive/refs/tags/release-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=d96f667a8427ad96da197884574c7ca8c7518a37d9ac8593b6ea77e7945720a4
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-auto-search
"

clandro_step_pre_configure() {
	autoreconf -fi
}
