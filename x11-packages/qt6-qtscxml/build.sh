CLANDRO_PKG_HOMEPAGE=https://www.qt.io/
CLANDRO_PKG_DESCRIPTION="Qt6 SCXML Library"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.11.0"
CLANDRO_PKG_SRCURL="https://download.qt.io/official_releases/qt/${CLANDRO_PKG_VERSION%.*}/${CLANDRO_PKG_VERSION}/submodules/qtscxml-everywhere-src-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=6c383a53c0c3668fcc80d89f00193f0e928a784199c591213cbed1bf2f64d4e7
CLANDRO_PKG_DEPENDS="libc++, qt6-qtbase (>= ${CLANDRO_PKG_VERSION}), qt6-qtdeclarative (>= ${CLANDRO_PKG_VERSION})"
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_NO_STATICSPLIT=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DCMAKE_INSTALL_PREFIX=${CLANDRO_PREFIX}/opt/qt6/cross
-DINSTALL_PUBLICBINDIR=${CLANDRO_PREFIX}/opt/qt6/cross/bin
-DQT_HOST_PATH=${CLANDRO_PREFIX}/opt/qt6/cross
"

clandro_step_host_build() {
	clandro_setup_cmake
	clandro_setup_ninja

	cmake \
		-G Ninja \
		-S ${CLANDRO_PKG_SRCDIR} \
		-DCMAKE_BUILD_TYPE=MinSizeRel \
		-DCMAKE_INSTALL_PREFIX=${CLANDRO_PREFIX}/opt/qt6/cross \
		-DINSTALL_PUBLICBINDIR=${CLANDRO_PREFIX}/opt/qt6/cross/bin
	ninja \
		-j ${CLANDRO_PKG_MAKE_PROCESSES} \
		install
}

clandro_step_make_install() {
	cmake \
		--install "${CLANDRO_PKG_BUILDDIR}" \
		--prefix "${CLANDRO_PREFIX}" \
		--verbose

	# Remove *.la files
	find "${CLANDRO_PREFIX}/lib" -iname \*.la -delete
}
