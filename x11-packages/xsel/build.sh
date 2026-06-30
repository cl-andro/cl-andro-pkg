CLANDRO_PKG_HOMEPAGE=http://www.kfish.org/software/xsel/
CLANDRO_PKG_DESCRIPTION="Command-line program for getting and setting the contents of the X selection"
CLANDRO_PKG_LICENSE="HPND"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.2.1
CLANDRO_PKG_SRCURL=https://github.com/kfish/xsel/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=18487761f5ca626a036d65ef2db8ad9923bf61685e06e7533676c56d7d60eb14
CLANDRO_PKG_DEPENDS="libx11"

clandro_step_pre_configure() {
	autoreconf -fi
}
