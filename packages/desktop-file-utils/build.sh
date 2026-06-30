# cl-andro (alamgir-zk) — ported from termux
CLANDRO_PKG_HOMEPAGE=https://www.freedesktop.org/wiki/Software/desktop-file-utils
CLANDRO_PKG_DESCRIPTION="Command line utilities for working with desktop entries"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.28"
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=https://www.freedesktop.org/software/desktop-file-utils/releases/desktop-file-utils-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=4401d4e231d842c2de8242395a74a395ca468cd96f5f610d822df33594898a70
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="glib"

clandro_step_create_debscripts() {
	for i in postinst prerm triggers; do
		sed \
			-e "s|@CLANDRO_PREFIX@|${CLANDRO_PREFIX}|g" \
			-e "s|@CLANDRO_PACKAGE_FORMAT@|${CLANDRO_PACKAGE_FORMAT}|g" \
			"${CLANDRO_PKG_BUILDER_DIR}/hooks/${i}.in" > ./${i}
		chmod 755 ./${i}
	done
	unset i
	if [[ "$CLANDRO_PACKAGE_FORMAT" == "pacman" ]]; then
		echo "post_install" > postupg
	fi
	chmod 644 ./triggers
}
