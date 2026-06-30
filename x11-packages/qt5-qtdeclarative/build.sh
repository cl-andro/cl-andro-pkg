CLANDRO_PKG_HOMEPAGE=https://www.qt.io/
CLANDRO_PKG_DESCRIPTION="The Qt Declarative module provides classes for using GUIs created using QML"
CLANDRO_PKG_LICENSE="LGPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="5.15.18"
CLANDRO_PKG_SRCURL="https://download.qt.io/archive/qt/${CLANDRO_PKG_VERSION%.*}/${CLANDRO_PKG_VERSION}/submodules/qtdeclarative-everywhere-opensource-src-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=876f20c476f07a07c53756b84c8ede7162d455ee0927b995acceb7c64e5c17a7
CLANDRO_PKG_DEPENDS="libc++, qt5-qtbase"
CLANDRO_PKG_BUILD_DEPENDS="qt5-qtbase-cross-tools"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_NO_STATICSPLIT=true

# Ignore bootstrap changes because of the hijacking
CLANDRO_PKG_RM_AFTER_INSTALL="
opt/qt/cross/lib/libQt5Bootstrap.*
"

# Replacing the old qt5-base packages
CLANDRO_PKG_REPLACES="qt5-declarative"

clandro_step_pre_configure () {
	pushd "${CLANDRO_PKG_SRCDIR}/src/qmltyperegistrar"
	"${CLANDRO_PREFIX}/opt/qt/cross/bin/qmake" \
		-spec "${CLANDRO_PREFIX}/lib/qt/mkspecs/termux-host"
	make -j "${CLANDRO_PKG_MAKE_PROCESSES}"
	popd

	#######################################################
	##
	##  Hijack the bootstrap library for cross building
	##
	#######################################################
	for i in a prl; do
		cp -p "${CLANDRO_PREFIX}/opt/qt/cross/lib/libQt5Bootstrap.${i}" \
			"${CLANDRO_PREFIX}/opt/qt/cross/lib/libQt5Bootstrap.${i}.bak"
		ln -s -f "${CLANDRO_PREFIX}/lib/libQt5Bootstrap.${i}" \
			"${CLANDRO_PREFIX}/opt/qt/cross/lib/libQt5Bootstrap.${i}"
	done
	unset i
}

clandro_step_configure () {
	"${CLANDRO_PREFIX}/opt/qt/cross/bin/qmake" \
		-spec "${CLANDRO_PREFIX}/lib/qt/mkspecs/termux-cross"
}

