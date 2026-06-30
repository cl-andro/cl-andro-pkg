CLANDRO_PKG_HOMEPAGE=https://github.com/jart/hiptext
CLANDRO_PKG_DESCRIPTION="Turn images into text better than caca/aalib"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.2
CLANDRO_PKG_REVISION=8
CLANDRO_PKG_SRCURL=https://github.com/jart/hiptext/releases/download/$CLANDRO_PKG_VERSION/hiptext-$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=7f2217dec8775b445be6745f7bd439c24ce99c4316a9faf657bee7b42bc72e8f
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="ffmpeg, freetype, gflags, google-glog, libjpeg-turbo, libpng, ncurses"
CLANDRO_PKG_BUILD_DEPENDS="ragel"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	#Font reference on file font.cc --> Patch by font.cc.patch
	#Because of ttf-dejavu is x11 package, the hiptext is not a x11 package.
	install -Dm600 -t "$CLANDRO_PREFIX"/share/hiptext/ \
		"$CLANDRO_PKG_SRCDIR"/DejaVuSansMono.ttf
}
