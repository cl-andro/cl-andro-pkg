CLANDRO_PKG_HOMEPAGE=https://www.qt.io/
CLANDRO_PKG_DESCRIPTION="Qt Development Tools (Linguist, Assistant, Designer, etc.)"
CLANDRO_PKG_LICENSE="LGPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="5.15.18"
CLANDRO_PKG_SRCURL="https://download.qt.io/archive/qt/${CLANDRO_PKG_VERSION%.*}/${CLANDRO_PKG_VERSION}/submodules/qttools-everywhere-opensource-src-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=931e0969d9f9d8f233e5e9bf9db0cea9ce9914d49982f1795fe6191010113568
CLANDRO_PKG_DEPENDS="libc++, qt5-qtbase, qt5-qtdeclarative"
CLANDRO_PKG_BUILD_DEPENDS="qt5-qtbase-cross-tools, qt5-qtdeclarative-cross-tools"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_NO_STATICSPLIT=true

# Ignore the bootstrap library that is touched by the hijack
CLANDRO_PKG_RM_AFTER_INSTALL="
opt/qt/cross/lib/libQt5Bootstrap.*
opt/qt/cross/lib/libQt5QmlDevTools.*
"

# Replacing the old qt5-base packages
CLANDRO_PKG_REPLACES="qt5-tools"

clandro_step_pre_configure () {
	#######################################################
	##
	##  Hijack the bootstrap library
	##
	#######################################################
	for i in Bootstrap QmlDevTools; do
		cp -p "${CLANDRO_PREFIX}/opt/qt/cross/lib/libQt5${i}.a" \
			"${CLANDRO_PREFIX}/opt/qt/cross/lib/libQt5${i}.a.bak"
		ln -s -f "${CLANDRO_PREFIX}/lib/libQt5${i}.a" \
			"${CLANDRO_PREFIX}/opt/qt/cross/lib/libQt5${i}.a"
		cp -p "${CLANDRO_PREFIX}/opt/qt/cross/lib/libQt5${i}.prl" \
			"${CLANDRO_PREFIX}/opt/qt/cross/lib/libQt5${i}.prl.bak"
		ln -s -f "${CLANDRO_PREFIX}/lib/libQt5${i}.prl" \
			"${CLANDRO_PREFIX}/opt/qt/cross/lib/libQt5${i}.prl"
	done
	unset i
}

clandro_step_configure () {
	"${CLANDRO_PREFIX}/opt/qt/cross/bin/qmake" \
		-spec "${CLANDRO_PREFIX}/lib/qt/mkspecs/termux-cross"
}

