CLANDRO_PKG_HOMEPAGE=https://curlie.io/
CLANDRO_PKG_DESCRIPTION="The power of curl, the ease of use of httpie"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.8.2"
CLANDRO_PKG_SRCURL=git+https://github.com/rs/curlie
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make() {
	clandro_setup_golang

	go mod init || :
	go mod tidy
	go build
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin curlie
}
