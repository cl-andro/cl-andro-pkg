CLANDRO_PKG_HOMEPAGE=https://simulide.com/p/
CLANDRO_PKG_DESCRIPTION="Simple real time electronic circuit simulator"
CLANDRO_PKG_LICENSE="AGPL-V3"
CLANDRO_PKG_MAINTAINER="@clandro"
_COMMIT=13cb963d9aae083b22e3446fafdfbcb1a3af7310
CLANDRO_PKG_VERSION=2025.10.29
CLANDRO_PKG_SRCURL=git+https://github.com/eeTools/SimulIDE-dev
CLANDRO_PKG_SHA256=73d85be6baad944a709c470088a47e5da1dd939bcc67343134027921891e843c
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_GIT_BRANCH=master
CLANDRO_PKG_DEPENDS="libc++, libelf, qt5-qtbase, qt5-qtmultimedia, qt5-qtscript, qt5-qtserialport, qt5-qtsvg, simulide-data"
CLANDRO_PKG_BUILD_DEPENDS="dos2unix, qt5-qtbase-cross-tools, qt5-qttools-cross-tools"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_post_get_source() {
	git fetch --unshallow
	git checkout $_COMMIT

	local version="$(git log -1 --format=%cs | sed 's/-/./g')"
	if [ "$version" != "$CLANDRO_PKG_VERSION" ]; then
		echo -n "ERROR: The specified version \"$CLANDRO_PKG_VERSION\""
		echo " is different from what is expected to be: \"$version\""
		return 1
	fi

	local s=$(find . -type f ! -path '*/.git/*' -print0 | xargs -0 sha256sum | LC_ALL=C sort | sha256sum)
	if [[ "${s}" != "${CLANDRO_PKG_SHA256}  "* ]]; then
		clandro_error_exit "Checksum mismatch for source files."
	fi

	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		DOS2UNIX="$CLANDRO_PKG_TMPDIR/dos2unix"
		(. "$CLANDRO_SCRIPTDIR/packages/dos2unix/build.sh"; CLANDRO_PKG_SRCDIR="$DOS2UNIX" clandro_step_get_source)
		pushd "$DOS2UNIX"
		make dos2unix
		popd # DOS2UNIX
		export PATH="$DOS2UNIX:$PATH"
	fi

	find "$CLANDRO_PKG_SRCDIR" -type f -print0 | xargs -0 dos2unix
}

clandro_step_pre_configure() {
	CLANDRO_PKG_BUILDDIR+="/build_XX"
	export PATH="$CLANDRO_PREFIX/opt/qt/cross/bin:$PATH"
}

clandro_step_configure() {
	qmake -spec "$CLANDRO_PREFIX/lib/qt/mkspecs/termux-cross"
}

clandro_step_make_install() {
	install -Dm755 -t "$CLANDRO_PREFIX/bin" \
		"$CLANDRO_PKG_BUILDDIR"/executables/*/simulide
	install -Dm644 -t "$CLANDRO_PREFIX/share/applications" \
		"$CLANDRO_PKG_SRCDIR/resources/simulide.desktop"
	install -Dm644 -t "$CLANDRO_PREFIX/share/pixmaps" \
		"$CLANDRO_PKG_SRCDIR/resources/icons/simulide.png"
	install -Dm644 "$CLANDRO_PKG_SRCDIR/resources/simulide-mime.xml" \
		"$CLANDRO_PREFIX/share/mime/packages/simulide.xml"
	rm -rf "$CLANDRO_PREFIX/share/simulide" \
		"$CLANDRO_PKG_SRCDIR"/resources/{icons,readme,simulide-mime.xml,simulide.desktop}
	mkdir -p "$CLANDRO_PREFIX/share"
	mv "$CLANDRO_PKG_SRCDIR"/resources "$CLANDRO_PREFIX/share/simulide"
}
