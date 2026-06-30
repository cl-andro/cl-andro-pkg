CLANDRO_PKG_HOMEPAGE='https://invent.kde.org/frameworks/kglobalaccel'
CLANDRO_PKG_DESCRIPTION='Add support for global workspace shortcuts'
CLANDRO_PKG_LICENSE="LGPL-2.0, LGPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.26.0"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/frameworks/${CLANDRO_PKG_VERSION%.*}/kglobalaccel-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=3f19d22d143577e5ddcc883170fe19a56f8f65766e41c4f9c011c4dfbde17a61
CLANDRO_PKG_DEPENDS="qt6-qtbase"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules (>= ${CLANDRO_PKG_VERSION%.*}), libc++, qt6-qttools"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"

clandro_step_post_make_install() {
	mkdir -p "$PREFIX/share/dbus-1/services"

	cat > "$PREFIX/share/dbus-1/services/org.kde.kglobalaccel.service" <<EOF
[D-BUS Service]
Name=org.kde.kglobalaccel
Exec=$PREFIX/lib/libexec/kglobalacceld
EOF
}
