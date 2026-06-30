CLANDRO_PKG_HOMEPAGE=https://github.com/XmacsLabs/mogan
CLANDRO_PKG_DESCRIPTION="A structure editor forked from GNU TeXmacs"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.2.9.8"
CLANDRO_PKG_REVISION=5
CLANDRO_PKG_SRCURL="https://github.com/XmacsLabs/mogan/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=70af74dad16816a8097b877dc4cd94202f35517468ab54f6ae6f84ede32746fb
CLANDRO_PKG_DEPENDS="freetype, ghostscript, libandroid-complex-math, libandroid-execinfo, libandroid-spawn, libandroid-wordexp, libc++, libcurl, libgit2, libiconv, libjpeg-turbo, libpng, qt6-qtbase, qt6-qtsvg, zlib"
CLANDRO_PKG_BUILD_DEPENDS="qt6-qtbase-cross-tools"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_RM_AFTER_INSTALL="
lib/libcurl.so
"

clandro_pkg_auto_update() {
	local api_url="https://api.github.com/repos/XmacsLabs/mogan/git/refs/tags"
	local latest_refs_tags=$(curl -s "${api_url}" | jq .[].ref | sed -ne "s|.*v\(.*\)\"|\1|p")
	if [[ -z "${latest_refs_tags}" ]]; then
		echo "WARN: Unable to get latest refs tags from upstream. Try again later." >&2
		return
	fi
	local latest_version=$(echo "${latest_refs_tags}" | grep "^1.2.9." | sort -V | tail -n1)

	clandro_pkg_upgrade_version "${latest_version}"
}

clandro_step_post_get_source() {
	sed \
		"s|@CLANDRO_PREFIX@|${CLANDRO_PREFIX}|" \
		"${CLANDRO_PKG_BUILDER_DIR}/lolly.diff" \
		> "${CLANDRO_PKG_SRCDIR}"/xmake/packages/l/lolly/lolly.diff
	cp -f "${CLANDRO_PKG_BUILDER_DIR}"/s7.diff \
		"${CLANDRO_PKG_SRCDIR}"/xmake/packages/s/s7/s7.diff
	cp -f "${CLANDRO_PKG_BUILDER_DIR}"/moebius.diff \
		"${CLANDRO_PKG_SRCDIR}"/xmake/packages/m/moebius/moebius.diff
}

clandro_step_pre_configure() {
	# this is a workaround for build-all.sh issue
	CLANDRO_PKG_DEPENDS+=", mogan-data"

	clandro_setup_cmake
	clandro_setup_xmake

	# xmake tests -ldl wrongly?
	LD="${CXX}"

	# allows 'scripts/run-docker.sh ./build-package,sh -I -f -a all mogan' to work
	# without causing 'ld.lld: error: /home/builder/.xmake/packages/s/s7/
	# 20241122/2613d5544f43431dad530be0c61b8a28/lib/libs7.a(s7.c.o)
	# is incompatible with armelf_linux_eabi'
	export XMAKE_GLOBALDIR="$CLANDRO_PKG_TMPDIR"

	# for some reason building mogan can corrupt $CLANDRO_PREFIX/lib/libcurl.so
	# and /home/builder/.termux-build/_cache/xmake-2.9.5/bin/xmake ,
	# but if they are backed up, then restored when the build completes, the chance
	# of ruining the builds of other packages after mogan (including repeated builds of mogan)
	# is reduced.
	mkdir -p "$CLANDRO_PKG_TMPDIR/backup_dir"
	export XMAKE_ORIG=$(command -v xmake)
	cp "$CLANDRO_PREFIX/lib/libcurl.so" "$CLANDRO_PKG_TMPDIR/backup_dir/libcurl.so"
	cp "$XMAKE_ORIG" "$CLANDRO_PKG_TMPDIR/backup_dir/xmake"

	if [[ "${CLANDRO_ON_DEVICE_BUILD}" == "false" ]]; then
		install -Dm755 "${CLANDRO_PKG_BUILDER_DIR}/qmake.sh" "${CLANDRO_PKG_TMPDIR}/qmake"
		sed -e "s|@CLANDRO_PREFIX@|${CLANDRO_PREFIX}|g" -i "${CLANDRO_PKG_TMPDIR}/qmake"
		export PATH="${CLANDRO_PKG_TMPDIR}:${CLANDRO_PREFIX}/opt/qt6/cross/bin:${PATH}"
	fi

	command -v qmake
	qmake -query
}

clandro_step_make() {
	local host_platform="${CLANDRO_ARCH}-linux-android"
	case "${CLANDRO_ARCH}" in
	arm) host_platform="armv7a-linux-androideabi" ;;
	esac

	echo "xrepo update-repo"
	xrepo update-repo

	echo "xmake config"
	xmake config \
		--yes \
		--verbose \
		--diagnosis \
		-m releasedbg \
		--sdk="${CLANDRO_STANDALONE_TOOLCHAIN}" \
		--cross="${host_platform}-" \
		--cflags="${CPPFLAGS} ${CFLAGS}" \
		--cxxflags="${CPPFLAGS} ${CXXFLAGS}" \
		--ldflags="${LDFLAGS}"

	echo "xmake build"
	xmake build \
		--yes \
		--verbose \
		--diagnosis \
		--jobs="${CLANDRO_PKG_MAKE_PROCESSES}"
}

clandro_step_make_install() {
	echo "xmake install"
	xmake install \
		--yes \
		--verbose \
		--diagnosis \
		-o "${CLANDRO_PREFIX}" \
		research
}

clandro_step_post_make_install() {
	cp "$CLANDRO_PKG_TMPDIR/backup_dir/libcurl.so" "$CLANDRO_PREFIX/lib/libcurl.so"
	cp "$CLANDRO_PKG_TMPDIR/backup_dir/xmake" "$XMAKE_ORIG"
}
