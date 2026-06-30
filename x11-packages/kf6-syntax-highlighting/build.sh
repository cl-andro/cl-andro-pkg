CLANDRO_PKG_HOMEPAGE="https://invent.kde.org/frameworks/syntax-highlighting"
CLANDRO_PKG_DESCRIPTION="Syntax highlighting Engine for Structured Text and Code"
CLANDRO_PKG_LICENSE="GPL-2.0-only, LGPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.26.0"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/frameworks/${CLANDRO_PKG_VERSION%.*}/syntax-highlighting-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=a4e86d167cd5f3c4318584119451f891551c24cd4a0ff1f7ef95e2476a39c5ac
CLANDRO_PKG_DEPENDS="libc++, qt6-qtdeclarative, qt6-qtbase"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules, qt6-qttools"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"

clandro_step_host_build() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "true" ]]; then
		return
	fi

	clandro_setup_cmake
	clandro_setup_ninja

	cmake -G Ninja \
		-S "${CLANDRO_PKG_SRCDIR}" \
		-B "${CLANDRO_PKG_HOSTBUILD_DIR}" \
		-DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_INSTALL_PREFIX=$CLANDRO_PREFIX/opt/kf6/cross \
		-DCMAKE_PREFIX_PATH="$CLANDRO_PREFIX/opt/qt6/cross/lib/cmake" \
		-DCMAKE_MODULE_PATH="$CLANDRO_PREFIX/share/ECM/modules" \
		-DECM_DIR="$CLANDRO_PREFIX/share/ECM/cmake" \
		-DTERMUX_PREFIX="$CLANDRO_PREFIX" \
		-DCMAKE_INSTALL_LIBDIR=lib

	ninja -j ${CLANDRO_PKG_MAKE_PROCESSES} install


	# Copy katehighlightingindexer to cross/bin
	mkdir -p "$CLANDRO_PREFIX/opt/kf6/cross/bin"
	cp "$CLANDRO_PKG_HOSTBUILD_DIR/bin/katehighlightingindexer" \
		"$CLANDRO_PREFIX/opt/kf6/cross/bin/"
}

clandro_step_pre_configure() {
	# Reset hostbuild marker
	rm -rf "$CLANDRO_HOSTBUILD_MARKER"
	# Apply patch only for on-device builds
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "true" ]]; then
		patch="$CLANDRO_PKG_BUILDER_DIR/on-device-build.diff"
		echo "Applying patch: $(basename "$patch")"
		patch --silent -p1 -d "$CLANDRO_PKG_SRCDIR" < "$patch"
		export PATH="$CLANDRO_PKG_BUILDDIR/bin:$PATH"
	else
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DKATEHIGHLIGHTINGINDEXER_EXECUTABLE=$CLANDRO_PREFIX/opt/kf6/cross/bin/katehighlightingindexer"
	fi
}
