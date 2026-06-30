CLANDRO_PKG_HOMEPAGE=https://libimobiledevice.org
CLANDRO_PKG_DESCRIPTION="A socket daemon to multiplex connections from and to iOS devices"
CLANDRO_PKG_LICENSE="GPL-2.0, GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
_COMMIT=523f7004dce885fe38b4f80e34a8f76dc8ea98b5
_COMMIT_DATE=20250201
CLANDRO_PKG_VERSION=1.1.1-p${_COMMIT_DATE}
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=git+https://github.com/libimobiledevice/usbmuxd
CLANDRO_PKG_SHA256=7943adb00031c05a6db3b7e822b5147e32988c9b79d29fd4656a2e1f733181de
CLANDRO_PKG_GIT_BRANCH=master
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libimobiledevice-glue, libplist, libusb"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--without-preflight
--without-systemd
"

clandro_step_post_get_source() {
	git fetch --unshallow
	git checkout $_COMMIT

	local pdate="p$(git log -1 --format=%cs | sed 's/-//g')"
	if [[ "$CLANDRO_PKG_VERSION" != *"${pdate}" ]]; then
		echo -n "ERROR: The version string \"$CLANDRO_PKG_VERSION\" is"
		echo -n " different from what is expected to be; should end"
		echo " with \"${pdate}\"."
		return 1
	fi

	local s=$(find . -type f ! -path '*/.git/*' -print0 | xargs -0 sha256sum | LC_ALL=C sort | sha256sum)
	if [[ "${s}" != "${CLANDRO_PKG_SHA256}  "* ]]; then
		clandro_error_exit "Checksum mismatch for source files."
	fi
}

clandro_step_pre_configure() {
	autoreconf -fi
}