clandro_step_post_make_install() {
	#######################################################
	##
	##  Compiling necessary programs for target.
	##
	#######################################################

	## Some top-level tools
	# FIXME: qdoc cannot be built at the moment because qmake couldn't find libclang when built with -I
	for i in makeqpf pixeltool qev qtattributionsscanner; do
		cd "${CLANDRO_PKG_SRCDIR}/src/${i}" && {
			"${CLANDRO_PREFIX}/opt/qt/cross/bin/qmake" \
				-spec "${CLANDRO_PREFIX}/lib/qt/mkspecs/termux-cross"

			make -j "${CLANDRO_PKG_MAKE_PROCESSES}"
			install -Dm700 "../../bin/${i}" "${CLANDRO_PREFIX}/bin/${i}"
		}
	done
	unset i

	# QDbusViewer desktop file (the binary would be installed already)
	install -D -m644 \
		"${CLANDRO_PKG_SRCDIR}/src/qdbus/qdbusviewer/images/qdbusviewer.png" \
		"${CLANDRO_PREFIX}/share/icons/hicolor/32x32/apps/qdbusviewer.png"
	install -D -m644 \
		"${CLANDRO_PKG_SRCDIR}/src/qdbus/qdbusviewer/images/qdbusviewer-128.png" \
		"${CLANDRO_PREFIX}/share/icons/hicolor/128x128/apps/qdbusviewer.png"
	install -D -m644 \
		"${CLANDRO_PKG_BUILDER_DIR}/qdbusviewer.desktop" \
		"${CLANDRO_PREFIX}/share/applications/qdbusviewer.desktop"

	# qdistancefieldgenerator (it has a different directory name but supports make install)
	cd "${CLANDRO_PKG_SRCDIR}/src/distancefieldgenerator" && {
		"${CLANDRO_PREFIX}/opt/qt/cross/bin/qmake" \
			-spec "${CLANDRO_PREFIX}/lib/qt/mkspecs/termux-cross"

		make -j "${CLANDRO_PKG_MAKE_PROCESSES}"
		make install
	}

	#######################################################
	##
	##  Qt Linguist
	##
	#######################################################

	# Install the linguist utilities to the correct path
	for i in lconvert lprodump lrelease{,-pro} lupdate{,-pro}; do
		install -Dm700 "${CLANDRO_PKG_SRCDIR}/bin/${i}" "${CLANDRO_PREFIX}/bin/${i}"
	done

	# Build and install linguist program
	cd "${CLANDRO_PKG_SRCDIR}/src/linguist/linguist" && {
		"${CLANDRO_PREFIX}/opt/qt/cross/bin/qmake" \
			-spec "${CLANDRO_PREFIX}/lib/qt/mkspecs/termux-cross"
		make -j "${CLANDRO_PKG_MAKE_PROCESSES}"
		make install
	}

	# Install the linguist desktop file
	install -Dm644 \
		"${CLANDRO_PKG_SRCDIR}/src/linguist/linguist/images/icons/linguist-32-32.png" \
		"${CLANDRO_PREFIX}/share/icons/hicolor/32x32/apps/linguist.png"
	install -Dm644 \
		"${CLANDRO_PKG_SRCDIR}/src/linguist/linguist/images/icons/linguist-128-32.png" \
		"${CLANDRO_PREFIX}/share/icons/hicolor/128x128/apps/linguist.png"
	install -Dm644 \
		"${CLANDRO_PKG_BUILDER_DIR}/linguist.desktop" \
		"${CLANDRO_PREFIX}/share/applications/linguist.desktop"

	#######################################################
	##
	##  Qt Assistant
	##
	#######################################################

	for i in qcollectiongenerator qhelpgenerator assistant; do
		cd "${CLANDRO_PKG_SRCDIR}/src/assistant/${i}" && {
			"${CLANDRO_PREFIX}/opt/qt/cross/bin/qmake" \
				-spec "${CLANDRO_PREFIX}/lib/qt/mkspecs/termux-cross"

			make -j "${CLANDRO_PKG_MAKE_PROCESSES}"
			install -Dm700 "../../../bin/${i}" "${CLANDRO_PREFIX}/bin/${i}"
		}
	done

	install -Dm644 \
		"${CLANDRO_PKG_SRCDIR}/src/assistant/assistant/images/assistant.png" \
		"${CLANDRO_PREFIX}/share/icons/hicolor/32x32/apps/assistant.png"
	install -Dm644 \
		"${CLANDRO_PKG_SRCDIR}/src/assistant/assistant/images/assistant-128.png" \
		"${CLANDRO_PREFIX}/share/icons/hicolor/128x128/apps/assistant.png"
	install -Dm644 \
		"${CLANDRO_PKG_BUILDER_DIR}/assistant.desktop" \
		"${CLANDRO_PREFIX}/share/applications/assistant.desktop"


	#######################################################
	##
	##  Qt Designer
	##
	#######################################################

	for i in lib components designer plugins; do
		cd "${CLANDRO_PKG_SRCDIR}/src/designer/src/${i}" && {
			"${CLANDRO_PREFIX}/opt/qt/cross/bin/qmake" \
				-spec "${CLANDRO_PREFIX}/lib/qt/mkspecs/termux-cross"

			make -j "${CLANDRO_PKG_MAKE_PROCESSES}"
			make install
		}
	done

	install -Dm644 \
		"${CLANDRO_PKG_SRCDIR}/src/designer/src/designer/images/designer.png" \
		"${CLANDRO_PREFIX}/share/icons/hicolor/128x128/apps/designer.png"
	install -Dm644 \
		"${CLANDRO_PKG_BUILDER_DIR}/designer.desktop" \
		"${CLANDRO_PREFIX}/share/applications/designer.desktop"


	#######################################################
	##
	##  Restore the bootstrap library
	##
	#######################################################
	for i in Bootstrap QmlDevTools; do
		mv "${CLANDRO_PREFIX}/opt/qt/cross/lib/libQt5${i}.a.bak" \
			"${CLANDRO_PREFIX}/opt/qt/cross/lib/libQt5${i}.a"
		mv "${CLANDRO_PREFIX}/opt/qt/cross/lib/libQt5${i}.prl.bak" \
			"${CLANDRO_PREFIX}/opt/qt/cross/lib/libQt5${i}.prl"
	done


	#######################################################
	##
	##  Compiling necessary programs for host
	##
	#######################################################

	# These programs were built and linked for the target
	# We need to build them again but for the host
	cd "${CLANDRO_PKG_SRCDIR}/src/qtattributionsscanner" && {
		make clean
		"${CLANDRO_PREFIX}/opt/qt/cross/bin/qmake" \
			-spec "${CLANDRO_PREFIX}/lib/qt/mkspecs/termux-host"
		make -j "${CLANDRO_PKG_MAKE_PROCESSES}"
		install -Dm700 \
			"../../bin/qtattributionsscanner" \
			"${CLANDRO_PREFIX}/opt/qt/cross/bin/qtattributionsscanner"
	}

	for i in lconvert lprodump lrelease{,-pro} lupdate{,-pro}; do
		cd "${CLANDRO_PKG_SRCDIR}/src/linguist/${i}" && {
			make clean
			"${CLANDRO_PREFIX}/opt/qt/cross/bin/qmake" \
				-spec "${CLANDRO_PREFIX}/lib/qt/mkspecs/termux-host"
			make -j "${CLANDRO_PKG_MAKE_PROCESSES}"
			install -Dm700 "../../../bin/${i}" "${CLANDRO_PREFIX}/opt/qt/cross/bin/${i}"
		}
	done

	#######################################################
	##
	##  Fixes & cleanup.
	##
	#######################################################

	# Limit the scope, otherwise it'll touch qtbase files
	for pref in Designer Help UiTools UiPlugin; do
		## Drop QMAKE_PRL_BUILD_DIR because reference the build dir.
		find "${CLANDRO_PREFIX}/lib" -type f -name "libQt5${pref}*.prl" \
			-exec sed -i -e '/^QMAKE_PRL_BUILD_DIR/d' "{}" \;
	done
	unset pref

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