clandro_step_post_make_install () {
	#######################################################
	##
	##  Compiling necessary binaries for target.
	##
	#######################################################

	## Qt Declarative utilities.
	for i in qmlcachegen qmlformat qmlimportscanner qmllint qmlmin; do
		cd "${CLANDRO_PKG_SRCDIR}/tools/${i}" && {
			"${CLANDRO_PREFIX}/opt/qt/cross/bin/qmake" \
				-spec "${CLANDRO_PREFIX}/lib/qt/mkspecs/termux-cross"

			make -j "${CLANDRO_PKG_MAKE_PROCESSES}"
			install -Dm700 "../../bin/${i}" "${CLANDRO_PREFIX}/bin/${i}"
		}
	done

	for i in qmltyperegistrar; do
		cd "${CLANDRO_PKG_SRCDIR}/src/${i}" && {
			make clean

			"${CLANDRO_PREFIX}/opt/qt/cross/bin/qmake" \
				-spec "${CLANDRO_PREFIX}/lib/qt/mkspecs/termux-cross"

			make -j "${CLANDRO_PKG_MAKE_PROCESSES}"
			install -Dm700 "../../bin/${i}" "${CLANDRO_PREFIX}/bin/${i}"
		}
	done

	# Install the QmlDevTools for target (needed by some packages such as qttools)
	install -Dm644 ${CLANDRO_PKG_SRCDIR}/lib/libQt5QmlDevTools.a "${CLANDRO_PREFIX}/lib/libQt5QmlDevTools.a"
	install -Dm644 ${CLANDRO_PKG_SRCDIR}/lib/libQt5QmlDevTools.prl "${CLANDRO_PREFIX}/lib/libQt5QmlDevTools.prl"
	sed -i 's|/opt/qt/cross/|/|g' "${CLANDRO_PREFIX}/lib/libQt5QmlDevTools.prl"

	#######################################################
	##
	##  Restore the bootstrap library
	##
	#######################################################
	for i in a prl; do
		rm -f "${CLANDRO_PREFIX}/opt/qt/cross/lib/libQt5Bootstrap.${i}"
		cp -p "${CLANDRO_PREFIX}/opt/qt/cross/lib/libQt5Bootstrap.${i}.bak" \
			"${CLANDRO_PREFIX}/opt/qt/cross/lib/libQt5Bootstrap.${i}"
		rm -f "${CLANDRO_PREFIX}/opt/qt/cross/lib/libQt5Bootstrap.${i}.bak"
	done
	unset i

	#######################################################
	##
	##  Compiling necessary binaries for the host
	##
	#######################################################

	## libQt5QmlDevTools.a (qt5-declarative)
	cd "${CLANDRO_PKG_SRCDIR}/src/qmldevtools" && {
		make clean

		"${CLANDRO_PREFIX}/opt/qt/cross/bin/qmake" \
			-spec "${CLANDRO_PREFIX}/lib/qt/mkspecs/termux-host"

		make -j "${CLANDRO_PKG_MAKE_PROCESSES}"
		install -Dm644 ../../lib/libQt5QmlDevTools.a "${CLANDRO_PREFIX}/opt/qt/cross/lib/libQt5QmlDevTools.a"
		install -Dm644 ../../lib/libQt5QmlDevTools.prl "${CLANDRO_PREFIX}/opt/qt/cross/lib/libQt5QmlDevTools.prl"
	}

	## Qt Declarative utilities.
	for i in qmlcachegen qmlformat qmlimportscanner qmllint qmlmin; do
		cd "${CLANDRO_PKG_SRCDIR}/tools/${i}" && {
			make clean

			"${CLANDRO_PREFIX}/opt/qt/cross/bin/qmake" \
				-spec "${CLANDRO_PREFIX}/lib/qt/mkspecs/termux-host"

			make -j "${CLANDRO_PKG_MAKE_PROCESSES}"
			install -Dm700 "../../bin/${i}" "${CLANDRO_PREFIX}/opt/qt/cross/bin/${i}"
		}
	done

	for i in qmltyperegistrar; do
		cd "${CLANDRO_PKG_SRCDIR}/src/${i}" && {
			make clean

			"${CLANDRO_PREFIX}/opt/qt/cross/bin/qmake" \
				-spec "${CLANDRO_PREFIX}/lib/qt/mkspecs/termux-host"

			make -j "${CLANDRO_PKG_MAKE_PROCESSES}"
			install -Dm700 "../../bin/${i}" "${CLANDRO_PREFIX}/opt/qt/cross/bin/${i}"
		}
	done

	#######################################################
	##
	##  Fixes & cleanup.
	##
	#######################################################

	# Limit the scope, otherwise it'll touch qtbase files
	for pref in Qml Quick Packet; do
		## Drop QMAKE_PRL_BUILD_DIR because reference the build dir.
		find "${CLANDRO_PREFIX}/lib" -type f -name "libQt5${pref}*.prl" \
			-exec sed -i -e '/^QMAKE_PRL_BUILD_DIR/d' "{}" \;
	done
	unset pref
	sed -i -e '/^QMAKE_PRL_BUILD_DIR/d' "${CLANDRO_PREFIX}/opt/qt/cross/lib/libQt5QmlDevTools.prl"

	## Remove *.la files.
	find "${CLANDRO_PREFIX}/lib" -iname \*.la -delete
	find "${CLANDRO_PREFIX}/opt/qt/cross/lib" -iname \*.la -delete
}

clandro_step_create_debscripts() {
	# Some clean-up is happening via `postinst`
	# Because we're using this package in both host (Ubuntu glibc) and device (Termux)
	cp -f "${CLANDRO_PKG_BUILDER_DIR}/postinst" ./
	sed -i "s|@CLANDRO_PREFIX@|$CLANDRO_PREFIX|g" ./postinst
}
