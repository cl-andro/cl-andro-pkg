CLANDRO_PKG_HOMEPAGE=https://freedesktop.org/Software/shared-mime-info
CLANDRO_PKG_DESCRIPTION="Freedesktop.org Shared MIME Info"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.4"
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_SRCURL=https://gitlab.freedesktop.org/xdg/shared-mime-info/-/archive/${CLANDRO_PKG_VERSION}/shared-mime-info-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=531291d0387eb94e16e775d7e73788d06d2b2fdd8cd2ac6b6b15287593b6a2de
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="coreutils, glib, libxml2"

clandro_step_create_debscripts() {
	for i in $(test "$CLANDRO_PACKAGE_FORMAT" != "pacman" && echo postinst) postrm triggers; do
		cp "${CLANDRO_PKG_BUILDER_DIR}/${i}" ./${i}
		sed -i -e "s|@CLANDRO_PREFIX@|$CLANDRO_PREFIX|g" \
			-e "s|@CLANDRO_PACKAGE_FORMAT@|${CLANDRO_PACKAGE_FORMAT}|g" ./${i}
	done
	unset i
}
