CLANDRO_PKG_HOMEPAGE=https://www.qt.io/
CLANDRO_PKG_DESCRIPTION="A cross-platform application and UI framework"
CLANDRO_PKG_LICENSE="LGPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="5.15.18"
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_SRCURL="https://download.qt.io/archive/qt/${CLANDRO_PKG_VERSION%.*}/${CLANDRO_PKG_VERSION}/submodules/qtbase-everywhere-opensource-src-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=7b632550ea1048fc10c741e46e2e3b093e5ca94dfa6209e9e0848800e247023b
CLANDRO_PKG_DEPENDS="dbus, double-conversion, freetype, glib, harfbuzz, krb5, libandroid-execinfo, libandroid-posix-semaphore, libandroid-shmem, libc++, libice, libicu, libjpeg-turbo, libpng, libsm, libuuid, libx11, libxcb, libxi, libxkbcommon, opengl, openssl, pcre2, postgresql, ttf-dejavu, vulkan-loader, xcb-util-image, xcb-util-keysyms, xcb-util-renderutil, xcb-util-wm, xdg-utils, zlib"
# gtk3 dependency is a run-time dependency only for the gtk platformtheme subpackage
CLANDRO_PKG_BUILD_DEPENDS="gtk3, vulkan-headers"
CLANDRO_PKG_SUGGESTS="qt5-qmake"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_NO_STATICSPLIT=true

CLANDRO_PKG_RM_AFTER_INSTALL="
bin/fixqt4headers.pl
bin/syncqt.pl
"

# Replacing the old qt5-base packages
CLANDRO_PKG_REPLACES="qt5-base"
CLANDRO_PKG_BREAKS="qt5-x11extras, qt5-tools, qt5-declarative"

clandro_step_pre_configure () {
	if [ "${CLANDRO_ARCH}" = "arm" ]; then
		## -mfpu=neon causes build failure on ARM.
		CFLAGS="${CFLAGS/-mfpu=neon/} -mfpu=vfp"
		CXXFLAGS="${CXXFLAGS/-mfpu=neon/} -mfpu=vfp"
	fi

	# This is needed for some packages depends on qt5-qtbase, such
	# as qt5-qtwebengine
	# https://github.com/termux/termux-packages/issues/18810
	export LDFLAGS+=" -Wl,--undefined-version"

	## Create qmake.conf suitable for cross-compiling.
	sed \
		-e "s|@CLANDRO_PREFIX@|${CLANDRO_PREFIX}|g" \
		-e "s|@CLANDRO_CC@|${CLANDRO_HOST_PLATFORM}-clang|" \
		-e "s|@CLANDRO_CXX@|${CLANDRO_HOST_PLATFORM}-clang++|" \
		-e "s|@CLANDRO_AR@|llvm-ar|" \
		-e "s|@CLANDRO_NM@|llvm-nm|" \
		-e "s|@CLANDRO_OBJCOPY@|llvm-objcopy|" \
		-e "s|@CLANDRO_PKGCONFIG@|${CLANDRO_HOST_PLATFORM}-pkg-config|" \
		-e "s|@CLANDRO_STRIP@|llvm-strip|" \
		-e "s|@CLANDRO_CFLAGS@|${CPPFLAGS} ${CFLAGS}|" \
		-e "s|@CLANDRO_CXXFLAGS@|${CPPFLAGS} ${CXXFLAGS}|" \
		-e "s|@CLANDRO_LDFLAGS@|${LDFLAGS}|" \
		"${CLANDRO_PKG_BUILDER_DIR}/qmake.conf" > "${CLANDRO_PKG_SRCDIR}/mkspecs/termux-cross/qmake.conf"
}

clandro_step_configure () {
	unset CC CXX LD CFLAGS LDFLAGS PKG_CONFIG_PATH

	"${CLANDRO_PKG_SRCDIR}"/configure -v \
		-opensource \
		-confirm-license \
		-release \
		-optimized-tools \
		-xplatform termux-cross \
		-shared \
		-no-rpath \
		-no-use-gold-linker \
		-prefix "${CLANDRO_PREFIX}" \
		-docdir "${CLANDRO_PREFIX}/share/doc/qt" \
		-archdatadir "${CLANDRO_PREFIX}/lib/qt" \
		-datadir "${CLANDRO_PREFIX}/share/qt" \
		-plugindir "${CLANDRO_PREFIX}/libexec/qt" \
		-hostbindir "${CLANDRO_PREFIX}/opt/qt/cross/bin" \
		-hostlibdir "${CLANDRO_PREFIX}/opt/qt/cross/lib" \
		-I "${CLANDRO_PREFIX}/include" \
		-I "${CLANDRO_PREFIX}/include/glib-2.0" \
		-I "${CLANDRO_PREFIX}/lib/glib-2.0/include" \
		-I "${CLANDRO_PREFIX}/include/gio-unix-2.0" \
		-I "${CLANDRO_PREFIX}/include/cairo" \
		-I "${CLANDRO_PREFIX}/include/pango-1.0" \
		-I "${CLANDRO_PREFIX}/include/fribidi" \
		-I "${CLANDRO_PREFIX}/include/harfbuzz" \
		-I "${CLANDRO_PREFIX}/include/atk-1.0" \
		-I "${CLANDRO_PREFIX}/include/pixman-1" \
		-I "${CLANDRO_PREFIX}/include/uuid" \
		-I "${CLANDRO_PREFIX}/include/libxml2" \
		-I "${CLANDRO_PREFIX}/include/freetype2" \
		-I "${CLANDRO_PREFIX}/include/gdk-pixbuf-2.0" \
		-I "${CLANDRO_PREFIX}/include/gtk-3.0" \
		-L "${CLANDRO_PREFIX}/lib" \
		-nomake examples \
		-no-pch \
		-no-accessibility \
		-glib \
		-gtk \
		-icu \
		-system-doubleconversion \
		-system-pcre \
		-system-zlib \
		-system-freetype \
		-ssl \
		-openssl-linked \
		-no-system-proxies \
		-no-cups \
		-system-harfbuzz \
		-opengl \
		-vulkan \
		-qpa xcb \
		-no-eglfs \
		-no-gbm \
		-no-kms \
		-no-linuxfb \
		-no-libudev \
		-no-evdev \
		-no-libinput \
		-no-mtdev \
		-no-tslib \
		-xcb \
		-xcb-xlib \
		-gif \
		-system-libpng \
		-system-libjpeg \
		-system-sqlite \
		-sql-sqlite \
		-posix-ipc

}

