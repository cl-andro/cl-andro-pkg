CLANDRO_PKG_HOMEPAGE=https://traceroute.sourceforge.net/
CLANDRO_PKG_DESCRIPTION="A new modern implementation of traceroute(8) utility for Linux systems"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.1.6"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://downloads.sourceforge.net/project/traceroute/traceroute/traceroute-${CLANDRO_PKG_VERSION}/traceroute-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=9ccef9cdb9d7a98ff7fbf93f79ebd0e48881664b525c4b232a0fcec7dcb9db5e
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_CONFLICTS="tracepath (<< 20221126-1)"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_MAKE_ARGS="prefix=$CLANDRO_PREFIX -e"

clandro_step_configure() {
	:
}
