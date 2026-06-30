CLANDRO_PKG_HOMEPAGE=https://lxqt.github.io
CLANDRO_PKG_DESCRIPTION="OpenBox window manager configuration tool"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.16.6"
CLANDRO_PKG_SRCURL="https://github.com/lxqt/obconf-qt/releases/download/${CLANDRO_PKG_VERSION}/obconf-qt-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=23cc8d16fa639871a2087644527afddcdbac9553a65768f7847f598de29d0715
CLANDRO_PKG_REPLACES="obconf"
CLANDRO_PKG_BREAKS="obconf"
CLANDRO_PKG_DEPENDS="libc++, qt6-qtbase, glib, openbox, liblxqt, hicolor-icon-theme, libxml2"
CLANDRO_PKG_BUILD_DEPENDS="lxqt-build-tools, qt6-qtbase-cross-tools, qt6-qttools-cross-tools"
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DQt6LinguistTools_DIR=${CLANDRO_PREFIX}/opt/qt6/cross/lib/cmake/Qt6LinguistTools"
	fi
}

clandro_step_post_make_install() {
	ln -sf obconf-qt "$CLANDRO_PREFIX"/bin/obconf
}
