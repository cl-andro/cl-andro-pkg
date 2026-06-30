CLANDRO_PKG_HOMEPAGE=https://invisible-island.net/dialog/
CLANDRO_PKG_DESCRIPTION="Application used in shell scripts which displays text user interface widgets"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_DEPENDS="libandroid-support, ncurses"
CLANDRO_PKG_VERSION="1.3-20260107"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://invisible-island.net/archives/dialog/dialog-${CLANDRO_PKG_VERSION}.tgz"
CLANDRO_PKG_SHA256=78b3dd18d95e50f0be8f9b9c1e7cffe28c9bf1cdf20d5b3ef17279c4da35c5b5
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_ON_DEVICE_BUILD_NOT_SUPPORTED=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--with-ncursesw
--enable-widec
--with-pkg-config
"

clandro_pkg_auto_update() {
	local latest_version="$(curl --silent \
		https://invisible-island.net/datafiles/release/dialog.tar.gz | \
		tar --exclude='*/*' -tz | \
		sed 's|dialog-\(.*\)/|\1|')"

	clandro_pkg_upgrade_version "${latest_version}"
}

clandro_step_pre_configure() {
	# Put a temporary link for libtinfo.so
	ln -sf "$CLANDRO_PREFIX/lib/libncursesw.so" "$CLANDRO_PREFIX/lib/libtinfo.so"
}

clandro_step_post_make_install() {
	rm "$CLANDRO_PREFIX/lib/libtinfo.so"
}
