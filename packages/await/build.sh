CLANDRO_PKG_HOMEPAGE=https://github.com/slavaGanzin/await
CLANDRO_PKG_DESCRIPTION="Runs list of commands in parallel and waits for their termination"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.6.0"
CLANDRO_PKG_SRCURL=https://github.com/slavaGanzin/await/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=19695cac1f98d9a5b4d83594f200acae961dca6dafc3a414c20abf81c3be49da
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make() {
	$CC $CPPFLAGS $CFLAGS "$CLANDRO_PKG_SRCDIR"/await.c -o await $LDFLAGS
}

clandro_step_make_install() {
	install -Dm700 -t "$CLANDRO_PREFIX/bin" await
}
