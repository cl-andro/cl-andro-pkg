CLANDRO_PKG_HOMEPAGE=https://www.dmulholl.com/dev/mp3cat.html
CLANDRO_PKG_DESCRIPTION="A command line utility for joining MP3 files."
CLANDRO_PKG_LICENSE="Unlicense"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=4.2.2
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=https://github.com/dmulholl/mp3cat/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=457e680e5b05e8a5a50a8b557372e23bf797026f43253efdff14b8137f214470
CLANDRO_PKG_CONFLICTS="mp3cat"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make() {
	clandro_setup_golang
	go build
}

clandro_step_make_install() {
	install -Dm700 mp3cat $CLANDRO_PREFIX/bin/
}
