CLANDRO_PKG_HOMEPAGE=https://www.qt.io/
CLANDRO_PKG_DESCRIPTION="Classes for QML and JavaScript languages"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.11.0"
CLANDRO_PKG_SRCURL="https://download.qt.io/official_releases/qt/${CLANDRO_PKG_VERSION%.*}/${CLANDRO_PKG_VERSION}/submodules/qtdeclarative-everywhere-src-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=4eece569431ddf8324e7d322fa27001916570b23df535f8fb28aba445eedfde9
CLANDRO_PKG_DEPENDS="libc++, qt6-qtbase (>= ${CLANDRO_PKG_VERSION})"
CLANDRO_PKG_BUILD_DEPENDS="qt6-qtlanguageserver (>= ${CLANDRO_PKG_VERSION}), qt6-shadertools (>= ${CLANDRO_PKG_VERSION})"
CLANDRO_PKG_RECOMMENDS="qt6-qtlanguageserver"
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_NO_STATICSPLIT=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_MESSAGE_LOG_LEVEL=STATUS
-DCMAKE_SYSTEM_NAME=Linux
-DINSTALL_PUBLICBINDIR=${CLANDRO_PREFIX}/bin
-DQT_BUILD_TOOLS_BY_DEFAULT=ON
-DQT_FORCE_BUILD_TOOLS=ON
-DQT_HOST_PATH=${CLANDRO_PREFIX}/opt/qt6/cross
"
CLANDRO_PKG_RM_AFTER_INSTALL="
lib/objects-*
lib/qt6/qml/Qt/test/controls/objects-*
opt/qt6/cross/lib/objects-*
opt/qt6/cross/lib/qt6/qml/Qt/test/controls/objects-*
"

clandro_step_host_build() {
	clandro_setup_cmake
	clandro_setup_ninja

	cmake \
		-G Ninja \
		-S ${CLANDRO_PKG_SRCDIR} \
		-DCMAKE_BUILD_TYPE=MinSizeRel \
		-DCMAKE_INSTALL_PREFIX=${CLANDRO_PREFIX}/opt/qt6/cross \
		-DCMAKE_MESSAGE_LOG_LEVEL=STATUS \
		-DINSTALL_PUBLICBINDIR=${CLANDRO_PREFIX}/opt/qt6/cross/bin
	ninja \
		-j ${CLANDRO_PKG_MAKE_PROCESSES} \
		install

	mkdir -p ${CLANDRO_PREFIX}/opt/qt6/cross/bin
	find "$PWD" -type f -name user_facing_tool_links.txt \
		-exec echo "{}" \; \
		-exec cat "{}" \; \
		-exec sed -e "s|^${CLANDRO_PREFIX}/opt/qt6/cross|..|g" -i "{}" \;

	while read -r target link; do
		ln -sfv "$target" "$CLANDRO_PREFIX/opt/qt6/cross/$link"
	done < "$PWD/user_facing_tool_links.txt"
}

clandro_step_pre_configure() {
	clandro_setup_cmake
	clandro_setup_ninja

	# The -flto flag seems to be used only when compiling and not linking,
	# which breaks the NDK clang fallback to emulated TLS - see
	# https://github.com/termux/termux-packages/issues/21733:
	LDFLAGS+=" -flto"
}

clandro_step_make_install() {
	cmake \
		--install "${CLANDRO_PKG_BUILDDIR}" \
		--prefix "${CLANDRO_PREFIX}" \
		--verbose
}

clandro_step_post_make_install() {
	find ${CLANDRO_PKG_BUILDDIR} -type f -name user_facing_tool_links.txt \
		-exec echo "{}" \; \
		-exec cat "{}" \;

	while read -r target link; do
		ln -sfv "$target" "$CLANDRO_PREFIX/$link"
	done < "$PWD/user_facing_tool_links.txt"
}
