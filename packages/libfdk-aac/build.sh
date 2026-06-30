# Contributor: @DLC01
CLANDRO_PKG_HOMEPAGE=https://github.com/mstorsjo/fdk-aac
CLANDRO_PKG_DESCRIPTION="Fraunhofer FDK AAC Codec Library"
CLANDRO_PKG_LICENSE="custom"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.0.3"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/mstorsjo/fdk-aac/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=e25671cd96b10bad896aa42ab91a695a9e573395262baed4e4a2ff178d6a3a78
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_LICENSE_FILE=NOTICE

clandro_step_pre_configure() {
	./autogen.sh
}
