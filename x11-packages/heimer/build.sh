CLANDRO_PKG_HOMEPAGE=https://github.com/juzzlin/Heimer
CLANDRO_PKG_DESCRIPTION="Heimer is a simple cross-platform mind map, diagram, and note-taking tool written in Qt."
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.5.0"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://github.com/juzzlin/Heimer/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=92bedc9a42eb80d872f4700ee5ee3bfa3884762831d0a11b735c6f72452a4726
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++, qt6-qtbase, qt6-qtsvg"
CLANDRO_PKG_BUILD_DEPENDS="qt6-qtbase-cross-tools, qt6-qttools-cross-tools"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_WITH_QT6=ON
-DCMAKE_POLICY_VERSION_MINIMUM=3.5
"
