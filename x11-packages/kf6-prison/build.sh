CLANDRO_PKG_HOMEPAGE="https://invent.kde.org/frameworks/prison"
CLANDRO_PKG_DESCRIPTION="A barcode API to produce QRCode barcodes and DataMatrix barcodes"
CLANDRO_PKG_LICENSE="BSD 3-Clause, CC0-1.0, MIT"
CLANDRO_PKG_LICENSE_FILE="
LICENSES/BSD-3-Clause.txt
LICENSES/CC0-1.0.txt
LICENSES/MIT.txt
"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.26.0"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/frameworks/${CLANDRO_PKG_VERSION%.*}/prison-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=0414ddc310bca5eecfc1a6f9d4463b8a6d81894db4128ac43b4f8c1e14b73b5b
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++, libdmtx, libqrencode, qt6-qtbase, qt6-qtmultimedia, libzxing-cpp"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules, qt6-qtdeclarative, qt6-qttools"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"
