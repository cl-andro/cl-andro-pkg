CLANDRO_PKG_HOMEPAGE="http://nongnu.org/jcal"
CLANDRO_PKG_DESCRIPTION="UNIX-cal-like tool to display Jalali (Persian/Iranian) calendar"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.5.1"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://github.com/persiancal/jcal/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=6cc477c668962de9250b7aebfdf0eee979ab94ec4f393dc04782024ef68fff45
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	cd sources
	./autogen.sh
	sed --in-place 's/$RM "$cfgfile"/$RM -f "$cfgfile"/g' configure
	CLANDRO_PKG_SRCDIR+="/sources"
}

clandro_step_post_configure() {
	# removing tests
	sed --in-place 's/test_kit//g' sources/Makefile.am
}
