CLANDRO_PKG_HOMEPAGE=https://www.qt.io/
CLANDRO_PKG_DESCRIPTION="Qt Development Tools (Linguist, Assistant, Designer, etc.)"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.11.0"
CLANDRO_PKG_SRCURL="https://download.qt.io/official_releases/qt/${CLANDRO_PKG_VERSION%.*}/${CLANDRO_PKG_VERSION}/submodules/qttools-everywhere-src-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=cfb1993d7a10848965b01b9cf33a54b8a4ba4e5e3a6d28d59483e73f10d9fc76
CLANDRO_PKG_DEPENDS="libc++, qt6-qtbase (>= ${CLANDRO_PKG_VERSION}), zstd"
CLANDRO_PKG_BUILD_DEPENDS="qt6-qtdeclarative (>= ${CLANDRO_PKG_VERSION})"
CLANDRO_PKG_RECOMMENDS="qt6-qtdeclarative"
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_NO_STATICSPLIT=true
CLANDRO_PKG_AUTO_UPDATE=true
# disable clang, can not find libclangBasic.a
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_DISABLE_FIND_PACKAGE_Clang=ON
-DCMAKE_MESSAGE_LOG_LEVEL=STATUS
-DCMAKE_SYSTEM_NAME=Linux
-DINSTALL_PUBLICBINDIR=${CLANDRO_PREFIX}/bin
-DQT_BUILD_TOOLS_BY_DEFAULT=ON
-DQT_FORCE_BUILD_TOOLS=ON
-DQT_HOST_PATH=${CLANDRO_PREFIX}/opt/qt6/cross
"

clandro_step_host_build() {
	clandro_setup_cmake
	clandro_setup_ninja

	cmake \
		-G Ninja \
		-S ${CLANDRO_PKG_SRCDIR} \
		-DCMAKE_BUILD_TYPE=MinSizeRel \
		-DCMAKE_DISABLE_FIND_PACKAGE_Clang=ON \
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
