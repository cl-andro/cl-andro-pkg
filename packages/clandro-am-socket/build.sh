CLANDRO_PKG_HOMEPAGE=https://github.com/cl-andro/clandro-am-socket
CLANDRO_PKG_DESCRIPTION="A faster version of am with less features that only works while Termux is running"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.5.0
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/cl-andro/clandro-am-socket/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=d5558cd419c8d46bdc958064cb97f963d1ea793866414c025906ec15033512ed
CLANDRO_PKG_DEPENDS="libc++"

clandro_step_post_get_source() {

	for file in "${CLANDRO_PKG_SRCDIR}/"*; do
		sed -i'' -E -e "s|^(CLANDRO_AM_SOCKET_VERSION=).*|\1$CLANDRO_PKG_FULLVERSION|" \
			-e "s|\@CLANDRO_PREFIX\@|${CLANDRO_PREFIX}|g" \
			-e "s|\@CLANDRO_APP_PACKAGE\@|${CLANDRO_APP_PACKAGE}|g" \
			-e "s|\@CLANDRO_APPS_DIR\@|${CLANDRO_APPS_DIR}|g" \
			"$file"
	done

}
