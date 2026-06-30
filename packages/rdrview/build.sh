CLANDRO_PKG_HOMEPAGE=https://github.com/eafer/rdrview
CLANDRO_PKG_DESCRIPTION="Command line tool to extract the main content from a webpage"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1:0.1.5"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://github.com/eafer/rdrview/archive/refs/tags/v${CLANDRO_PKG_VERSION#*:}.tar.gz"
CLANDRO_PKG_SHA256=e83266cb2e3b16a42f3433101d1f312350ce1442561eaded67efb51c2e8e8aab
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_DEPENDS="libcurl, libiconv, libseccomp, libxml2"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	LDFLAGS+=" -liconv"
}
