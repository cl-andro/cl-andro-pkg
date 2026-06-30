CLANDRO_PKG_HOMEPAGE='https://invent.kde.org/frameworks/breeze-icons'
CLANDRO_PKG_DESCRIPTION='Breeze icon theme'
CLANDRO_PKG_LICENSE="GPL-3.0, LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.26.0"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/frameworks/${CLANDRO_PKG_VERSION%.*}/breeze-icons-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=4e123fac511dfab2b7c505857849a5cecfac2ce6194e3230c51ceec31676b06e
CLANDRO_PKG_DEPENDS="qt6-qtbase"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules (>= ${CLANDRO_PKG_VERSION%.*}), python-lxml, qt6-qtbase-cross-tools"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DBUILD_TESTING=OFF
-DBINARY_ICONS_RESOURCE=ON
-DWITH_ICON_GENERATION=OFF
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"

clandro_step_host_build() {
	clandro_setup_cmake
	pushd "$CLANDRO_PKG_SRCDIR/tools"
	cp CMakeLists.txt CMakeLists.txt.bak
	patch -p1 -i "$CLANDRO_PKG_BUILDER_DIR"/tools-CMakeLists.txt.diff

	mkdir -p build
	cmake -B build \
		-DCMAKE_BUILD_TYPE=MinSizeRel \
		-DCMAKE_PREFIX_PATH="$CLANDRO_PREFIX/opt/qt6/cross/lib/cmake" \
		.
	cmake --build build
	mv CMakeLists.txt.bak CMakeLists.txt
	popd

	cp "$CLANDRO_PKG_SRCDIR"/tools/build/{generate-symbolic-dark,qrcAlias} "$CLANDRO_PKG_HOSTBUILD_DIR/"
}

clandro_step_pre_configure() {
	# this is a workaround for build-all.sh issue
	CLANDRO_PKG_DEPENDS+=", kf6-breeze-icons-data"

	sed -e 's|$<TARGET_FILE:generate-symbolic-dark>|'"$CLANDRO_PKG_HOSTBUILD_DIR"'/generate-symbolic-dark|' -i icons/CMakeLists.txt
	sed -e 's|$<TARGET_FILE:qrcAlias> -o|'"$CLANDRO_PKG_HOSTBUILD_DIR"'/qrcAlias -o|' -i icons/CMakeLists.txt
}
