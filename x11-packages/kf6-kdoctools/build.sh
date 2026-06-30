CLANDRO_PKG_HOMEPAGE="https://invent.kde.org/frameworks/kdoctools"
CLANDRO_PKG_DESCRIPTION="Documentation generation from docbook"
CLANDRO_PKG_LICENSE="LGPL-2.0-only, LGPL-3.0-only"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.26.0"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/frameworks/${CLANDRO_PKG_VERSION%.*}/kdoctools-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=3fbea5de215076130007f3c18e16b870774ffa4fc85ddace201ac020d0245fb6
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_DEPENDS="docbook-xsl, kf6-karchive, libc++, libxml2, libxslt, perl, qt6-qtbase"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules, kf6-ki18n, qt6-qttools"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DKF_IGNORE_PLATFORM_CHECK=ON
-DKF_SKIP_PO_PROCESSING=ON
-DINSTALL_INTERNAL_TOOLS=OFF
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"

clandro_step_host_build() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "true" ]]; then
		return
	fi

	clandro_download_ubuntu_packages libxslt1-dev

	clandro_setup_cmake
	clandro_setup_ninja

	cmake -G Ninja \
		-S "${CLANDRO_PKG_SRCDIR}" \
		-B "${CLANDRO_PKG_HOSTBUILD_DIR}" \
		-DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_INSTALL_PREFIX="$CLANDRO_PREFIX/opt/kf6/cross" \
		-DCMAKE_PREFIX_PATH="$CLANDRO_PREFIX/opt/qt6/cross/lib/cmake" \
		-DCMAKE_MODULE_PATH="$CLANDRO_PREFIX/share/ECM/modules" \
		-DECM_DIR="$CLANDRO_PREFIX/share/ECM/cmake" \
		-DLIBXSLT_LIBRARIES=/usr/lib/x86_64-linux-gnu/libxslt.so.1 \
		-DLIBXSLT_EXSLT_LIBRARY=/usr/lib/x86_64-linux-gnu/libexslt.so.0 \
		-DLIBXSLT_INCLUDE_DIR="$CLANDRO_PKG_HOSTBUILD_DIR/ubuntu_packages/usr/include/x86_64-linux-gnu;$CLANDRO_PKG_HOSTBUILD_DIR/ubuntu_packages/usr/include" \
		-DCMAKE_INSTALL_LIBDIR=lib \
		-DINSTALL_INTERNAL_TOOLS=ON

	ninja -C "${CLANDRO_PKG_HOSTBUILD_DIR}" docbookl10nhelper meinproc6

	ninja install
}

clandro_step_pre_configure() {
	# Reset hostbuild marker
	rm -rf "$CLANDRO_HOSTBUILD_MARKER"
	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+="
	-DDOCBOOKL10NHELPER_EXECUTABLE=$CLANDRO_PREFIX/opt/kf6/cross/bin/docbookl10nhelper
	-DMEINPROC6_EXECUTABLE=$CLANDRO_PREFIX/opt/kf6/cross/bin/meinproc6
	"
}

clandro_step_create_debscripts()  {
	cat <<- POSTINST_EOF > ./postinst
	#!$CLANDRO_PREFIX/bin/bash
	set -e

	export PERL_MM_USE_DEFAULT=1

	echo "Sideloading Perl URI::Escape ..."
	cpan -Ti URI::Escape

	exit 0
	POSTINST_EOF
}
