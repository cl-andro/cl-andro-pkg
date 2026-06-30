CLANDRO_PKG_HOMEPAGE=https://www.qt.io/
CLANDRO_PKG_DESCRIPTION="Qt6 Multimedia Library"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.11.0"
CLANDRO_PKG_SRCURL="https://download.qt.io/official_releases/qt/${CLANDRO_PKG_VERSION%.*}/${CLANDRO_PKG_VERSION}/submodules/qtmultimedia-everywhere-src-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=90c4cac0a7a983b68d1b0873d0714e7873b9a493403fa8593e8a4eea3ea26040
CLANDRO_PKG_DEPENDS="glib, gst-libav, gst-plugins-bad, gst-plugins-base, gstreamer, libc++, opengl, pulseaudio, qt6-qtbase (>= ${CLANDRO_PKG_VERSION}), qt6-qtdeclarative (>= ${CLANDRO_PKG_VERSION})"
CLANDRO_PKG_BUILD_DEPENDS="qt6-shadertools"
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_NO_STATICSPLIT=true
CLANDRO_PKG_AUTO_UPDATE=true
# enable ffmpeg plugin if desired; depends on ffmpeg and libandroid-shmem
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_MESSAGE_LOG_LEVEL=STATUS
-DCMAKE_SYSTEM_NAME=Linux
-DINPUT_ffmpeg=no
"

clandro_step_host_build() {
	clandro_setup_cmake
	clandro_setup_ninja

	cmake \
		-G Ninja \
		-S ${CLANDRO_PKG_SRCDIR} \
		-DCMAKE_BUILD_TYPE=MinSizeRel \
		-DCMAKE_INSTALL_PREFIX=${CLANDRO_PREFIX}/opt/qt6/cross \
		-DCMAKE_MESSAGE_LOG_LEVEL=STATUS
	ninja \
		-j ${CLANDRO_PKG_MAKE_PROCESSES} \
		install
}

clandro_step_pre_configure() {
	clandro_setup_cmake
	clandro_setup_ninja

	CXXFLAGS+=" -Wno-c++11-narrowing"
}

clandro_step_make_install() {
	cmake \
		--install "${CLANDRO_PKG_BUILDDIR}" \
		--prefix "${CLANDRO_PREFIX}" \
		--verbose

	# Drop QMAKE_PRL_BUILD_DIR because reference the build dir
	find "${CLANDRO_PREFIX}/lib" -type f -name "libQt6Multimedia*.prl" \
		-exec sed -i -e '/^QMAKE_PRL_BUILD_DIR/d' "{}" \;

	# Remove *.la files
	find "${CLANDRO_PREFIX}/lib" -iname \*.la -delete
}
