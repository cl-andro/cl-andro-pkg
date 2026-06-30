CLANDRO_PKG_HOMEPAGE=https://github.com/dirkvdb/ffmpegthumbnailer
CLANDRO_PKG_DESCRIPTION="Lightweight video thumbnailer that can be used by file managers"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.3.0
CLANDRO_PKG_SRCURL="https://github.com/dirkvdb/ffmpegthumbnailer/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=ddf561e294385f07d0bd5a28d0aab9de79b8dbaed29b576f206d58f3df79b508
CLANDRO_PKG_DEPENDS="ffmpeg, libc++, libjpeg-turbo, libpng"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DENABLE_GIO=ON
-DENABLE_THUMBNAILER=ON
"
