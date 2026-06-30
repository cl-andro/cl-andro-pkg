CLANDRO_PKG_HOMEPAGE=https://github.com/Yisus7u7/lxqt-composer-settings
CLANDRO_PKG_DESCRIPTION="lxqt-composer-settings is an unofficial application to configure composition effects in LXQt."
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@Yisus7u7"
CLANDRO_PKG_VERSION=1.0.1
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/Yisus7u7/lxqt-composer-settings/releases/download/${CLANDRO_PKG_VERSION}/lxqt-composer-settings-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=d538a73302dd81c85fa3e9d3b2be7937435a73321b6dc11099db75d033181d50
CLANDRO_PKG_DEPENDS="libc++, qt5-qtbase, qt5-qtsvg, xcompmgr, picom"
CLANDRO_PKG_RECOMMENDS="featherpad"
CLANDRO_PKG_BUILD_DEPENDS="qt5-qtbase-cross-tools, qt5-qttools-cross-tools"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_configure(){
	"${CLANDRO_PREFIX}/opt/qt/cross/bin/qmake" \
		-spec "${CLANDRO_PREFIX}/lib/qt/mkspecs/termux-cross" PREFIX=${CLANDRO_PREFIX}
}
