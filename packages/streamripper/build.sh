CLANDRO_PKG_HOMEPAGE=https://streamripper.sourceforge.net/
CLANDRO_PKG_DESCRIPTION="Records and splits streaming mp3 into tracks"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.64.6
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=https://downloads.sourceforge.net/sourceforge/streamripper/streamripper-$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=c1d75f2e9c7b38fd4695be66eff4533395248132f3cc61f375196403c4d8de42
CLANDRO_PKG_DEPENDS="glib, libmad, libogg, libvorbis"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_lib_pthread_pthread_create=yes"
