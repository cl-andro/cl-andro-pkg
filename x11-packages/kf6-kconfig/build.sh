CLANDRO_PKG_HOMEPAGE="https://invent.kde.org/frameworks/kconfig"
CLANDRO_PKG_DESCRIPTION="Advanced configuration system (KDE)"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.26.0"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/frameworks/${CLANDRO_PKG_VERSION%.*}/kconfig-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=8bb5aa918d8e60ec140a33db3c329414d2319dc97a1644b368da5576125c92b5
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_DEPENDS="libc++, qt6-qtbase, qt6-qtdeclarative"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules (>= ${CLANDRO_PKG_VERSION%.*}), qt6-qttools, qt6-qtbase-cross-tools"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"

# All dependencies using `kconfig_compiler_kf6` must have `kf6-kconfig-cross-tools` in CLANDRO_PKG_BUILD_DEPENDS and have `-DKF6_HOST_TOOLING=$CLANDRO_PREFIX/opt/kf6/cross/lib/cmake/` in CLANDRO_PKG_EXTRA_CONFIGURE_ARGS.

clandro_step_host_build() {
	# CMakeLists.txt
	cp "$CLANDRO_PKG_SRCDIR/CMakeLists.txt" "$CLANDRO_PKG_SRCDIR/CMakeLists.txt.bak"
	sed -i '/project(/q' "$CLANDRO_PKG_SRCDIR/CMakeLists.txt" # keep project(KConfig VERSION ...) to denote the version
	cat >> "$CLANDRO_PKG_SRCDIR/CMakeLists.txt" <<-'EOF'

	include(ECMSetupVersion)

	set(kconfig_version_header "${CMAKE_CURRENT_BINARY_DIR}/src/core/kconfig_version.h")
	ecm_setup_version(PROJECT VARIABLE_PREFIX KCONFIG
							VERSION_HEADER "${kconfig_version_header}")

	find_package(Qt6 REQUIRED COMPONENTS Core Widgets Xml)

	function(ecm_mark_nongui_executable)
	endfunction()

	add_link_options("-Wl,-rpath=${CLANDRO_PREFIX}/opt/qt6/cross/lib")
	add_subdirectory(src/kconfig_compiler)
	EOF
	sed -e 's|#include "../core/kconfig_version.h"|#include "'"$CLANDRO_PKG_HOSTBUILD_DIR"'/src/core/kconfig_version.h"|' -i "$CLANDRO_PKG_SRCDIR/src/kconfig_compiler/kconfig_compiler.cpp"
	# build
	clandro_setup_cmake
	clandro_setup_ninja
	cmake \
		-G Ninja \
		-S "${CLANDRO_PKG_SRCDIR}" \
		-DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_PREFIX_PATH="$CLANDRO_PREFIX/opt/qt6/cross/lib/cmake" \
		-DCMAKE_INSTALL_PREFIX="$CLANDRO_PREFIX/opt/kf6/cross" \
		-DCMAKE_MODULE_PATH="$CLANDRO_PREFIX/share/ECM/modules" \
		-DKDE_INSTALL_LIBEXECDIR_KF=lib/libexec/kf6 \
		-DKDE_INSTALL_CMAKEPACKAGEDIR=lib/cmake \
		-DTERMUX_PREFIX="$CLANDRO_PREFIX"
	ninja \
		-j ${CLANDRO_PKG_MAKE_PROCESSES} \
		install
	# recover the CMakeLists.txt
	mv "$CLANDRO_PKG_SRCDIR/CMakeLists.txt.bak" "$CLANDRO_PKG_SRCDIR/CMakeLists.txt"
}

clandro_step_post_make_install() {
	mkdir -p "$CLANDRO_PREFIX/opt/kf6/cross/lib/cmake"
	cp -r "$CLANDRO_PREFIX/lib/cmake/KF6Config" "$CLANDRO_PREFIX/opt/kf6/cross/lib/cmake"
	sed -e 's|_IMPORT_PREFIX "'"$CLANDRO_PREFIX"'"|_IMPORT_PREFIX "'"$CLANDRO_PREFIX"'/opt/kf6/cross"|' -i "$CLANDRO_PREFIX/opt/kf6/cross/lib/cmake/KF6Config/KF6ConfigCompilerTargets.cmake"
	sed -e 's|'"$CLANDRO_PREFIX"'/lib/libexec/kf6/kconfig_compiler_kf6|'"$CLANDRO_PREFIX"'/opt/kf6/cross/lib/libexec/kf6/kconfig_compiler_kf6|' -i "$CLANDRO_PREFIX/opt/kf6/cross/lib/cmake/KF6Config/KF6ConfigCompilerTargets-release.cmake"
}
