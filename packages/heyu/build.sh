CLANDRO_PKG_HOMEPAGE=https://www.heyu.org/
CLANDRO_PKG_DESCRIPTION="Program for remotely controlling lights and appliances"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1:2.10.3
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL="https://github.com/HeyuX10Automation/heyu/archive/refs/tags/v${CLANDRO_PKG_VERSION:2}.tar.gz"
CLANDRO_PKG_SHA256=0c3435ea9cd57cd78c29047b9c961f4bfbec39f42055c9949acd10dd9853b628
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	# rindex is an obsolete version of strrchr which is not available in Android:
	CFLAGS+=" -Drindex=strrchr"
	sed -e "s|@CLANDRO_CC@|${CC}|g" \
		-e "s|@CLANDRO_PREFIX@|${CLANDRO_PREFIX}|g" \
		"${CLANDRO_PKG_BUILDER_DIR}"/Configure.diff | patch -p1
}

clandro_step_configure() {
	./Configure linux
}
