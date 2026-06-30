CLANDRO_PKG_HOMEPAGE=https://eradman.com/entrproject/
CLANDRO_PKG_DESCRIPTION="Event Notify Test Runner - run arbitrary commands when files change"
CLANDRO_PKG_LICENSE="ISC"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="5.8"
CLANDRO_PKG_SRCURL=https://eradman.com/entrproject/code/entr-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=dc9a2bdc556b2be900c1d8cdf432de26492de5af3ffade000d4bfd97f3122bfb
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_configure() {
	./configure
}
