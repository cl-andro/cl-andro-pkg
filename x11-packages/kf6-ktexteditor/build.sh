CLANDRO_PKG_HOMEPAGE="https://invent.kde.org/frameworks/ktexteditor"
CLANDRO_PKG_DESCRIPTION="Advanced embeddable text editor by KDE"
CLANDRO_PKG_LICENSE="GPL-2.0-only, LGPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.25.0"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/frameworks/${CLANDRO_PKG_VERSION%.*}/ktexteditor-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=77e815edcdf572397f5eb750d7232b366f6cc6274bb34246ab88f2f2179733b4
CLANDRO_PKG_DEPENDS="editorconfig-core-c, git, kf6-karchive, kf6-kauth, kf6-kcodecs, kf6-kcolorscheme, kf6-kcompletion, kf6-kconfig, kf6-kconfigwidgets, kf6-kcoreaddons, kf6-kguiaddons, kf6-ki18n, kf6-kio, kf6-kitemviews, kf6-kparts, kf6-kwidgetsaddons, kf6-kxmlgui, kf6-sonnet, kf6-syntax-highlighting, libc++, qt6-qtbase, qt6-qtdeclarative, qt6-qtspeech"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules, qt6-qttools"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"
