CLANDRO_PKG_HOMEPAGE=https://calcurse.org/
CLANDRO_PKG_DESCRIPTION="calcurse is a calendar and scheduling application for the command line"
CLANDRO_PKG_LICENSE="BSD 2-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.8.2"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL="https://calcurse.org/files/calcurse-$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=849ba852c7f37b6772365cb0c42a94cde0fe75efba91363e96a0e7ef797ba565
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libandroid-support, ncurses"
CLANDRO_PKG_RECOMMENDS="calcurse-caldav"

clandro_step_pre_configure() {
	export ac_cv_lib_pthread_pthread_create=yes
}
