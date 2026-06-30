CLANDRO_PKG_HOMEPAGE=https://bombadillo.colorfield.space/
CLANDRO_PKG_DESCRIPTION="A non-web client for the terminal, supporting Gopher, Gemini and much more"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.4.0
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=https://deb.debian.org/debian/pool/main/b/bombadillo/bombadillo_${CLANDRO_PKG_VERSION}.orig.tar.gz
CLANDRO_PKG_SHA256=d52a753e7a77c5ab486f536a7c488e61c68a8c11a5e455143d281b3d8306afa0
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	clandro_setup_golang

	go mod init || :
	go mod tidy
}

clandro_step_make() {
	go build
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin bombadillo
	install -Dm600 -t $CLANDRO_PREFIX/share/man/man1 \
		$CLANDRO_PKG_SRCDIR/bombadillo.1
}
