CLANDRO_PKG_HOMEPAGE=https://github.com/tgraf/bmon
CLANDRO_PKG_DESCRIPTION="Bandwidth monitor and rate estimator"
CLANDRO_PKG_LICENSE="MIT, BSD 2-Clause"
CLANDRO_PKG_LICENSE_FILE="LICENSE.MIT, LICENSE.BSD"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=4.0
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_SRCURL=https://github.com/tgraf/bmon/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=d5e503ff6b116c681ebf4d10e238604dde836dceb9c0008eb92416a96c87ca40
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libconfuse, libnl, ncurses"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	./autogen.sh
}
