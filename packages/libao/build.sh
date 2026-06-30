CLANDRO_PKG_HOMEPAGE=https://www.xiph.org/ao/
CLANDRO_PKG_DESCRIPTION="A cross platform audio library"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.2.2
CLANDRO_PKG_REVISION=8
CLANDRO_PKG_SRCURL=https://github.com/xiph/libao/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=df8a6d0e238feeccb26a783e778716fb41a801536fe7b6fce068e313c0e2bf4d
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_DEPENDS="pulseaudio"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--enable-pulse"
CLANDRO_PKG_CONFFILES="etc/libao.conf"

clandro_step_pre_configure () {
	./autogen.sh
}

clandro_step_post_make_install () {
	#generate libao config file
	mkdir -p $CLANDRO_PREFIX/etc/
	cat << EOF > $CLANDRO_PREFIX/etc/libao.conf
default_driver=pulse
buffer_time=50
quiet
EOF
}
