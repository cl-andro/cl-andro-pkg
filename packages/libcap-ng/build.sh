CLANDRO_PKG_HOMEPAGE=https://people.redhat.com/sgrubb/libcap-ng/
CLANDRO_PKG_DESCRIPTION="Library making programming with POSIX capabilities easier than traditional libcap"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2:0.9.3"
CLANDRO_PKG_SRCURL=https://github.com/stevegrubb/libcap-ng/archive/refs/tags/v${CLANDRO_PKG_VERSION:2}.tar.gz
CLANDRO_PKG_SHA256=fe11ebbb55904763b3532f19069f13ec319042634620180a03bd4653d301563e
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--without-python
--without-python3
"

clandro_step_pre_configure() {
	./autogen.sh
}
