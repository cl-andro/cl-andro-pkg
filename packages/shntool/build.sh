CLANDRO_PKG_HOMEPAGE=http://shnutils.freeshell.org/shntool/
CLANDRO_PKG_DESCRIPTION="A multi-purpose WAVE data processing and reporting utility"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=3.0.10
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=http://shnutils.freeshell.org/shntool/dist/src/shntool-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=74302eac477ca08fb2b42b9f154cc870593aec8beab308676e4373a5e4ca2102

clandro_step_pre_configure() {
	autoreconf -fi
}
