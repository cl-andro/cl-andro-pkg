CLANDRO_PKG_HOMEPAGE=http://spek.cc/
CLANDRO_PKG_DESCRIPTION="An acoustic spectrum analyser"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.8.5
CLANDRO_PKG_REVISION=8
CLANDRO_PKG_SRCURL=https://github.com/alexkay/spek/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=9053d2dec452dcde421daa0f5f59a9dee47927540f41d9c0c66800cb6dbf6996
CLANDRO_PKG_DEPENDS="ffmpeg, libc++, wxwidgets"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_path_WX_CONFIG_PATH=$CLANDRO_PREFIX/bin/wx-config"

clandro_step_pre_configure() {
	autoreconf -fi
}

clandro_step_create_subpkg_debscripts() {
	cat <<- EOF > ./postinst
	#!$CLANDRO_PREFIX/bin/sh
	echo "Note: If you encounter Segmentation Fault, then please open an issue at https://github.com/termux/termux-packages/issues"
	EOF
}