clandro_step_post_make_install() {
	#######################################################
	##
	##  Compiling necessary libraries for target.
	##
	#######################################################
	cd "${CLANDRO_PKG_SRCDIR}/src/tools/bootstrap" && {
		make clean

		"${CLANDRO_PREFIX}/opt/qt/cross/bin/qmake" \
			-spec "${CLANDRO_PKG_SRCDIR}/mkspecs/termux-cross" \
			DEFINES+="QT_POSIX_IPC"

		make -j "${CLANDRO_PKG_MAKE_PROCESSES}"
		install -Dm644 ../../../lib/libQt5Bootstrap.a "${CLANDRO_PREFIX}/lib/libQt5Bootstrap.a"
		install -Dm644 ../../../lib/libQt5Bootstrap.prl "${CLANDRO_PREFIX}/lib/libQt5Bootstrap.prl"
	}
	cd "${CLANDRO_PKG_SRCDIR}/src/tools/bootstrap-dbus" && {
		# create the dbus bootstrap archieve but we don't need to install this
		make clean

		"${CLANDRO_PREFIX}/opt/qt/cross/bin/qmake" \
			-spec "${CLANDRO_PKG_SRCDIR}/mkspecs/termux-cross"

		make -j "${CLANDRO_PKG_MAKE_PROCESSES}"
	}

	#######################################################
	##
	##  Compiling necessary programs for target.
	##
	#######################################################
	## Note: qmake can be built only on host so it is omitted here.
	for i in moc qlalr qvkgen rcc uic qdbuscpp2xml qdbusxml2cpp tracegen; do
		cd "${CLANDRO_PKG_SRCDIR}/src/tools/${i}" && {
			if [ -f Makefile ]; then
				make clean
			fi

			"${CLANDRO_PREFIX}/opt/qt/cross/bin/qmake" \
				-spec "${CLANDRO_PKG_SRCDIR}/mkspecs/termux-cross"

			## Fix build failure on at least 'i686'.
			sed \
				-i 's@$(LINK) $(LFLAGS) -o $(TARGET) $(OBJECTS) $(OBJCOMP) $(LIBS)@$(LINK) -o $(TARGET) $(OBJECTS) $(OBJCOMP) $(LIBS) $(LFLAGS) -lz@g' \
				Makefile

			make -j "${CLANDRO_PKG_MAKE_PROCESSES}"
			install -Dm700 "../../../bin/${i}" "${CLANDRO_PREFIX}/bin/${i}"
		}
	done
	unset i

	#######################################################
	##
	##  Fixes & cleanup.
	##
	#######################################################

	# Limit the scope, otherwise it'll touch other Qt files in a dirty host env
	for i in Bootstrap Concurrent Core DBus DeviceDiscoverySupport EdidSupport EventDispatcherSupport FbSupport FontDatabaseSupport Gui InputSupport Network PrintSupport ServiceSupport Sql Test ThemeSupport Widget XcbQpa XkbCommonSupport Xml Zlib; do
		## Drop QMAKE_PRL_BUILD_DIR because reference the build dir.
		find "${CLANDRO_PREFIX}/lib" -type f -name "libQt5${i}.prl" \
			-exec sed -i -e '/^QMAKE_PRL_BUILD_DIR/d' "{}" \;
	done
	unset i
	sed -i -e '/^QMAKE_PRL_BUILD_DIR/d' "${CLANDRO_PREFIX}/opt/qt/cross/lib/libQt5Bootstrap.prl"

	## Remove *.la files.
	find "${CLANDRO_PREFIX}/lib" -iname \*.la -delete
	find "${CLANDRO_PREFIX}/opt/qt/cross/lib" -iname \*.la -delete

	## Create qmake.conf suitable for compiling host tools (for other modules)
	install -Dm644 \
		"${CLANDRO_PKG_BUILDER_DIR}/qplatformdefs.host.h" \
		"${CLANDRO_PREFIX}/lib/qt/mkspecs/termux-host/qplatformdefs.h"
	sed \
		-e "s|@CLANDRO_PREFIX@|${CLANDRO_PREFIX}|g" \
		"${CLANDRO_PKG_BUILDER_DIR}/qmake.host.conf" > "${CLANDRO_PREFIX}/lib/qt/mkspecs/termux-host/qmake.conf"
}

clandro_step_create_debscripts() {
	# Some clean-up is happening via `postinst`
	# Because we're using this package in both host (Ubuntu glibc) and device (Termux)
	cp -f "${CLANDRO_PKG_BUILDER_DIR}/postinst" ./
	sed -i "s|@CLANDRO_PREFIX@|$CLANDRO_PREFIX|g" ./postinst
}
